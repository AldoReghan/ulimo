import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:ulimo/base/base_color.dart';
import 'package:ulimo/pages/main/home_page.dart';
import 'package:ulimo/pages/main/main_page.dart';
import 'package:ulimo/pages/phone_login_pages.dart';

void main() async {
  // Initialize Firebase app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey =
      'pk_test_51GztTrAJNtmvbtbwMEUYu6YgxipbdFvBNqqO1hEVj6vWAyUFq84DeAM8pGBvGSz5SGZNt3HIGavTnonZyRqUolib00X1dGOYUv';
  await Stripe.instance.applySettings();
  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
    systemNavigationBarColor: darkPrimary, // Change navigation bar color here
  );
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

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
