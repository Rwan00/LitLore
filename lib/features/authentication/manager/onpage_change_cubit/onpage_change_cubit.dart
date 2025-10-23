import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlore/features/authentication/data/repos/authentication_repo.dart';



part 'onpage_change_state.dart';

class OnpageChangeCubit extends Cubit<OnpageChangeState> {
  OnpageChangeCubit(this.authenticationRepo) : super(OnpageChangeInitial());

  final AuthenticationRepo authenticationRepo;

  static OnpageChangeCubit get(context) => BlocProvider.of(context);


 PageController pageController = PageController();
 bool isLast = false;
  void onPageChange({required int index}) {
    isLast = authenticationRepo.onPageChange( index: index);


    
    emit(OnpageChangeSuccess(isLast: isLast));
  }
}
