import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlore/core/utils/app_consts.dart';
import 'package:litlore/features/home/data/models/book_model/book_model.dart';
import 'package:litlore/features/home/data/repos/home_repo/home_repo.dart';
import 'package:litlore/features/home/manager/shelf_books_cubit.dart/shelf_books_state.dart';

class ShelfBooksCubit extends Cubit<ShelfBooksState> {
  ShelfBooksCubit(this.homeRepo) : super(ShelfBooksState.initial());

  final HomeRepo homeRepo;

  static ShelfBooksCubit get(context) => BlocProvider.of(context);

  /// Fetch initial books for a shelf
  Future<void> fetchShelfBooks(int shelf) async {
    if (state.status == ShelfBooksStatus.loading) return;

    emit(state.copyWith(status: ShelfBooksStatus.loading));
    
    // ✅ Always start from index 0 for initial fetch
    var result = await homeRepo.fetchShelfBooks(shelf, 0);
    
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            errorMessage: failure.errorMsg,
            status: ShelfBooksStatus.failure,
          ),
        );
      },
      (books) {
        final totalBooks = books.books?.length ?? 0;
        final totalCount = books.totalCount ?? 0;
        
        // ✅ Check if we've loaded all available books
        final hadReachedMax = totalBooks >= totalCount;
        
        emit(
          state.copyWith(
            status: ShelfBooksStatus.success,
            books: books,
            startIndex: totalBooks, // ✅ Set to number of books loaded
            hadReachedMax: hadReachedMax,
          ),
        );
      },
    );
  }

  /// Load more books (pagination)
  Future<void> loadMore(int shelf) async {
    // ✅ Prevent loading if already loading or reached max
    if (state.status == ShelfBooksStatus.loadingMore || state.hadReachedMax) return;
    
    final current = state.books;
    if (current == null) return;

    // ✅ Emit loadingMore status instead of loading
    emit(state.copyWith(status: ShelfBooksStatus.loadingMore));

    var result = await homeRepo.fetchShelfBooks(shelf, state.startIndex);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            errorMessage: failure.errorMsg,
            status: ShelfBooksStatus.failure,
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

        final totalLoaded = mergedList.length;
        final totalCount = mergedResponse.totalCount ?? 0;
        
        // ✅ Check if we've loaded all books or received fewer than expected
        final hadReachedMax = totalLoaded >= totalCount || incomingList.isEmpty;
        
        logger.e('Total loaded: $totalLoaded / $totalCount');
        logger.e('Had reached max: $hadReachedMax');
        
        emit(
          state.copyWith(
            status: ShelfBooksStatus.success,
            books: mergedResponse,
            hadReachedMax: hadReachedMax,
            startIndex: totalLoaded, // ✅ Update to total number of books loaded
          ),
        );
      },
    );
  }
}