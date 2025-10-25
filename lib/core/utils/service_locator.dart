
import 'package:get_it/get_it.dart';
import 'package:litlore/core/network/remote/app_dio.dart';

import 'package:litlore/features/authentication/data/repos/authentication_repo_impl.dart';

import 'package:litlore/features/home/data/repos/book_details_repo/book_details_repo_impl.dart';
import 'package:litlore/features/home/data/repos/home_repo/home_repo_impl.dart';
import 'package:litlore/features/search/data/repo/search_repo_impl.dart';

abstract class ServiceLocator {
  static final getIt = GetIt.instance;

  static void setup() {
    getIt.registerSingleton<AppDio>(
      AppDio(
     
      ),
    );
    getIt.registerSingleton<HomeRepoImpl>(
      HomeRepoImpl(
        apiService: getIt.get<AppDio>(),
      ),
    );
    getIt.registerSingleton<BookDetailsRepoImpl>(
      BookDetailsRepoImpl(
        apiService: getIt.get<AppDio>(),
      ),
    );
    getIt.registerSingleton<AuthenticationRepoImpl>(
     AuthenticationRepoImpl(),
    );
    getIt.registerSingleton<SearchRepoImpl>(
     SearchRepoImpl( apiService: getIt.get<AppDio>(),),
    );
  }
}
