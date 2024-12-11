import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:litlore/features/home/data/models/book_model/book_model.dart';

part 'discover_books_state.dart';

class DiscoverBooksCubit extends Cubit<DiscoverBooksState> {
  DiscoverBooksCubit() : super(DiscoverBooksInitial());
}
