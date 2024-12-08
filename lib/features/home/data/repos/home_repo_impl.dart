import 'package:dartz/dartz.dart';
import 'package:litlore/core/errors/failures.dart';
import 'package:litlore/features/home/data/models/book_model/book_model.dart';
import 'package:litlore/features/home/data/repos/home_repo.dart';

class HomeRepoImpl implements HomeRepo{
  @override
  Future<Either<Failures, List<BookModel>>> fetchRecommendedBooks() {
   
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, List<BookModel>>> fetchTopSellerBooks() {
    
    throw UnimplementedError();
  }
  
}