import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlore/features/home/data/models/book_model/book_model.dart';
import 'package:litlore/features/search/data/repo/search_repo.dart';
import 'package:litlore/features/search/manager/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchRepo) : super(SearchState.initial());

  final SearchRepo searchRepo;

  static SearchCubit get(context) => BlocProvider.of(context);

  void toggleSearching(bool isSearching) {
    emit(state.copyWith(isSearching: isSearching));
  }

  void toggleFilter(AnimationController controller) {
    emit(state.copyWith(showFilter: !state.showFilter));
    if (state.showFilter) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }

  void setFilter(String filter) {
    emit(state.copyWith(selectedFilter: filter));
    if (state.searchKey != null) {
      searchBooks(state.searchKey!);
    }
  }

  void setOrderBy(String orderBy) {
    emit(state.copyWith(selectedOrderBy: orderBy));
    if (state.searchKey != null) {
      searchBooks(state.searchKey!);
    }
  }

  void setPrintType(String printType) {
    emit(state.copyWith(selectedPrintType: printType));
    if (state.searchKey != null) {
      searchBooks(state.searchKey!);
    }
  }

  void resetFilters() {
    emit(
      state.copyWith(
        selectedPrintType: "all",
        selectedFilter: "all",
        selectedOrderBy: "relevance",
      ),
    );
  }

  void setSearchingKey(String searchKey) {
    emit(state.copyWith(searchKey: searchKey));
  }

  Future<void> searchBooks(String query, {bool isLoadingMore = false}) async {
    if (state.status == SearchStatus.loading) return;
    final meta = state.books;
    if (isLoadingMore && (state.startIndex) >= (meta?.totalCount ?? 0)) {
      return;
    }
    emit(state.copyWith(status: SearchStatus.loading));
    var result = await searchRepo.searchBooks(
      query,
      state.startIndex,
      filter: state.selectedFilter,
      orderBy: state.selectedOrderBy,
      contentType: state.selectedPrintType,
    );
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            errorMessage: failure.errorMsg,
            status: SearchStatus.failure,
          ),
        );
      },
      (books) {
        emit(
          state.copyWith(
            status: SearchStatus.success,
            books: books,
            startIndex: 10,
          ),
        );
      },
    );
  }

  Future<void> loadMore(String query) async {
    if (state.status == SearchStatus.loading) return;
    final current = state.books;
    if (current == null) return;

    var result = await searchRepo.searchBooks(
      query,
      state.startIndex,
      filter: state.selectedFilter,
      orderBy: state.selectedOrderBy,
      contentType: state.selectedPrintType,
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            errorMessage: failure.errorMsg,
            status: SearchStatus.failure,
          ),
        );
      },
      (incoming) {
        final existingList = current.books ?? [];
        final incomingList = incoming.books ?? [];
        final mergedList = [...existingList, ...incomingList];
        final mergedResponse = BooksResponse(
          kind: incoming.kind ?? current.kind,
          totalCount: incoming.totalCount ?? current.totalCount,
          books: mergedList,
        );

        final hadReachedMax =
            (state.startIndex) >= (mergedResponse.totalCount ?? 0);
        emit(
          state.copyWith(
            status: SearchStatus.success,
            books: mergedResponse,
            hadReachedMax: hadReachedMax,
            startIndex: (state.startIndex) + 10,
          ),
        );
      },
    );
  }
}
