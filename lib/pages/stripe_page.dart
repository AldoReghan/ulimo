import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class StripePay extends StatefulWidget {
  const StripePay({Key? key}) : super(key: key);

  @override
  _StripePayState createState() => _StripePayState();
}

class _StripePayState extends State<StripePay> {
  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stripe Payment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: const Text('Buy Now'),
              onPressed: () async {
                await makePayment();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> makePayment() async {
    try {
      paymentIntent = await createPaymentIntent('10000', 'GBP');

      var gpay = const PaymentSheetGooglePay(
          merchantCountryCode: "GB", currencyCode: "GBP", testEnv: true);

      // var applePay = PaymentSheetApplePay(
      //   merchantCountryCode: 'GB',
      //   paymentSummaryItems: [
      //     ApplePayCartSummaryItem.fromJson({
      //       'label': 'Abhi',
      //       'amount': '10000',
      //     }),
      //   ],
      // );

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret:
                paymentIntent!['client_secret'], //Gotten from payment intent
            style: ThemeMode.light,
            merchantDisplayName: 'Abhi',
            googlePay: gpay,
            // applePay: applePay,
            billingDetails: const BillingDetails(
              name: 'Abhi',
              email: 'a@a.com'
            )
          ))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (err) {
      print(err);
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        print("Payment Successfully");
      });
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
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
}
