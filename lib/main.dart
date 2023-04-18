import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:ulimo/base/base_color.dart';
import 'package:ulimo/firebase_options.dart';
import 'package:ulimo/pages/main/home_page.dart';
import 'package:ulimo/pages/main/main_page.dart';
import 'package:ulimo/pages/phone_login_pages.dart';
import 'package:flutter/services.dart';

void main() async {
  // Initialize Firebase app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  String? token = await FirebaseMessaging.instance.getToken();
  // print("tokeennnn $token");
  // await Clipboard.setData(ClipboardData(text: token));
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Received message: ${message.notification?.title}');
  });
  // SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
  //   systemNavigationBarColor: darkPrimary, // Change navigation bar color here
  // );
  // SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

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
      // home: StripePay(documentId: "123213", name: "aldo", email: "aldo@gmail.com", amount: "150000", currency: "USD", description: "payment for car"),
      home: isLogin ? const MainPage() : const PhoneLoginPage(),
    );
  }
}
