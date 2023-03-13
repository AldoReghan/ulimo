import 'package:connectivity/connectivity.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ulimo/pages/ridesharebusdetail_page.dart';

class RideShareBusPage extends StatefulWidget {
  const RideShareBusPage({Key? key}) : super(key: key);

  @override
  _RideShareBusPageState createState() => _RideShareBusPageState();
}

class _RideShareBusPageState extends State<RideShareBusPage> {
  late List _destinationIds;
  final _databaseRef = FirebaseDatabase.instance.ref();
  late String _selectedDate;
  final DateFormat _dateFormat = DateFormat('dd-MM-yyyy');

  @override
  void initState() {
    super.initState();
    _destinationIds = [];
    _selectedDate = _dateFormat.format(DateTime.now());
    _fetchData();
  }

  Future<void> _fetchData() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      final ticketSnapshot = await _databaseRef
          .child('rideShareBusTicketOrder')
          .orderByChild('date')
          .equalTo(_selectedDate)
          .once();

      final Map<dynamic, dynamic>? ticketData =
          ticketSnapshot.snapshot.value as Map<dynamic, dynamic>?;
      final List tempList = [];

      if (ticketData != null) {
        ticketData.forEach((key, value) async {
          final ridesharebusticket = await _databaseRef
              .child('rideShareBusTicket')
              .orderByKey()
              .equalTo(value['rideShareBusTicket_id'])
              .once();

          final Map<dynamic, dynamic>? ridesharebusticketData =
              ridesharebusticket.snapshot.value as Map<dynamic, dynamic>?;

          if (ridesharebusticketData != null) {
            ridesharebusticketData.forEach((key, value) async {
              final destinationSnapshot = await _databaseRef
                  .child('rideShareBusDestination')
                  .orderByKey()
                  .equalTo(value['destination_id'])
                  .once();

              final Map<dynamic, dynamic>? destinationData =
                  destinationSnapshot.snapshot.value as Map<dynamic, dynamic>?;

              if (destinationData != null) {
                destinationData.forEach((key, value) {
                  final destinationMap = {
                    'id': key,
                    'name': value['destination_name'],
                    'description': value['destination_description'],
                  };
                  tempList.add(destinationMap);
                });

                setState(() {
                  _destinationIds = tempList;
                });
              }
            });
          }
        });
      }
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("No Internet Connection"),
            content: const Text("Please check your internet connection."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      // initialDate: DateTime.parse(_selectedDate),
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      final newSelectedDate = DateFormat('dd-MM-yyyy').format(picked);
      if (newSelectedDate != _selectedDate) {
        setState(() {
          _selectedDate = newSelectedDate;
          _destinationIds = [];
        });
        _fetchData();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ride Share Bus'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedDate,
                  style: const TextStyle(fontSize: 18),
                ),
                ElevatedButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  child: const Text("Select Date"),
                ),
              ],
            ),
          ),
          Expanded(
            child: _destinationIds.isEmpty
                ? const Center(
                    child: Text("Data Kosong"),
                  )
                : ListView.builder(
                    itemCount: _destinationIds.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_destinationIds[index]['name']),
                        subtitle: Text(_destinationIds[index]['description']),
                        onTap: () {
                          //Navigate to detail page
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RideShareBusDetailPage(
                                        destinationId: _destinationIds[index]
                                            ['id'],
                                      )));
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
