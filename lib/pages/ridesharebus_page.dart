import 'package:connectivity/connectivity.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ulimo/pages/ridesharebusdetail_page.dart';

import '../base/base_background_scaffold.dart';
import '../base/base_color.dart';
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

  late List _marketSectionList;
  int? selectedMarketChip;

  @override
  void initState() {
    super.initState();
    _destinationList = [];
    _marketSectionList = [];
    _fetchMarketSection();
    _fetchData();
  }

  Future<void> _fetchMarketSection() async {
    final marketSectionSnapshot =
        await _databaseRef.child('marketSection').once();

    final Map<dynamic, dynamic>? marketSectionData =
        marketSectionSnapshot.snapshot.value as Map<dynamic, dynamic>?;
    final List tempMarketSectionList = [];

    if (marketSectionData != null) {
      marketSectionData.forEach((key, value) async {
        final marketSectionMap = {
          'id': key,
          'market_section': value['market_section_name'],
        };
        tempMarketSectionList.add(marketSectionMap);
      });
    }

    setState(() {
      _marketSectionList = tempMarketSectionList.reversed.toList();
    });

    // _fetchDestinationByMarket();
  }

  Future<void> _fetchDestinationByMarket() async {
    setState(() {
      _isLoading = true;
    });

    final rideShareDestinationSnapshot = await _databaseRef
        .child('rideShareBusDestination')
        //filter y category
        .orderByChild("market_section")
        .equalTo(_marketSectionList[selectedMarketChip ?? 0]['id'])
        .once();

    final Map<dynamic, dynamic>? rideShareDestinationData =
        rideShareDestinationSnapshot.snapshot.value as Map<dynamic, dynamic>?;
    final List tempDestinationByMarket = [];

    if (rideShareDestinationData != null) {
      rideShareDestinationData.forEach((key, value) async {
        final rideShareMap = {
          'id': key,
          'name': value['destination_name'],
          'image_url': value['destination_image_url'],
          'address': value['destination_address'],
          'type': 'rideShare',
          'market_section': value['market_section']
        };
        tempDestinationByMarket.add(rideShareMap);
      });
    }

    setState(() {
      _destinationList = tempDestinationByMarket.reversed.toList();
    });

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      final destinationSnapshot = await _databaseRef
          .child('rideShareBusDestination')
          // .orderByChild('destination_type')
          // .equalTo('share')
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
        _destinationList = tempList.reversed.toList();
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 55,
            ),
            Container(
              // group7560fov (0:367)
              margin:
                  EdgeInsets.fromLTRB(20 * fem, 0 * fem, 20 * fem, 15.92 * fem),
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
                          text: 'Ride Share ',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: SingleChildScrollView(
                //clipBehavior: Clip.antiAliasWithSaveLayer,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children:
                      List<Widget>.generate(_marketSectionList.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(
                            "${_marketSectionList[index]['market_section']}"),
                        selected: (selectedMarketChip ?? -1) == index,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              selectedMarketChip = index;
                            });
                            //refresh data with selected chip
                            _fetchDestinationByMarket();
                          } else {
                            setState(() {
                              selectedMarketChip = -1;
                            });
                            _fetchData();
                          }
                        },
                        selectedColor: yellowPrimary,
                      ),
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: Container(
                        // autogrouplczqZkt (B1LAVsAXW7wCDsdiquLCZq)
                        padding: EdgeInsets.fromLTRB(
                            20 * fem, 5.21 * fem, 20 * fem, 3 * fem),
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
}
