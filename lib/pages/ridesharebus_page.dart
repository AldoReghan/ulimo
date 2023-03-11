import 'package:connectivity/connectivity.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ulimo/pages/ridesharebusdetail_page.dart';

class RideShareBusPage extends StatefulWidget {
  const RideShareBusPage({Key? key}) : super(key: key);

  @override
  _RideShareBusPageState createState() => _RideShareBusPageState();
}

class _RideShareBusPageState extends State<RideShareBusPage> {
  late List<Map<dynamic, dynamic>> _destinationList;
  final _databaseRef = FirebaseDatabase.instance.ref('rideShareBusDestination');

  @override
  void initState() {
    super.initState();
    _destinationList = [];
    _fetchData();
  }

  Future<void> _fetchData() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      final snapshot = await _databaseRef.once();
      final Map<dynamic, dynamic>? data = snapshot.snapshot.value as Map?;
      if (data != null) {
        final List<Map<String, dynamic>> tempList = [];
        data.forEach((key, value) {
          if (value['destination_description'] != null &&
              value['destination_name'] != null) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ride Share Bus'),
      ),
      body: _destinationList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _destinationList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    final documentId = _destinationList[index]['documentId'];
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RideShareBusDetailPage(destinationId: documentId),
                        ));
                  },
                  child: Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    child: ListTile(
                      title: Text(_destinationList[index]['destination_name']),
                      subtitle: Text(
                        _destinationList[index]['destination_description'],
                      ),
                      trailing: const Icon(Icons.arrow_forward),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
