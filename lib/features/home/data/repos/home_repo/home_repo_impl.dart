import 'dart:developer';
import 'dart:math' hide log;

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:litlore/core/errors/failures.dart';
import 'package:litlore/core/network/remote/app_dio.dart';
import 'package:litlore/core/utils/app_consts.dart';

import 'package:litlore/core/utils/urls.dart';
import 'package:litlore/features/home/data/models/book_model/book_model.dart';
import 'package:litlore/features/home/data/models/book_shelves_model/book_shelves_model/item.dart';

import 'package:litlore/features/home/data/repos/home_repo/home_repo.dart';

import '../../../../../core/errors/server_failure.dart';

class HomeRepoImpl implements HomeRepo {
  final AppDio apiService;

  HomeRepoImpl({required this.apiService});
  @override
  Future<Either<Failures, List<BookModel>>> fetchDiscoverBooks() async {
    List<String> googleBooksSubjects = [
      'Reference',
      'Encyclopedias',
      'Dictionaries',
      'Education',
      'Study Aids',
      'Science',
      'Mathematics',
      'Technology & Engineering',
      'Computers',
      'Medical',
      'Nature',
      'Fiction',
      'Poetry',
      'Drama',
      'Literary Criticism',
      'Language Arts & Disciplines',
      'History',
      'Philosophy',
      'Psychology',
      'Political Science',
      'Religion',
      'Social Science',
      'Business & Economics',
      'Management',
      'Finance',
      'Marketing',
      'Art',
      'Design',
      'Performing Arts',
      'Music',
      'Photography',
      'Health & Fitness',
      'Cooking',
      'Family & Relationships',
      'Self-Help',
      'House & Home',
      'Sports & Recreation',
      'Games',
      'Crafts & Hobbies',
      'Travel',
      'Juvenile Fiction',
      'Juvenile Nonfiction',
      'Young Adult Fiction',
      'Young Adult Nonfiction',
      'Comics & Graphic Novels',
      'True Crime',
      'Transportation',
      'Gardening',
      'Pets',
      'Body, Mind & Spirit',
    ];

    Random random = Random();
    int randomIndex = random.nextInt(googleBooksSubjects.length);
    String randomSubject = googleBooksSubjects[randomIndex];
    try {
      var response = await apiService.get(
        path: Urls.discoverBooksBySubject(randomSubject),
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

  @override
  Future<Either<Failures, List<BookModel>>> fetchNewestBooks() async {
    try {
      var response = await apiService.get(path: Urls.newestBooks);
      List<BookModel> books = [];
      for (var item in response.data["items"]) {
        books.add(BookModel.fromJson(item));
      }
      return right(books);
    } on DioException catch (error) {
      logger.e(error);
      return left(ServerFailure.fromDioError(error));
    } catch (error) {
      logger.e(error);
      return left(ServerFailure(errorMsg: error.toString()));
    }
  }
  @override
  Future<Either<Failures, List<ShelfItem>>> fetchBookShelves() async {
    try {
      var response = await apiService.get(path: Urls.myLibraryBookshelves);
      List<ShelfItem> shelves = [];
      for (var item in response.data["items"]) {
        shelves.add(ShelfItem.fromJson(item));
      }
      return right(shelves);
    } on DioException catch (error) {
      logger.e(error);
      return left(ServerFailure.fromDioError(error));
    } catch (error) {
      logger.e(error);
      return left(ServerFailure(errorMsg: error.toString()));
    }
  }

  @override
  Future<Either<Failures, BooksResponse>> fetchCategoryBooks(
    String category,
    int startIndex,
  ) async {
    try {
      var response = await apiService.get(
        path: Urls.similarBooks(category),
        queryParams: {"startIndex": startIndex},
      );
      BooksResponse booksResponse = BooksResponse.fromJson(response.data);
      return right(booksResponse);
    } on DioException catch (error) {
      log(error.message ?? "");
      return left(ServerFailure.fromDioError(error));
    } catch (error) {
      return left(ServerFailure(errorMsg: error.toString()));
    }
  }
  @override
  Future<Either<Failures, BooksResponse>> fetchShelfBooks(
    int shelf,
    int startIndex,
  ) async {
    try {
      var response = await apiService.get(
        path: Urls.myLibraryBooks(shelf),
        queryParams: {"startIndex": startIndex},
      );
      BooksResponse booksResponse = BooksResponse.fromJson(response.data);
      return right(booksResponse);
    } on DioException catch (error) {
      log(error.message ?? "");
      return left(ServerFailure.fromDioError(error));
    } catch (error) {
      return left(ServerFailure(errorMsg: error.toString()));
    }
  }
  @override
  Future<Either<Failures, String>> addToMyLibrary(
    int shelfId,
    String bookId,
  ) async {
    try {
      await apiService.post(
        path: Urls.addToMyLibraryBooks(shelfId,bookId),
        
      );
      
      return right("Poof! The book has appeared in your magical Library.");
    } on DioException catch (error) {
      log(error.message ?? "");
      return left(ServerFailure.fromDioError(error));
    } catch (error) {
      return left(ServerFailure(errorMsg: error.toString()));
    }
  }
}
