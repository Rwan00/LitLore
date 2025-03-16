import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:litlore/core/errors/failures.dart';
import 'package:litlore/core/network/remote/api_service.dart';
import 'package:litlore/features/home/data/models/book_model/book_model.dart';
import 'package:litlore/features/home/data/repos/home_repo/home_endpoints.dart';
import 'package:litlore/features/home/data/repos/home_repo/home_repo.dart';

import '../../../../../core/errors/server_failure.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiService apiService;

  HomeRepoImpl({required this.apiService});
  @override
  Future<Either<Failures, List<BookModel>>> fetchDiscoverBooks() async {
    try {
      var data = await apiService.get(
        endPoint: HomeEndpoints.discoverBookEndpoint,
      );
      List<BookModel> books = [];
      for (var item in data["items"]) {
        books.add(BookModel.fromJson(item));
      }
      return right(books);
    } on DioException catch (error) {
      log(error.message ?? "");
      return left(ServerFailure.fromDioError(error));
    } catch (error) {
      return left(
        ServerFailure(
          errorMsg: error.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, List<BookModel>>> fetchNewestBooks() async {
    try {
      var data = await apiService.get(
        endPoint: HomeEndpoints.newestBookEndpoint,
      );
      List<BookModel> books = [];
      for (var item in data["items"]) {
        books.add(BookModel.fromJson(item));
      }
      return right(books);
    } on DioException catch (error) {
      log(error.message ?? "");
      return left(ServerFailure.fromDioError(error));
    } catch (error) {
      return left(
        ServerFailure(
          errorMsg: error.toString(),
        ),
      );
    }
  }
}
