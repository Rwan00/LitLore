import 'package:dartz/dartz.dart';
import 'package:litlore/core/errors/failures.dart';
import 'package:litlore/features/home/data/models/book_model/book_model.dart';

abstract class BookDetailsRepo {
  Future<Either<Failures, List<BookModel>>> fetchSimilarBooks({
    required String category,
  });
}
