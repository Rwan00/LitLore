import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:litlore/core/errors/failures.dart';
import 'package:litlore/core/network/remote/api_service.dart';
import 'package:litlore/features/home/data/models/book_model/book_model.dart';
import 'package:litlore/features/home/data/repos/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final AppService appService;

  HomeRepoImpl({required this.appService});
  @override
  Future<Either<Failures, List<BookModel>>> fetchRecommendedBooks() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, List<BookModel>>> fetchNewestBooks() async {
    try {
      var data = await appService.get(
          endPoint: "volumes?q=subject: api&Sorting=newest");
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
