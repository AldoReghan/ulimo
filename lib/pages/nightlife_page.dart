import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ulimo/pages/nightlifedetail_page.dart';
import 'package:ulimo/pages/ridesharebusdetail_page.dart';
import 'package:ulimo/widget/ride_item.dart';

import '../base/base_background_scaffold.dart';
import '../base/utils.dart';

class NightLifePage extends StatefulWidget {
  const NightLifePage({Key? key}) : super(key: key);

  @override
  _NightLifePageState createState() => _NightLifePageState();
}

class _NightLifePageState extends State<NightLifePage> {
  late List<Map<dynamic, dynamic>> _destinationList;
  final _databaseRef = FirebaseDatabase.instance.ref('nightlife');

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
        if (value['description'] != null && value['name'] != null) {
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
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return defaultBackgroundScaffold(
        scaffold: Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 55,
            ),
            Container(
              // group7560fov (0:367)
              margin:
                  EdgeInsets.fromLTRB(20 * fem, 0 * fem, 20 * fem, 5.92 * fem),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      // arrowQFi (0:368)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 27 * fem, 0 * fem),
                      width: 24 * fem,
                      height: 24 * fem,
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 24 * fem,
                        color: Colors.white,
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
                          text: 'NightLife ',
                        ),
                        TextSpan(
                          text: 'Deals',
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
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return rideItem(
                            fem: fem,
                            ffem: ffem,
                            title: "The Tampa Club",
                            ticketType: "Ride ticket",
                            ticketType2: "Entry ticket",
                            imageUrl: "https://store-images.s-microsoft.com/image/"
                            "apps.47288.14188059920471079.8845931d-"
                            "936f-4c5b-848c-e9700ef87a6b.92da2b6e-01a3-"
                            "4806-8575-6f6278ecd71b?q=90&w=480&h=270",
                            onTap: () {
                              //do something
                            });
                      })),
            ),
          ],
        ),
      ),
    ));
  }
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: const Text('Night Life'),
//     ),
//     body: _destinationList.isEmpty
//         ? const Center(child: CircularProgressIndicator())
//         : ListView.builder(
//             itemCount: _destinationList.length,
//             itemBuilder: (context, index) {
//               return GestureDetector(
//                 onTap: () {
//                   final documentId = _destinationList[index]['documentId'];
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => NightLifePageDetailPage(destinationId: documentId),
//                     ));
//                 },
//                 child: Card(
//                   elevation: 4,
//                   margin: const EdgeInsets.symmetric(
//                     vertical: 8,
//                     horizontal: 16,
//                   ),
//                   child: ListTile(
//                     title: Text(_destinationList[index]['name']),
//                     subtitle: Text(
//                       _destinationList[index]['description'],
//                     ),
//                     trailing: const Icon(Icons.arrow_forward),
//                   ),
//                 ),
//               );
//             },
//           ),
//   );
// }
}
