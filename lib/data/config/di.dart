import 'package:dio/dio.dart';
import 'package:live/features/home/repo/home_repo.dart';
import 'package:live/features/maps/provider/location_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/localization/provider/language_provider.dart';
import '../../app/localization/provider/localization_provider.dart';
import '../../app/theme/theme_provider/theme_provider.dart';
import '../../features/auth/provider/auth_provider.dart';
import '../../features/auth/repo/firebase_auth_repo.dart';
import '../../features/contact_with_us/provider/contact_provider.dart';
import '../../features/contact_with_us/repo/contact_repo.dart';
import '../../features/home/provider/home_provider.dart';
import '../../features/maps/repo/maps_repo.dart';
import '../../features/notifications/provider/notifications_provider.dart';
import '../../features/notifications/repo/notifications_repo.dart';
import '../../features/profile/provider/profile_provider.dart';
import '../../features/profile/repo/profile_repo.dart';
import '../../main_page/provider/main_page_provider.dart';
import '../../main_providers/calender_provider.dart';
import '../../main_providers/map_provider.dart';
import '../api/end_points.dart';
import '../network/netwok_info.dart';
import '../dio/dio_client.dart';
import '../dio/logging_interceptor.dart';
import '../../features/auth/repo/auth_repo.dart';
import '../../features/splash/provider/splash_provider.dart';
import '../../features/splash/repo/splash_repo.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => NetworkInfo(sl()));
  sl.registerLazySingleton(() => DioClient(
        EndPoints.baseUrl,
        dio: sl(),
        loggingInterceptor: sl(),
        sharedPreferences: sl(),
      ));

  // Repository
  sl.registerLazySingleton(() => SplashRepo(sharedPreferences: sl(),));
  sl.registerLazySingleton(() => AuthRepo(sharedPreferences: sl(), dioClient: sl()));
  // sl.registerLazySingleton(
  //     () => FirebaseAuthRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(() => ProfileRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(() => HomeRepo(sharedPreferences: sl(), dioClient: sl()));

  sl.registerLazySingleton(() => MapsRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(() => NotificationsRepo(sharedPreferences: sl(), dioClient: sl()));

  sl.registerLazySingleton(() => ContactRepo(sharedPreferences: sl(), dioClient: sl()));

  //provider
  sl.registerLazySingleton(() => LocalizationProvider(sharedPreferences: sl()));
  sl.registerLazySingleton(() => LanguageProvider());
  sl.registerLazySingleton(() => ThemeProvider(sharedPreferences: sl()));
  sl.registerLazySingleton(() => MainPageProvider());
  sl.registerLazySingleton(() => SplashProvider(splashRepo: sl()));
  sl.registerLazySingleton(() => AuthProvider(authRepo: sl()));
  // sl.registerLazySingleton(() => FirebaseAuthProvider(firebaseAuthRepo: sl()));
  // sl.registerLazySingleton(() => CalenderProvider());

  sl.registerLazySingleton(() => HomeProvider(homeRepo: sl(),));
  sl.registerLazySingleton(() => ProfileProvider(profileRepo: sl(),));

  sl.registerLazySingleton(() => MapProvider());
  sl.registerLazySingleton(() => LocationProvider(locationRepo: sl()));
  sl.registerLazySingleton(() => ContactProvider(contactRepo: sl(),));
  sl.registerLazySingleton(() => NotificationsProvider(
        notificationsRepo: sl(),
      ));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}
