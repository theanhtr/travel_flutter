import 'package:flutter/material.dart';
import 'package:travel_app_ytb/routes.dart';

class NavigationUtils {
  static void navigate(
      BuildContext context,
      String screenName, {
        Object? arguments,
      }) {
    Navigator.of(context).pushNamed(
      screenName,
      arguments: arguments,
    );
  }

  static T? getArguments<T>(
      BuildContext context,
      ) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    return arguments is T ? arguments : null;
  }

  static void navigateWithAnimation(
      BuildContext context,
      String screenName, {
        Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        animation,
        int? duration,
      }) {
    final route = NavigationUtils.buildPageRoute(
      context,
      screenName,
      transitionsBuilder: animation,
      duration: duration,
    );
    if (route == null) return;
    Navigator.of(context).push(route);
  }

  static Route? buildPageRoute(
      BuildContext context,
      String screenName, {
        Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transitionsBuilder,
        int? duration,
      }) {
    final screenRoute = routes[screenName];
    if (screenRoute == null) return null;
    final screen = screenRoute(context);

    const int defaultDuration = 300;
    Widget defaultTransitionsBuilder(
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) {
      return child;
    }

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionDuration: Duration(milliseconds: duration ?? defaultDuration),
      reverseTransitionDuration:
      Duration(milliseconds: duration ?? defaultDuration),
      transitionsBuilder: transitionsBuilder ?? defaultTransitionsBuilder,
      settings: RouteSettings(name: screenName),
    );
  }
}