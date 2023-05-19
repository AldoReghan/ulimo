import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:ulimo/base/base_color.dart';
import 'package:ulimo/firebase_options.dart';
import 'package:ulimo/pages/main/home_page.dart';
import 'package:ulimo/pages/main/main_page.dart';
import 'package:ulimo/pages/phone_login_pages.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {

  // Initialize Firebase app
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  Stripe.publishableKey =
  'pk_live_2nYari0BZqmrZXF6KHUotxfV';


  Stripe.merchantIdentifier =
  'merchant.ulimomvp';

  await Stripe.instance.applySettings();

  // String? token = await FirebaseMessaging.instance.getToken();
  // print("tokeennnn $token");
  // await Clipboard.setData(ClipboardData(text: token));
  // FlutterNativeSplash.remove();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  FlutterError.onError = (errorDetails) {
    // If you wish to record a "non-fatal" exception, please use `FirebaseCrashlytics.instance.recordFlutterError` instead
    FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    // If you wish to record a "non-fatal" exception, please remove the "fatal" parameter
    FirebaseCrashlytics.instance.recordError(error, stack);
    return true;
  };

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (kDebugMode) {
      print('Received message: ${message.notification?.title}');
    }
  });
  // SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
  //   systemNavigationBarColor: darkPrimary, // Change navigation bar color here
  // );
  // SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

  if(Platform.isIOS){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.white, // set status bar color
      statusBarIconBrightness: Brightness.light, // set status bar icons color to dark
    ));
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseAuth auth = FirebaseAuth.instance;

  late bool isLogin;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    if (auth.currentUser != null) {
      // User is already logged in
      setState(() {
        isLogin = true;
      });
    } else {
      // User is not logged in
      setState(() {
        isLogin = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phone Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: darkPrimary,
        fontFamily: 'Saira',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: isLogin ? const MainPage() : const PhoneLoginPage(),
    );
  }
}
