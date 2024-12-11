part of 'discover_books_cubit.dart';

sealed class DiscoverBooksState extends Equatable {
  const DiscoverBooksState();

  @override
  List<Object> get props => [];
}

final class DiscoverBooksInitial extends DiscoverBooksState {}

final class DiscoverBooksLoading extends DiscoverBooksState {}

final class DiscoverBooksFailure extends DiscoverBooksState {
  final String errorMsg;

  const DiscoverBooksFailure({required this.errorMsg});
}

final class DiscoverBooksSuccess extends DiscoverBooksState {
  final List<BookModel> books;

  const DiscoverBooksSuccess({required this.books});
}
