import 'package:dartz/dartz.dart';
import 'package:litlore/core/errors/failures.dart';
import 'package:litlore/features/home/data/models/book_model/book_model.dart';

abstract class HomeRepo {
 Future<Either<Failures,List<BookModel>>> fetchNewestBooks();
  Future<Either<Failures,List<BookModel>>> fetchRecommendedBooks();
}
