import 'package:flutter/material.dart';
import 'package:ulimo/services/stripe_services.dart';

// ignore: must_be_immutable
class StripePay extends StatefulWidget {
  String documentId;
  String name;
  String email;
  String amount;
  String currency;
  String description;
  StripePay({
    Key? key,
    required this.documentId,
    required this.name,
    required this.email,
    required this.amount,
    required this.currency,
    required this.description,
  }) : super(key: key);

  @override
  _StripePayState createState() => _StripePayState();
}

class _StripePayState extends State<StripePay> {
  Map<String, dynamic>? paymentIntent;

  Future<void> makePayment() async {
    paymentIntent = await StripeServices.createPaymentIntent(
      widget.amount,
      widget.currency,
    );
    await StripeServices.displayPaymentSheet(
      paymentIntent!['client_secret'],
      widget.name,
      widget.email,
      widget.amount,
    );
    await StripeServices.savePaymentToFirebase(
      widget.documentId,
      widget.name,
      widget.email,
      widget.amount,
    );
  }

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
}
