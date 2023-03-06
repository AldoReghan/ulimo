import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ulimo/pages/nightlifedetail_page.dart';
import 'package:ulimo/pages/ridesharebusdetail_page.dart';

class NightLifePage extends StatefulWidget {
  const NightLifePage({Key? key}) : super(key: key);

  @override
  _NightLifePageState createState() => _NightLifePageState();
}

class _NightLifePageState extends State<NightLifePage> {
  late List<Map<dynamic, dynamic>> _destinationList;
  final _databaseRef =FirebaseDatabase.instance.ref('nightlife');

  @override
  void initState() {
    super.initState();
    _destinationList = [];
    _fetchData();
  }

  Future<void> _fetchData() async {
  final snapshot = await _databaseRef.once();
  final Map<dynamic, dynamic>? data = snapshot.snapshot.value as Map?;
  if (data != null) {
    final List<Map<String, dynamic>> tempList = [];
    data.forEach((key, value) {
      if (value['description'] != null &&
          value['name'] != null) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Night Life'),
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
                        builder: (context) => NightLifePageDetailPage(destinationId: documentId),
                      ));
                  },
                  child: Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    child: ListTile(
                      title: Text(_destinationList[index]['name']),
                      subtitle: Text(
                        _destinationList[index]['description'],
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