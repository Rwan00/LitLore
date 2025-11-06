import 'package:equatable/equatable.dart';
import 'package:litlore/features/home/data/models/book_model/book_model.dart';

enum CategoryBooksStatus { initial, loading, success, failure, emailSent,loadingMore }

class CategoryBooksState extends Equatable {
  final CategoryBooksStatus status;
  final String? errorMessage;
  
  
  final BooksResponse? books;
  final bool hadReachedMax;
  final int startIndex;

  const CategoryBooksState({
    this.status = CategoryBooksStatus.initial,
    this.errorMessage,
   
    this.books ,
    this.hadReachedMax= false,
    this.startIndex = 0,
  });

  factory CategoryBooksState.initial() {
    return const CategoryBooksState(status: CategoryBooksStatus.initial);
  }

  CategoryBooksState copyWith({
    CategoryBooksStatus? status,
    String? errorMessage,
  
    BooksResponse? books,
    bool? hadReachedMax,
    int? startIndex,
  }) {
    return CategoryBooksState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      
      books: books ?? this.books,
      hadReachedMax: hadReachedMax ?? this.hadReachedMax,
      startIndex: startIndex ?? this.startIndex,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    
    books,
    hadReachedMax,
    startIndex,
  ];
}
