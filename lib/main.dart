import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:litlore/core/network/local/cache_helper.dart';
import 'package:litlore/core/theme/colors.dart';
import 'package:litlore/core/utils/app_consts.dart';
import 'package:litlore/core/utils/service_locator.dart';


import 'core/routes/app_routes.dart';

import 'core/utils/bloc_observer.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserver();
   AppConsts.accessToken = await AppCacheHelper.getSecureString(key: AppCacheHelper.accessTokenKey);
      AppConsts.accessToken = await AppCacheHelper.getSecureString(key: AppCacheHelper.refreshTokenKey);
  ServiceLocator.setup();
 
  runApp(const LitLore());
}

class LitLore extends StatelessWidget {
  const LitLore({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      theme: ThemeData(
        scaffoldBackgroundColor: MyColors.kScaffoldColor,
        appBarTheme: const AppBarTheme(color: MyColors.kScaffoldColor),
        colorScheme: ColorScheme.fromSeed(seedColor: MyColors.kPrimaryColor),
        useMaterial3: true,
        textTheme: GoogleFonts.nunitoTextTheme(),
      ),
     
    );
  }
}
