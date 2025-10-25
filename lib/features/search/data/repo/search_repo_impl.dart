import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:litlore/core/errors/failures.dart';
import 'package:litlore/core/errors/server_failure.dart';
import 'package:litlore/core/network/remote/app_dio.dart';
import 'package:litlore/core/utils/urls.dart';
import 'package:litlore/features/home/data/models/book_model/book_model.dart';
import 'package:litlore/features/search/data/repo/search_repo.dart';

class SearchRepoImpl implements SearchRepo {
  final AppDio apiService;

  SearchRepoImpl({required this.apiService});
  @override
  Future<Either<Failures, List<BookModel>>> searchBooks(
    String query, {
    String? filter,
    String? orderBy,
    String? contentType,
  }) async {
    try {
      var response = await apiService.get(
        path: Urls.searchBooks(
          query,
          filter: filter,
          orderBy: orderBy,
          contentType: contentType,
        ),
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
}
