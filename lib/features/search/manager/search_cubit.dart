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
  }

  void setOrderBy(String orderBy) {
    emit(state.copyWith(selectedOrderBy: orderBy));
  }

  void setPrintType(String printType) {
    emit(state.copyWith(selectedPrintType: printType));
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

  Future<void> searchBooks(String query) async {
    if (state.startIndex == 0)
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
        if (state.books == null) {
          emit(state.copyWith(status: SearchStatus.success, books: books));
        } else {
          final existingList = state.books!.books ?? [];
          final incomingList = books.books ?? [];
          final mergedList = [...existingList, ...incomingList];
          final mergedResponse = BooksResponse(
            kind: state.books!.kind,
            totalCount: state.books!.totalCount,
            books: mergedList,
          );
          emit(
            state.copyWith(
              status: SearchStatus.success,
              books: mergedResponse,
             
              hadReachedMax: state.startIndex >= books.totalCount!,
               startIndex: state.startIndex + 10,
            ),
          );
        }
      },
    );
  }
}
