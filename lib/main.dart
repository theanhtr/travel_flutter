import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:travel_app_ytb/core/utils/const_utils.dart';
import 'package:travel_app_ytb/helpers/local_storage_helper.dart';
import 'package:travel_app_ytb/representation/screens/splash_screen.dart';
import 'package:travel_app_ytb/routes.dart';
import './core/constants/color_palatte.dart';

void main() async {
  await Hive.initFlutter();
  await LocalStorageHelper.initLocalStorageHelper();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Stripe.publishableKey = ConstUtils.stripePublishableKey;
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale("en"), Locale("vi")],
        path: 'assets/translations',
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
          primaryColor: ColorPalette.primaryColor,
          scaffoldBackgroundColor: ColorPalette.backgroundScaffoldColor,
          backgroundColor: ColorPalette.backgroundScaffoldColor,
          dividerColor: Color.fromARGB(255, 0, 0, 0)),
      routes: routes,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
