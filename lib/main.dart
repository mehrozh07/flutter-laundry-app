import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundary_system/auth-bloc/auth_cubit.dart';
import 'package:laundary_system/providers/cart_provider.dart';
import 'package:laundary_system/providers/categories_provider.dart';
import 'package:laundary_system/providers/location_provider.dart';
import 'package:laundary_system/providers/service_provider.dart';
import 'package:laundary_system/providers/user_provider.dart';
import 'package:laundary_system/route_names.dart';
import 'package:laundary_system/routes.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _firebaseBackgroundMessageHandler(RemoteMessage message) async{
  if (kDebugMode) {
    print(".................Handle background messages ${message.messageId}");
  }
}

Map<int, Color> color = {
  50: const Color.fromRGBO(206, 21, 103, .1),
  100: const Color.fromRGBO(206, 21, 103, .2),
  200: const Color.fromRGBO(206, 21, 103, .3),
  300: const Color.fromRGBO(206, 21, 103, .4),
  400: const Color.fromRGBO(206, 21, 103, .5),
  500: const Color.fromRGBO(206, 21, 103, .6),
  600: const Color.fromRGBO(206, 21, 103, .7),
  700: const Color.fromRGBO(206, 21, 103, .8),
  800: const Color.fromRGBO(206, 21, 103, .9),
  900: const Color.fromRGBO(206, 21, 103, 1),
};
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessageHandler);
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  prefs.timeout(const Duration(seconds: 10));
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => AuthCubit()),
  ], child: MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> CategoriesProvider()),
        ChangeNotifierProvider(create: (_)=> UserProvider()),
        ChangeNotifierProvider(create: (_)=> ServiceProvider()),
        ChangeNotifierProvider(create: (_)=> CartProvider()),
        ChangeNotifierProvider(create: (_)=> LocationProvider()),
      ],
  child: const MyApp())));
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: const Color(0XFF8DC73F).withOpacity(0.5),
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.grey,
      statusBarBrightness: Brightness.dark,
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laundry Service',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MaterialColor(0xffCE1567, color),
        primaryColor: const Color(0xffCE1567),
        useMaterial3: true,
      ),
      initialRoute: FirebaseAuth.instance.currentUser == null ? RoutesNames.phoneLogin : RoutesNames.mainScreen,
      onGenerateRoute: Routes.onGenerateRoutes,
    );
  }
}