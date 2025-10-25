import 'package:dartz/dartz.dart';
import 'package:litlore/core/errors/failures.dart';
import 'package:litlore/features/home/data/models/book_model/book_model.dart';

abstract class SearchRepo {
  Future<Either<Failures, BooksResponse>> searchBooks(
    String query,
    int startIndex, {
    String? filter,
    String? orderBy,
    String? contentType,
  });
}
