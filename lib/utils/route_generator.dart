import 'package:PromoMeFlutter/ui/modules/auth/auth.page.dart';
import 'package:PromoMeFlutter/ui/modules/navigation/home.navigation.dart';
import 'package:PromoMeFlutter/ui/modules/splash/splash.page.dart';
import 'package:PromoMeFlutter/ui/modules/store_details/store_details.page.dart';
import 'package:PromoMeFlutter/ui/modules/verification/verification.screen.dart';
import 'package:flutter/material.dart';

import '../env.dart';

class RouteGenerator {

  RouteGenerator();

  Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case Env.mainPage:
        return MaterialPageRoute(
          settings: RouteSettings(name: Env.mainPage),
          builder: (_) => LandingSplashScreen(),
        );
      case Env.authPage:
        return MaterialPageRoute(
          settings: RouteSettings(name: Env.authPage),
          builder: (_) => AuthPage(),
        );
      case Env.homePage:
        return MaterialPageRoute(
          settings: RouteSettings(name: Env.homePage),
          builder: (_) => HomeNavigationPage(),
        );
       case Env.saleItemPage:
        return MaterialPageRoute(
          settings: RouteSettings(name: Env.saleItemPage),
          builder: (_) => SaleItemDetailsPage(saleItem: args),
        );

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
