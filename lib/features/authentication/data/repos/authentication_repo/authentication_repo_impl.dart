

import '../../models/onboarding_model.dart';
import 'authentication_repo.dart';

class AuthenticationRepoImpl implements AuthenticationRepo {
  AuthenticationRepoImpl();

  @override
  bool onPageChange({ required int index}) {
    bool isLast = false;
    if (index == onBoardingList.length - 1) {
      isLast = true;
      
    } else {
      isLast = false;
    }
    return isLast;
  }
}
