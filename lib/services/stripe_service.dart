import 'dart:convert';

import 'package:http/http.dart' as http;

class StripeService{
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
          'Bearer sk_test_51N17L3KlJkrr9AMxgWMRl1ueP5Xj0uASIADk8J2BhS4QhXmqtPfNdE0POuO7qFnwYUQoSdLr7VYHN5sUSvyKgcGH005XyxRz3W',
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