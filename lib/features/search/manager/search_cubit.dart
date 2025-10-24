import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
}
