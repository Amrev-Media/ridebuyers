import 'package:flutter/material.dart';
import 'package:riderbuyers/presentation/cardetails_screen/cardetails_screen.dart';
import 'package:riderbuyers/presentation/launch_screen/launch_screen.dart';
import 'package:riderbuyers/presentation/loginsignup_screen/loginsignup_screen.dart';
import 'package:riderbuyers/presentation/notification_screen/notification_screen.dart';
import 'package:riderbuyers/presentation/test_screen/test_screen.dart';
import 'package:riderbuyers/presentation/welcome_screen/welcome_screen.dart';
import '../../core/exceptions/route_exception.dart';

class AppRouter {
  AppRouter({required this.firstcamera});
  final firstcamera;
  Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => LaunchScreen(
            title: "",
          ),
        );
      case '/loginsignup_screen':
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const LoginSignupScreen(),
        );
      case '/welcome_screen':
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => WelcomeScreen(),
        );
      case '/notification_screen':
        return MaterialPageRoute(
          settings:
              routeSettings, //this change allowed me to pass information with the ModalRoute.of(context)!.settings.arguments
          builder: (_) => const NotificationScreen(),
        );
      case '/cardetails_screen': //
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) =>  CarDetailsScreen(firstcamera: firstcamera,),
        );
      case '/test_screen': //
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => TestScreen(firstcamera: firstcamera,),
        );
      default:
        throw const RouteException('Route not found!');
    }
  }
}
