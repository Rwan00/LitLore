import 'package:flutter/material.dart';

import 'package:litlore/features/home/presentation/views/home_view.dart';
import 'package:litlore/features/splash/presentation/views/splash_view.dart';

Map<String, WidgetBuilder> routes = {
"/": (_) => const SplashView(),
    HomeView.routeName: (_) => const HomeView(),
};
