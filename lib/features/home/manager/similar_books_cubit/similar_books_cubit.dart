import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:litlore/features/home/data/models/book_model/book_model.dart';
import 'package:litlore/features/home/data/repos/book_details_repo/book_details_repo.dart';

part 'similar_books_state.dart';

class SimilarBooksCubit extends Cubit<SimilarBooksState> {
  SimilarBooksCubit(this.bookDetailsRepo) : super(SimilarBooksInitial());

  static SimilarBooksCubit get(context) => BlocProvider.of(context);

  final BookDetailsRepo bookDetailsRepo;

  Future<void> fetchSimilarBooks({required String category}) async {
    emit(SimilarBooksLoading());
    var result = await bookDetailsRepo.fetchSimilarBooks(category: category);
    result.fold(
      (failure) {
        emit(SimilarBooksFailure(errorMsg: failure.errorMsg));
      },
      (books) {
        emit(SimilarBooksSuccess(books: books));
      },
    );
  }
}
