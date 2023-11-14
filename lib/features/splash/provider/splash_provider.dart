import 'package:flutter/cupertino.dart';
import 'package:live/navigation/custom_navigation.dart';
import 'package:live/navigation/routes.dart';
import '../../../helpers/permissions.dart';
import '../repo/splash_repo.dart';

class SplashProvider extends ChangeNotifier {
  final SplashRepo splashRepo;
  SplashProvider({required this.splashRepo});

  startTheApp() {
    Future.delayed(const Duration(milliseconds: 1500), () async {
      ///Ask Notification Permission
      await PermissionHandler.checkNotificationsPermission();

      if (splashRepo.isFirstTime()) {
       CustomNavigator.push(Routes.ON_BOARDING, clean: true);
      } else if (!splashRepo.isLogin() ) {
        CustomNavigator.push(Routes.MAIN_PAGE, clean: true);
      } else {
        CustomNavigator.push(Routes.MAIN_PAGE, clean: true, arguments: 0);
      }
      splashRepo.setFirstTime();
    });

  }
}
