import 'package:equatable/equatable.dart';

enum SearchStatus { initial, loading, success, failure, emailSent }

class SearchState extends Equatable {
  final SearchStatus status;
  final String? errorMessage;
  final bool? isSearching;
  final bool showFilter;

  const SearchState({
    this.status = SearchStatus.initial,
    this.errorMessage,
    this.isSearching,
    this.showFilter = false,
  });

  factory SearchState.initial() {
    return const SearchState(status: SearchStatus.initial);
  }

  SearchState copyWith({
    SearchStatus? status,
    String? errorMessage,
    bool? isSearching,
    bool? showFilter,
  }) {
    return SearchState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isSearching: isSearching ?? this.isSearching,
      showFilter: showFilter ?? this.showFilter,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, isSearching,showFilter,];
}
