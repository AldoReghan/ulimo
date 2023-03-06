import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:ulimo/pages/phone_login_pages.dart';
import 'package:ulimo/pages/stripe_page.dart';

void main() async {
  // Initialize Firebase app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey = 'pk_test_51GztTrAJNtmvbtbwMEUYu6YgxipbdFvBNqqO1hEVj6vWAyUFq84DeAM8pGBvGSz5SGZNt3HIGavTnonZyRqUolib00X1dGOYUv';
  await Stripe.instance.applySettings();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phone Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const StripePay(),
    );
  }
}
