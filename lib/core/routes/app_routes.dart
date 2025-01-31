import 'package:flutter/material.dart';
import 'package:litlore/features/authentication/presentation/views/register_view.dart';
import 'package:litlore/features/authentication/presentation/views/onboarding_view.dart';
import 'package:litlore/features/home/presentation/views/book_details_view.dart';

import 'package:litlore/features/home/presentation/views/home_view.dart';

import 'package:litlore/features/search/presentation/views/search_view.dart';
import 'package:litlore/features/authentication/presentation/views/splash_view.dart';

Map<String, WidgetBuilder> routes = {
  "/": (_) => const SplashView(),
  HomeView.routeName: (_) => const HomeView(),
  BookDetailsView.routeName: (_) => const BookDetailsView(),
  SearchView.routeName: (_) => const SearchView(),
  OnBoardingScreen.routeName:(_)=>const OnBoardingScreen(),
  RegisterView.routeName:(_)=>const RegisterView(),
};
