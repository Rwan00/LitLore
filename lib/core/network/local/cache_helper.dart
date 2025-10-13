

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:litlore/core/utils/app_consts.dart' show logger;
import 'package:nb_utils/nb_utils.dart';

class AppCacheHelper {
  static final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );

  // Keys for secure storage (sensitive data)
  static const String accessTokenKey = 'accessToken';
  static const String refreshTokenKey = 'refreshToken';
  static const String resetTokenKey = 'resetToken';
 

  

  static Future<void> saveRegistrationData({
    required String token,
    required String refreshToken,
   
  }) async {
    try {
      // Save tokens in secure storage WITH fallback
      await cacheSecureString(key: accessTokenKey, value: token);
      await cacheSecureString(key: refreshTokenKey, value: refreshToken);

     

    } catch (e) {
      print('Error saving registration data: $e');
      rethrow;
    }
  }

 
  static Future<void> signOut() async {
    try {
      // Clear all secure storage data
      await deleteSecureCache(key: accessTokenKey);
      await deleteSecureCache(key: refreshTokenKey);
      await deleteSecureCache(key: resetTokenKey);
  

      // Clear all shared preferences (comprehensive cleanup)
      await clearSharedPref();

      // Clear all secure storage (comprehensive cleanup)
      await _storage.deleteAll();
    } catch (e) {
      // Fallback: Clear everything using regular storage methods
      try {
        // Clear all the keys we know about
        deleteCache(key: accessTokenKey);
        deleteCache(key: refreshTokenKey);
        deleteCache(key: resetTokenKey);
  
        await clearSharedPref();

        // Try to clear all secure storage as fallback
        await _storage.deleteAll();
      } catch (fallbackError) {
        print('Error during fallback cache clearing: $fallbackError');
        // Even if there's an error, continue with logout
      }
    }
  }


  // FIXED: Secure storage methods with proper fallback
  static Future<void> cacheSecureString({required String key, required String value}) async {
    try {
      // Try to save in secure storage first
      await _storage.write(key: key, value: value);
      print('Successfully saved $key to secure storage');
    } catch (e) {
      logger.e('Failed to save $key to secure storage: $e. Using fallback to regular storage.');
      // Fallback to regular storage AND save both locations for reliability
      cacheString(key: key, value: value);
    }

    // ALWAYS save a backup copy in regular storage for critical auth tokens
    if (key == accessTokenKey || key == refreshTokenKey) {
      try {
        cacheString(key: '${key}_backup', value: value);
        print('Backup saved for $key in regular storage');
      } catch (backupError) {
        print('Failed to save backup for $key: $backupError');
      }
    }
  }

  static Future<String> getSecureString({required String key}) async {
    try {
      // Try secure storage first
      final token = await _storage.read(key: key);
      if (token != null && token.isNotEmpty) {
        logger.i('Successfully retrieved $key from secure storage');
        return token;
      }
    } catch (e) {
      logger.e('Failed to read $key from secure storage: $e');
    }

    // Try backup in regular storage for auth tokens
    if (key == accessTokenKey || key == refreshTokenKey) {
      try {
        final backupToken = getCacheString(key: '${key}_backup');
        if (backupToken.isNotEmpty) {
          logger.i('Retrieved $key from backup in regular storage');
          return backupToken;
        }
      } catch (backupError) {
        logger.e('Failed to read backup for $key: $backupError');
      }
    }

    // Final fallback to regular storage
    try {
      final regularToken = getCacheString(key: key);
      if (regularToken.isNotEmpty) {
        print('Retrieved $key from regular storage fallback');
        return regularToken;
      }
    } catch (e) {
      print('Failed to read $key from regular storage: $e');
    }

    print('No token found for $key in any storage location');
    return '';
  }

  static Future<void> deleteSecureCache({required String key}) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      print('Failed to delete $key from secure storage: $e');
    }

    // Also delete from regular storage fallback
    deleteCache(key: key);

    // Delete backup if it exists
    if (key == accessTokenKey || key == refreshTokenKey) {
      deleteCache(key: '${key}_backup');
    }
  }

  // Regular storage methods (for non-sensitive data)
  static void cacheString({required String key, required dynamic value}) {
    try {
      setValue(key, value);
    } catch (e) {
      print('Error caching string for key $key: $e');
    }
  }

  static String getCacheString({required String key}) {
    try {
      return getStringAsync(key);
    } catch (e) {
      print('Error getting cached string for key $key: $e');
      return '';
    }
  }

  static int getCacheInt({required String key}) {
    try {
      return getIntAsync(key);
    } catch (e) {
      print('Error getting cached int for key $key: $e');
      return 0;
    }
  }

  static void deleteCache({required String key}) {
    try {
      removeKey(key);
    } catch (e) {
      print('Error deleting cache for key $key: $e');
    }
  }

  static bool getCachedBool({required String key}) {
    try {
      return getBoolAsync(key);
    } catch (e) {
      print('Error getting cached bool for key $key: $e');
      return false;
    }
  }

  // Helper methods
  static Future<void> clearAuthData() async {
    try {
      // Clear secure storage
      await deleteSecureCache(key: accessTokenKey);
      await deleteSecureCache(key: refreshTokenKey);

   
    } catch (e) {
      print('Error clearing auth data: $e');
      // Fallback: clear all regular storage
      deleteCache(key: accessTokenKey);
      deleteCache(key: refreshTokenKey);
      deleteCache(key: '${accessTokenKey}_backup');
      deleteCache(key: '${refreshTokenKey}_backup');
      
    }
  }

  // FIXED: More robust login check
  static Future<bool> isLoggedIn() async {
    try {
      final token = await getSecureString(key: accessTokenKey);
      final isLoggedIn = token.isNotEmpty;
      print('Login check result: $isLoggedIn (token length: ${token.length})');
      return isLoggedIn;
    } catch (e) {
      print('Error checking login status: $e');
      return false;
    }
  }

  static Future<void> checkFirstInstall() async {
    final isFirst = getBoolAsync('first_install', defaultValue: true);

    if (isFirst) {
      await _storage.deleteAll();
      cacheString(key: 'first_install', value: false);
    }
  }

  // ADDED: Debug method to check storage state
  static Future<void> debugStorageState() async {
    print('=== STORAGE DEBUG ===');
    try {
      final secureToken = await _storage.read(key: accessTokenKey);
      print(
          'Secure storage token: ${secureToken?.isNotEmpty == true ? 'EXISTS (${secureToken!.length} chars)' : 'EMPTY/NULL'}');
    } catch (e) {
      print('Secure storage read error: $e');
    }

    try {
      final regularToken = getCacheString(key: accessTokenKey);
      print('Regular storage token: ${regularToken.isNotEmpty ? 'EXISTS (${regularToken.length} chars)' : 'EMPTY'}');
    } catch (e) {
      print('Regular storage read error: $e');
    }

    try {
      final backupToken = getCacheString(key: '${accessTokenKey}_backup');
      print('Backup token: ${backupToken.isNotEmpty ? 'EXISTS (${backupToken.length} chars)' : 'EMPTY'}');
    } catch (e) {
      print('Backup token read error: $e');
    }
    print('===================');
  }
}
