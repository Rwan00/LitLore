import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:litlore/core/errors/failures.dart';

import 'package:litlore/features/home/data/models/book_model/book_model.dart';


import '../../../../../core/errors/server_failure.dart';
import '../../../../../core/network/remote/api_service.dart';
import 'book_details_repo.dart';

class BookDetailsRepoImpl implements BookDetailsRepo {
  final ApiService apiService;

  BookDetailsRepoImpl({required this.apiService});

  @override
  Future<Either<Failures, List<BookModel>>> fetchSimilarBooks({required String category}) async{
 
    try {
      var data = await apiService.get(
        endPoint: "volumes?q=$category+subject:&orderBy=relevance",
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

