import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:litlore/core/network/remote/api_service.dart';
import 'package:litlore/features/home/data/repos/home_repo/home_repo_impl.dart';

abstract class ServiceLocator {
 static final getIt = GetIt.instance;

static void setup() {
   
  getIt.registerSingleton<ApiService>(
    ApiService(
      Dio(),
    ),
  );
  getIt.registerSingleton<HomeRepoImpl>(
    HomeRepoImpl(
      apiService: getIt.get<ApiService>(),
    ),
  );
}
}
