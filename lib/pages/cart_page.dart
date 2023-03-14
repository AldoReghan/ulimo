import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final String user_id;

  CartPage({required this.user_id});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<String> _items = [];
  List<double> _prices = [];
  List<bool> _checkedItems = [];
  List<String> _discount = [];
  List<int> _discountRate = [];
  int _selectedDiscountRate = 0;

  @override
  void initState() {
    super.initState();
    _loadCartData();
  }

  void _loadCartData() async {
    final cartRef = FirebaseDatabase.instance.ref("cart");
    final snapshot =
        await cartRef.orderByChild("user_id").equalTo(widget.user_id).once();
    final values = snapshot.snapshot.value as Map<dynamic, dynamic>;

    if (values != null) {
      List<String> items = [];
      List<double> prices = [];
      List<bool> checkedItems = [];

      values.forEach((key, value) {
        items.add(value['destination_id']);
        final price = value['price'] as int;
        prices.add(price.toDouble());
        checkedItems.add(true);
      });

      setState(() {
        _items = items;
        _prices = prices;
        _checkedItems = checkedItems;
      });
    }
  }

  double _totalPrice() {
    double totalPrice = 0;
    double totalDiscount = 0;
    for (int i = 0; i < _checkedItems.length; i++) {
      if (_checkedItems[i]) {
        totalPrice += _prices[i];

      }
    }

    totalDiscount = totalPrice * (_selectedDiscountRate/100);
    totalPrice -= totalDiscount;

    return totalPrice;
  }

  void _showDiscountCodeDialog() async {
    final _databaseRef = FirebaseDatabase.instance.ref();
    List<String> discount = [];
    List<int> discountRate = [];
    final discountCodeSnapshot =
        await _databaseRef.child('discountCode').once();
    final discountData =
        discountCodeSnapshot.snapshot.value as Map<dynamic, dynamic>;

    if (discountData != null) {
      discountData.forEach((key, value) {
        discount.add(value['code'] +
            "\n" +
            value['discount_name'] +
            "\n" +
            value['discount_rate'] +
            "%");
        discountRate.add(int.parse(value['discount_rate']));
      });

      setState(() {
        _discount = discount;
        _discountRate = discountRate;
      });

      // final code = discountData['code'];
      // final description = discountData['discount_description'];
      // final name = discountData['discount_name'];
      // final rate = discountData['discount_rate'];
      //
      // final discountText = '$code\n$description\nDiscount rate: $rate%';

      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Discount Code'),
          content: ListView.builder(
            itemCount: _discount.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap:() {

                  setState(() {
                    _selectedDiscountRate = _discountRate[index];
                  });

                  Navigator.of(context).pop();
                },
                child: Text(_discount[index]),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(_items[index]),
                    subtitle: Text('\$ ${_prices[index].toString()}'),
                    value: _checkedItems[index],
                    onChanged: (value) {
                      setState(() {
                        _checkedItems[index] = value!;
                      });
                    },
                  );
                },
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Price:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  '\$ ${_totalPrice()}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Add discount functionality here
                    _showDiscountCodeDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueGrey[600],
                  ),
                  child: const Text('Apply Discount'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add payment functionality here
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Payment Successful'),
                        content: const Text('Thank you for your payment.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Close'),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text('Pay Now'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
