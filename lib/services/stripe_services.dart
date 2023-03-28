import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class StripeServices {

  static Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51GztTrAJNtmvbtbwTSoCoPt9t5v2uBfKuFqjNJGt2doLFMw5t8XJImVVUvmF6GNeQsyFul3ceYEwqTgr2fBUboiz00Gvax70aG',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  static Future<void> savePaymentToFirebase(
      String customerId, String name, String email, String amount) async {
    final databaseReference = FirebaseDatabase.instance.ref('payments');
    await databaseReference.push().set({
      'customerId': customerId,
      'name': name,
      'email': email,
      'amount': amount,
      'status': 'Paid',
    });
  }



  static Future<void> displayPaymentSheet(
      String clientSecret, String name, String email, String amount, Function() onSuccess) async {
    try {
      var gpay = const PaymentSheetGooglePay(
          merchantCountryCode: "USD", currencyCode: "USD", testEnv: true);

      PaymentSheetApplePay? applePay;
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        applePay = PaymentSheetApplePay(
          merchantCountryCode: 'USD',
          paymentSummaryItems: [
            ApplePayCartSummaryItem.fromJson({
              'label': name,
              'amount': amount,
            }),
          ],
        );
      }

      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: clientSecret,
            style: ThemeMode.light,
            merchantDisplayName: name,
            googlePay: gpay,
            applePay: applePay,
            billingDetails: BillingDetails(
              name: name,
              email: email,
            ),
          ))
          .then((value) {});

      await Stripe.instance.presentPaymentSheet().then((value) {
        print("Payment Successfully");
        onSuccess.call();
      });
    } catch (e) {
      print('$e');
    }
  }
}
