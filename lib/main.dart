import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laundary_system/route_names.dart';
import 'package:laundary_system/routes.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
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
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laundry Service',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MaterialColor((0xffCE1567), color),
        primaryColor: const Color(0xffCE1567),
        useMaterial3: true,
      ),
      initialRoute: RoutesNames.phoneLogin,
      onGenerateRoute: Routes.onGenerateRoutes,
    );
  }
}
