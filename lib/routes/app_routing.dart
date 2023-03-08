import 'package:flutter/material.dart';
import 'package:movie_app/screens/screens.dart';
import 'package:movie_app/models/models.dart';

class AppRoutes {
  static const initialRoute = 'home';

  static final menuOptions = <MenuOption>[
    // MenuOption(
    //     route: 'home',
    //     name: 'Home',
    //     screen: const HomeScreen(),
    //     icon: Icons.home),
    MenuOption(
        route: 'details',
        name: 'Details',
        screen: const DetailsScreen(),
        icon: Icons.details),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    appRoutes.addAll({'home': (context) => const HomeScreen()});

    for (final opt in menuOptions) {
      appRoutes.addAll({opt.route: (context) => opt.screen});
    }

    return appRoutes;
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const HomeScreen());
  }
}
