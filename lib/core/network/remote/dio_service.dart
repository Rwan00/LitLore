import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:litlore/core/network/local/cache_helper.dart';
import 'package:litlore/core/network/local/navigation_services.dart';

import 'package:litlore/core/utils/app_consts.dart';
import 'package:litlore/core/utils/urls.dart';
import 'package:litlore/features/authentication/presentation/views/register_view.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioService {
  DioService._() {
    _dio = Dio();
    _initializeDio();
  }

  static DioService? _instance;
  late Dio _dio;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _initializeDio() {
    final BaseOptions baseOptions = BaseOptions(
      baseUrl: Urls.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {'Content-Type': 'application/json'},
    );

    _dio.options = baseOptions;

    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: false,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );

    // Handle 403 errors (Forbidden)
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException e, ErrorInterceptorHandler handler) async {
          if (e.response?.statusCode == 403) {
            await _handleAuthenticationFailure();
            'You are not logged in, please login again'.toastString();
            NavigationService.goTo(RegisterView.routeName);
            return handler.reject(e);
          }
          return handler.next(e);
        },
      ),
    );

    // Handle 401 errors (Unauthorized) - Refresh Firebase token
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException e, ErrorInterceptorHandler handler) async {
          if (e.response?.statusCode == 401) {
            final newToken = await refreshFirebaseToken();
            if (newToken != null) {
              // Retry the original request with the new token
              final options = e.requestOptions;
              options.headers['Authorization'] = '$newToken';
              
              try {
                final cloneReq = await _dio.request(
                  options.path,
                  options: Options(
                    method: options.method,
                    headers: options.headers,
                  ),
                  data: options.data,
                  queryParameters: options.queryParameters,
                );
                return handler.resolve(cloneReq);
              } catch (retryError) {
                return handler.reject(e);
              }
            } else {
              // Token refresh failed, logout user
              await _handleAuthenticationFailure();
              'You are not logged in, please login again'.toastString();
              NavigationService.goTo(RegisterView.routeName);
              return handler.reject(e);
            }
          }
          return handler.next(e);
        },
      ),
    );
  }

  static DioService get instance {
    _instance ??= DioService._();
    return _instance!;
  }

  static Dio get dio => instance._dio;

  /// Get headers with Firebase ID token
  Future<Map<String, String>> getHeaders({bool withToken = true}) async {
    final headers = <String, String>{'Content-Type': 'application/json'};

    if (withToken) {
      // Get Firebase ID token instead of backend token
      final token = await getFirebaseIdToken();

      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = '$token';
      }
    }

    return headers;
  }

  /// Get Firebase ID token from current user
  Future<String?> getFirebaseIdToken({bool forceRefresh = false}) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        print('❌ No authenticated Firebase user');
        return null;
      }

      // Get ID token (force refresh if needed)
      final idToken = await user.getIdToken(forceRefresh);
      
      if (idToken != null && idToken.isNotEmpty) {
        // Update cache with fresh token
        await AppCacheHelper.cacheSecureString(
          key: AppCacheHelper.accessTokenKey,
          value: idToken,
        );
        print('✅ Firebase ID token retrieved successfully');
      }
      
      return idToken;
    } catch (e) {
      print('❌ Error getting Firebase ID token: $e');
      return null;
    }
  }

  /// Refresh Firebase ID token
  Future<String?> refreshFirebaseToken() async {
    try {
      print('🔄 Refreshing Firebase ID token...');
      
      // Force refresh the Firebase ID token
      final newToken = await getFirebaseIdToken(forceRefresh: true);
      
      if (newToken != null && newToken.isNotEmpty) {
        // Update AppConsts if you're using it
        AppConsts.accessToken = newToken;
        
        print('✅ Firebase ID token refreshed successfully');
        return newToken;
      } else {
        print('❌ Failed to refresh Firebase ID token');
        return null;
      }
    } catch (e) {
      print('❌ Error refreshing Firebase token: $e');
      return null;
    }
  }

  /// Handle authentication failure (logout user)
  Future<void> _handleAuthenticationFailure() async {
    try {
      // Clear tokens from cache
      AppConsts.accessToken = '';
      AppConsts.refreshToken = '';
      
      await AppCacheHelper.deleteSecureCache(
        key: AppCacheHelper.accessTokenKey,
      );
      await AppCacheHelper.deleteSecureCache(
        key: AppCacheHelper.refreshTokenKey,
      );
      
      AppCacheHelper.deleteCache(key: AppCacheHelper.accessTokenKey);
      AppCacheHelper.deleteCache(key: AppCacheHelper.refreshTokenKey);
      
      // Sign out from Firebase
      await _auth.signOut();
      
      await AppCacheHelper.signOut();
      
      print('🚪 User logged out due to authentication failure');
    } catch (e) {
      print('❌ Error during authentication failure handling: $e');
    }
  }

  /// Send HTTP request with Firebase authentication
  Future<Response> sendRequest({
    required String method,
    required String path,
    dynamic data,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
    bool withToken = true,
  }) async {
    try {
      // Get headers with Firebase token
      final requestHeaders = headers ?? await getHeaders(withToken: withToken);
      
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParams,
        options: Options(
          method: method,
          headers: requestHeaders,
        ),
      );
      
      return response;
    } on DioException {
      rethrow;
    }
  }

  /// Get Google Books API access token (separate from Firebase ID token)
  /// This should be stored separately when user links Google account
  Future<String?> getGoogleBooksAccessToken() async {
    try {
      // You might want to store this in a separate cache key
      final token = await AppCacheHelper.getSecureString(
        key: 'google_books_access_token',
      );
      
      return token.isNotEmpty ? token : null;
    } catch (e) {
      print('❌ Error getting Google Books access token: $e');
      return null;
    }
  }

  /// Send request to Google Books API with Google access token
  Future<Response> sendGoogleBooksRequest({
    required String method,
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      // Get Google Books access token (not Firebase token)
      final googleToken = await getGoogleBooksAccessToken();
      
      final headers = <String, String>{
        'Content-Type': 'application/json',
      };
      
      if (googleToken != null && googleToken.isNotEmpty) {
        headers['Authorization'] = '$googleToken';
      }
      
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParams,
        options: Options(
          method: method,
          headers: headers,
        ),
      );
      
      return response;
    } on DioException {
      rethrow;
    }
  }
}