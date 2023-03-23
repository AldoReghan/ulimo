import 'package:connectivity/connectivity.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ulimo/pages/ridesharebusdetail_page.dart';

import '../base/base_background_scaffold.dart';
import '../base/utils.dart';
import '../widget/ride_item.dart';

class RideShareBusPage extends StatefulWidget {
  const RideShareBusPage({Key? key}) : super(key: key);

  @override
  _RideShareBusPageState createState() => _RideShareBusPageState();
}

class _RideShareBusPageState extends State<RideShareBusPage> {
  late List _destinationList;
  final _databaseRef = FirebaseDatabase.instance.ref();

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _destinationList = [];
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      final destinationSnapshot = await _databaseRef
          .child('destination')
          .orderByChild('destination_type')
          .equalTo('share')
          .once();

      final Map<dynamic, dynamic>? destinationData =
          destinationSnapshot.snapshot.value as Map<dynamic, dynamic>?;
      final List tempList = [];

      if (destinationData != null) {
        destinationData.forEach((key, value) async {
          final destinationMap = {
            'id': key,
            'name': value['destination_name'],
            // 'description': value['destination_description'],
            'image_url': value['destination_image_url'],
            // 'address': value['destination_address'],
            // 'type': value['destination_type'],
          };
          tempList.add(destinationMap);
        });
      }

      setState(() {
        _destinationList = tempList;
      });
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
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return defaultBackgroundScaffold(
        scaffold: Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 55,
                  ),
                  Container(
                    // group7560fov (0:367)
                    margin: EdgeInsets.fromLTRB(
                        20 * fem, 0 * fem, 20 * fem, 5.92 * fem),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            // arrowQFi (0:368)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 27 * fem, 0 * fem),
                            width: 24 * fem,
                            height: 24 * fem,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 24 * fem,
                                color: Colors.white,
                              ),
                            )),
                        RichText(
                          // nightlifedealsK7n (0:372)
                          text: TextSpan(
                            style: SafeGoogleFont(
                              'Saira',
                              fontSize: 24 * ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.575 * ffem / fem,
                              color: const Color(0xffffffff),
                            ),
                            children: [
                              const TextSpan(
                                text: 'Ride ',
                              ),
                              TextSpan(
                                text: 'Tickets',
                                style: SafeGoogleFont(
                                  'Saira',
                                  fontSize: 24 * ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.575 * ffem / fem,
                                  color: const Color(0xfffdcb5b),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                        // autogrouplczqZkt (B1LAVsAXW7wCDsdiquLCZq)
                        padding: EdgeInsets.fromLTRB(
                            20 * fem, 25.21 * fem, 20 * fem, 3 * fem),
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: _destinationList.length,
                            itemBuilder: (context, index) {
                              return rideItem(
                                  fem: fem,
                                  ffem: ffem,
                                  title: _destinationList[index]['name'],
                                  ticketType: "Ride ticket",
                                  ticketType2: "Entry ticket",
                                  imageUrl: _destinationList[index]
                                      ['image_url'],
                                  onTap: () {
                                    //do something
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RideShareBusDetailPage(
                                                    destinationId:
                                                        _destinationList[index]
                                                            ['id'])));
                                  });
                            })),
                  ),
                ],
              ),
      ),
    ));
  }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: const Text('Ride Share Bus'),
//     ),
//     body: Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 _selectedDate,
//                 style: const TextStyle(fontSize: 18),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   _selectDate(context);
//                 },
//                 child: const Text("Select Date"),
//               ),
//             ],
//           ),
//         ),
//         Expanded(
//           child: _destinationIds.isEmpty
//               ? const Center(
//                   child: Text("Data Kosong"),
//                 )
//               : ListView.builder(
//                   itemCount: _destinationIds.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(_destinationIds[index]['name']),
//                       subtitle: Text(_destinationIds[index]['description']),
//                       onTap: () {
//                         //Navigate to detail page
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => RideShareBusDetailPage(
//                                       destinationId: _destinationIds[index]
//                                           ['id'],
//                                     )));
//                       },
//                     );
//                   },
//                 ),
//         ),
//       ],
//     ),
//   );
// }
}
