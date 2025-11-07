import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:litlore/features/home/data/repos/home_repo/home_repo.dart';
import 'package:litlore/features/home/manager/book_shelves_cubit/book_shelves_state.dart';


class BookShelvesCubit extends Cubit<BookShelvesState> {
  BookShelvesCubit(this.homeRepo) : super(BookShelvesState.initial());

  final HomeRepo homeRepo;

  static BookShelvesCubit get(context) => BlocProvider.of(context);

  Future<void> fetchBookShelves() async {
   
    emit(state.copyWith(status: BookShelvesStatus.loading));
    var result = await homeRepo.fetchBookShelves();
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            errorMessage: failure.errorMsg,
            status: BookShelvesStatus.failure,
          ),
        );
      },
      (shelves) {
        emit(
          state.copyWith(
            status: BookShelvesStatus.success,
            shelves: shelves,
           
          ),
        );
      },
    );
  }


}
