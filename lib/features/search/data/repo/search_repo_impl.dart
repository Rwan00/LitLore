import 'package:dartz/dartz.dart';
import 'package:litlore/core/errors/failures.dart';
import 'package:litlore/features/home/data/models/book_model/book_model.dart';
import 'package:litlore/features/search/data/repo/search_repo.dart';

class SearchRepoImpl implements SearchRepo{
  @override
  Future<Either<Failures, List<BookModel>>> searchBooks() {
    // TODO: implement searchBooks
    throw UnimplementedError();
  }

}