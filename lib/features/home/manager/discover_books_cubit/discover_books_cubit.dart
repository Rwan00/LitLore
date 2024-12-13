
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlore/features/home/data/models/book_model/book_model.dart';
import 'package:litlore/features/home/data/repos/home_repo/home_repo.dart';

part 'discover_books_state.dart';

class DiscoverBooksCubit extends Cubit<DiscoverBooksState> {
  DiscoverBooksCubit(this.homeRepo) : super(DiscoverBooksInitial());

  static DiscoverBooksCubit get(context) => BlocProvider.of(context);

  final HomeRepo homeRepo;

  Future<void> fetchDiscoverBooks() async {
    emit(DiscoverBooksLoading());
    var result = await homeRepo.fetchDiscoverBooks();
    result.fold((failure) {
      emit(DiscoverBooksFailure(errorMsg: failure.errorMsg));
    }, (books) {
      emit(DiscoverBooksSuccess(books: books));
    });
  }
}
