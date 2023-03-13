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
    for (int i = 0; i < _checkedItems.length; i++) {
      if (_checkedItems[i]) {
        totalPrice += _prices[i];
      }
    }
    return totalPrice;
  }

  void _showDiscountCodeDialog() async {
    final discountCodeRef = FirebaseDatabase.instance.ref("discountCode");
    final snapshot = await discountCodeRef.once();
    final value = snapshot.snapshot.value as Map<dynamic, dynamic>;

    if (value != null) {
      final code = value['code'];
      final description = value['discount_description'];
      final name = value['discount_name'];
      final rate = value['discount_rate'];

      final discountText = '$code\n$description\nDiscount rate: $rate%';

      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Discount Code'),
          content:
              Text('Use this code to get a discount:\n$code\n\n$discountText'),
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
