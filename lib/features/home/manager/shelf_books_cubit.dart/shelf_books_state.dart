import 'package:equatable/equatable.dart';
import 'package:litlore/features/home/data/models/book_model/book_model.dart';

enum ShelfBooksStatus {
  initial,
  loading,
  success,
  failure,
  emailSent,
  loadingMore,
}

class ShelfBooksState extends Equatable {
  final ShelfBooksStatus status;
  final String? errorMessage;

  final BooksResponse? books;
  final bool hadReachedMax;
  final int startIndex;

  const ShelfBooksState({
    this.status = ShelfBooksStatus.initial,
    this.errorMessage,

    this.books,
    this.hadReachedMax = false,
    this.startIndex = 0,
  });

  factory ShelfBooksState.initial() {
    return const ShelfBooksState(status: ShelfBooksStatus.initial);
  }

  ShelfBooksState copyWith({
    ShelfBooksStatus? status,
    String? errorMessage,

    BooksResponse? books,
    bool? hadReachedMax,
    int? startIndex,
  }) {
    return ShelfBooksState(
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
