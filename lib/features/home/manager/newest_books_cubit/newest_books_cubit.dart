
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlore/features/home/data/models/book_model/book_model.dart';

import '../../data/repos/home_repo/home_repo.dart';

part 'newest_books_state.dart';

class NewestBooksCubit extends Cubit<NewestBooksState> {
  NewestBooksCubit(this.homeRepo) : super(NewestBooksInitial());

   final HomeRepo homeRepo;

   static NewestBooksCubit get(context) => BlocProvider.of(context);

  Future<void> fetchNewestBooks() async {
    emit(NewestBooksLoading());
    var result = await homeRepo.fetchNewestBooks();
    result.fold((failure) {
      emit(NewestBooksFailure(errorMsg: failure.errorMsg));
    }, (books) {
      emit(NewestBooksSuccess(books: books));
    });
  }
}
