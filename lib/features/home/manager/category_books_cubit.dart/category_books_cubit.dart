
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlore/features/home/data/models/book_model/book_model.dart';
import 'package:litlore/features/home/data/repos/home_repo/home_repo.dart';
import 'package:litlore/features/home/manager/category_books_cubit.dart/category_books_state.dart';


class CategoryBooksCubit extends Cubit<CategoryBooksState> {
  CategoryBooksCubit(this.homeRepo) : super(CategoryBooksState.initial());

  final HomeRepo homeRepo;

  static CategoryBooksCubit get(context) => BlocProvider.of(context);


  Future<void> fetchCategoryBooks(String category, {bool isLoadingMore = false}) async {
    if (state.status == CategoryBooksStatus.loading) return;
    final meta = state.books;
    if (isLoadingMore && (state.startIndex) >= (meta?.totalCount ?? 0)) {
      return;
    }
    emit(state.copyWith(status: CategoryBooksStatus.loading));
    var result = await homeRepo.fetchCategoryBooks(
      category,
      state.startIndex,
     
    );
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            errorMessage: failure.errorMsg,
            status: CategoryBooksStatus.failure,
          ),
        );
      },
      (books) {
        
        emit(
          state.copyWith(
            status: CategoryBooksStatus.success,
            books: books,
            startIndex: 10,
          ),
        );
      },
    );
  }

  Future<void> loadMore(String category) async {
    if (state.status == CategoryBooksStatus.loading) return;
    final current = state.books;
    if (current == null) return;

    var result = await homeRepo.fetchCategoryBooks(
      category,
      state.startIndex,
     
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            errorMessage: failure.errorMsg,
            status: CategoryBooksStatus.failure,
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
            status: CategoryBooksStatus.success,
            books: mergedResponse,
            hadReachedMax: hadReachedMax,
            startIndex: (state.startIndex) + 10,
          ),
        );
      },
    );
  }
}
