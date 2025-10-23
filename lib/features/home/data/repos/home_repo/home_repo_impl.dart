import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:litlore/core/errors/failures.dart';
import 'package:litlore/core/network/remote/app_dio.dart';
import 'package:litlore/core/utils/app_consts.dart';

import 'package:litlore/core/utils/urls.dart';
import 'package:litlore/features/home/data/models/book_model/book_model.dart';

import 'package:litlore/features/home/data/repos/home_repo/home_repo.dart';

import '../../../../../core/errors/server_failure.dart';

class HomeRepoImpl implements HomeRepo {
  final AppDio apiService;

  HomeRepoImpl({required this.apiService});
  @override
  Future<Either<Failures, List<BookModel>>> fetchDiscoverBooks() async {
    try {
      var response = await apiService.get(
        path: Urls.discoverBooksBySubject("general"),
      );
      List<BookModel> books = [];
      for (var item in response.data["items"]) {
        books.add(BookModel.fromJson(item));
      }
      return right(books);
    } on DioException catch (error) {
      log(error.message ?? "");
      return left(ServerFailure.fromDioError(error));
    } catch (error) {
      return left(ServerFailure(errorMsg: error.toString()));
    }
  }

  @override
  Future<Either<Failures, List<BookModel>>> fetchNewestBooks() async {
    try {
      var response = await apiService.get(path: Urls.newestBooks);
      List<BookModel> books = [];
      for (var item in response.data["items"]) {
        books.add(BookModel.fromJson(item));
      }
      return right(books);
    } on DioException catch (error) {
       logger.e(error);
      return left(ServerFailure.fromDioError(error));
    } catch (error) {
      logger.e(error);
      return left(ServerFailure(errorMsg: error.toString()));
    }
  }
}
