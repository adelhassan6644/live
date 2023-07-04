import 'package:live/main_models/base_model.dart';
import 'package:flutter/material.dart';
import '../features/auth/pages/login.dart';
import '../features/auth/pages/register.dart';
import '../features/auth/pages/verification.dart';
import '../features/contact_with_us/page/contact_with_us.dart';
import '../features/maps/pages/pick_map_screen.dart';
import '../features/notifications/page/notifications.dart';
import '../features/profile/page/profile_page.dart';
import '../features/splash/page/splash.dart';
import '../main.dart';
import '../main_page/dashboard.dart';
import 'routes.dart';

abstract class CustomNavigator {
  static final GlobalKey<NavigatorState> navigatorState =
      GlobalKey<NavigatorState>();
  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();
  static final GlobalKey<ScaffoldMessengerState> scaffoldState =
      GlobalKey<ScaffoldMessengerState>();

  static Route<dynamic> onCreateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.APP:
        return _pageRoute(const MyApp());
      case Routes.SPLASH:
        return _pageRoute(const Splash());
      case Routes.LOGIN:
        return _pageRoute(const Login());
        case Routes.REGISTER:
        return _pageRoute(const Register());
      case Routes.VERIFICATION:
        return _pageRoute( Verification(fromRegister:settings.arguments as bool));
      case Routes.EDIT_PROFILE:
        return _pageRoute(ProfilePage(
          fromLogin: settings.arguments as bool,
        ));
      case Routes.DASHBOARD:
        return _pageRoute(DashBoard(
          index: settings.arguments as int,
        ));

      case Routes.PICK_LOCATION:
        return _pageRoute(PickMapScreen(
          baseModel: settings.arguments as BaseModel,
        ));

      case Routes.CONTACT_WITH_US:
        return _pageRoute(const ContactWithUs());

      case Routes.NOTIFICATIONS:
        return _pageRoute(const Notifications());

      default:
        return MaterialPageRoute(builder: (_) => const MyApp());
    }
  }

  static PageRouteBuilder<dynamic> _pageRoute(Widget child) => PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 100),
      reverseTransitionDuration: const Duration(milliseconds: 100),
      transitionsBuilder: (c, anim, a2, child) {
        var begin = const Offset(1.0, 0.0);
        var end = Offset.zero;
        var tween = Tween(begin: begin, end: end);
        var curveAnimation =
            CurvedAnimation(parent: anim, curve: Curves.linearToEaseOut);
        return SlideTransition(
          position: tween.animate(curveAnimation),
          child: child,
        );
      },
      opaque: false,
      pageBuilder: (_, __, ___) => child);

  static pop({dynamic result}) {
    if (navigatorState.currentState!.canPop()) {
      navigatorState.currentState!.pop(result);
    }
  }

  static push(String routeName,
      {arguments, bool replace = false, bool clean = false}) {
    if (clean) {
      return navigatorState.currentState!.pushNamedAndRemoveUntil(
          routeName, (_) => false,
          arguments: arguments);
    } else if (replace) {
      return navigatorState.currentState!.pushReplacementNamed(
        routeName,
        arguments: arguments,
      );
    } else {
      return navigatorState.currentState!
          .pushNamed(routeName, arguments: arguments);
    }
  }
}
