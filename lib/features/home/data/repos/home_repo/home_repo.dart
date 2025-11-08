import 'package:dartz/dartz.dart';
import 'package:litlore/core/errors/failures.dart';
import 'package:litlore/features/home/data/models/book_model/book_model.dart';
import 'package:litlore/features/home/data/models/book_shelves_model/book_shelves_model/item.dart';

abstract class HomeRepo {
  Future<Either<Failures, List<BookModel>>> fetchNewestBooks();
  Future<Either<Failures, List<BookModel>>> fetchDiscoverBooks();
  Future<Either<Failures, List<ShelfItem>>> fetchBookShelves();
  Future<Either<Failures, BooksResponse>> fetchCategoryBooks(
    String category,
    int startIndex,
  );
  Future<Either<Failures, BooksResponse>> fetchShelfBooks(
    int shelf,
    int startIndex,
  );
  Future<Either<Failures, String>> addToMyLibrary(
    int shelfId,
    String bookId,
  );
}
