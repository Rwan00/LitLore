import 'package:equatable/equatable.dart';
import 'package:litlore/features/home/data/models/book_model/book_model.dart';

enum SearchStatus { initial, loading, success, failure, emailSent }

class SearchState extends Equatable {
  final SearchStatus status;
  final String? errorMessage;
  final bool? isSearching;
  final bool showFilter;
  final String selectedFilter;
  final String selectedOrderBy;
  final String selectedPrintType;
  final String? searchKey;
  final List<BookModel> books;

  const SearchState({
    this.status = SearchStatus.initial,
    this.errorMessage,
    this.isSearching,
    this.showFilter = false,
    this.selectedFilter = "all",
    this.selectedOrderBy = "relevance",
    this.selectedPrintType = "all",
    this.searchKey,
    this.books = const [],
  });

  factory SearchState.initial() {
    return const SearchState(status: SearchStatus.initial);
  }

  SearchState copyWith({
    SearchStatus? status,
    String? errorMessage,
    bool? isSearching,
    bool? showFilter,
    String? selectedFilter,
    String? selectedOrderBy,
    String? selectedPrintType,
    String? searchKey,
    List<BookModel>? books, 
  }) {
    return SearchState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isSearching: isSearching ?? this.isSearching,
      showFilter: showFilter ?? this.showFilter,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      selectedOrderBy: selectedOrderBy ?? this.selectedOrderBy,
      selectedPrintType: selectedPrintType ?? this.selectedPrintType,
      searchKey: searchKey ?? this.searchKey,
      books: books??this.books,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    isSearching,
    showFilter,
    selectedFilter,
    selectedOrderBy,
    selectedPrintType,
    searchKey,
    books,
  ];
}
