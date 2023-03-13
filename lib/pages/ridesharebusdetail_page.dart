import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ulimo/pages/thank_you_page.dart';

class RideShareBusDetailPage extends StatefulWidget {
  final String destinationId;
  const RideShareBusDetailPage({Key? key, required this.destinationId})
      : super(key: key);

  @override
  _RideShareBusDetailPageState createState() => _RideShareBusDetailPageState();
}

class _RideShareBusDetailPageState extends State<RideShareBusDetailPage> {
  late List<Map<dynamic, dynamic>> _destinationList;
  final _databaseRef = FirebaseDatabase.instance;
  String? _selectedTime;

  final _formKey = GlobalKey<FormState>();
  final _quantityController = TextEditingController(text: '0');

  @override
  void initState() {
    super.initState();
    _destinationList = [];
    _fetchData(widget.destinationId);
  }

  Future<void> _fetchData(String destinationId) async {
    final snapshot = await FirebaseDatabase.instance
        .ref('rideShareBusTicket')
        .orderByChild('destination_id')
        .equalTo(destinationId)
        .once();
    final Map<dynamic, dynamic>? data =
        snapshot.snapshot.value as Map<dynamic, dynamic>?;
    if (data != null) {
      final List<Map<String, dynamic>> tempList = [];
      data.forEach((key, value) {
        if (value['time'] != null) {
          tempList.add({
            'documentId': key, // add documentId to the map
            ...value, // add all other fields from the value map
          });
        }
      });
      setState(() {
        _destinationList = tempList;
      });
    }
  }

  void _showQuantityForm(BuildContext context) {
    final TextEditingController _quantityController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Quantity'),
          content: TextField(
            controller: _quantityController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Enter Quantity',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final String quantity = _quantityController.text.trim();
                if (quantity.isNotEmpty) {
                  _saveData(quantity);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _saveData(String quantity) async {
    final total_price = double.parse(_destinationList[0]['price'].toString()) *
        int.parse(quantity);
    await _databaseRef.ref('cart').push().set({
      'destination_id': _destinationList[0]['destination_id'],
      'time': _selectedTime,
      'user_id': _destinationList[0]['destination_id'],
      'quantity': quantity,
      'price': total_price,
      'status': 'waiting',
    });
    setState(() {
      _selectedTime = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ride Share Bus'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _destinationList.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _destinationList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedTime =
                                _destinationList[index]['time'] as String?;
                            _quantityController.text = '0';
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: _isSelectedTime(
                                    _destinationList[index]['time'] as String)
                                ? Colors.blue
                                : Colors.white,
                            border: Border.all(
                              color: Colors.blue,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            _destinationList[index]['time'] as String,
                            style: TextStyle(
                              color: _isSelectedTime(
                                      _destinationList[index]['time'] as String)
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Expanded(
            child: _selectedTime == null
                ? const Center(child: Text('Please select time'))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _destinationList.length,
                    itemBuilder: (context, index) {
                      if (_destinationList[index]['time'] == _selectedTime &&
                          _isSelectedTime(_selectedTime!)) {
                        return Form(
                          key: _formKey,
                          child: Card(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Quantity',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      (_quantityController.text == '0')
                                          ? Container()
                                          : IconButton(
                                              onPressed: () {
                                                if (_quantityController
                                                    .text.isNotEmpty) {
                                                  int currentValue = int.parse(
                                                      _quantityController.text);
                                                  setState(() {
                                                    currentValue--;
                                                    _quantityController.text =
                                                        (currentValue > 0
                                                                ? currentValue
                                                                : 0)
                                                            .toString();
                                                  });
                                                }
                                              },
                                              icon: const Icon(Icons.remove),
                                            ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: TextFormField(
                                          controller: _quantityController,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'Enter quantity',
                                          ),
                                          enabled: false,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty ||
                                                value == '0') {
                                              return 'Please enter a quantity';
                                            }
                                            int? parsedValue =
                                                int.tryParse(value);
                                            if (parsedValue == null ||
                                                parsedValue <= 0) {
                                              return 'Please enter a valid quantity';
                                            }
                                            if (parsedValue >
                                                int.parse(
                                                    _destinationList[index]
                                                        ['quantity'])) {
                                              return 'Exceeds available quantity';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      (_quantityController.text ==
                                              _destinationList[index]
                                                  ['quantity'])
                                          ? Container()
                                          : IconButton(
                                              onPressed: () {
                                                if (_quantityController
                                                    .text.isNotEmpty) {
                                                  int currentValue = int.parse(
                                                      _quantityController.text);
                                                  if (currentValue <
                                                      int.parse(
                                                          _destinationList[
                                                                  index]
                                                              ['quantity'])) {
                                                    setState(() {
                                                      currentValue++;
                                                      _quantityController.text =
                                                          currentValue
                                                              .toString();
                                                    });
                                                  }
                                                }
                                              },
                                              icon: const Icon(Icons.add),
                                            ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Price',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        '\$ ${NumberFormat("#,##0.00", "en_US").format((_destinationList[index]['price'] ?? 0) * int.parse(_quantityController.text))}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // redirect to thank you page
                                        _saveData(_quantityController.text);
                                      },
                                      child: const Text('Add to Cart'),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
          ),
        ],
      ),
    );
  }

  bool _isSelectedTime(String time) {
    return _selectedTime != null && _selectedTime == time;
  }
}
