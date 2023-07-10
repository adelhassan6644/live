import 'package:live/features/maps/provider/location_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:live/data/config/di.dart' as di;

import '../../app/localization/provider/localization_provider.dart';
import '../../app/theme/theme_provider/theme_provider.dart';
import '../../features/auth/provider/auth_provider.dart';
import '../../features/auth/provider/firebase_auth_provider.dart';
import '../../features/contact_with_us/provider/contact_provider.dart';
import '../../features/home/provider/home_provider.dart';
import '../../features/profile/provider/profile_provider.dart';
import '../../features/splash/provider/splash_provider.dart';
import '../../main_page/provider/main_page_provider.dart';
import '../../main_providers/calender_provider.dart';
import '../../main_providers/map_provider.dart';
import '../../main_providers/schedule_provider.dart';

abstract class ProviderList {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(
      create: (_) => di.sl<ThemeProvider>(),
    ),
    ChangeNotifierProvider(create: (_) => di.sl<LocalizationProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<MainPageProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<SplashProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<AuthProvider>()),
    // ChangeNotifierProvider(create: (_) => di.sl<FirebaseAuthProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<ProfileProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<HomeProvider>()),

    ChangeNotifierProvider(
      create: (_) => di.sl<MapProvider>(),
    ),
    ChangeNotifierProvider(
      create: (_) => di.sl<CalenderProvider>(),
    ),
    ChangeNotifierProvider(create: (_) => di.sl<LocationProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<ContactProvider>()),
  ];
}
