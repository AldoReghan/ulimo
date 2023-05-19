import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ulimo/pages/nightlifedetail_page.dart';
import 'package:ulimo/pages/ridesharebusdetail_page.dart';

import '../../base/base_color.dart';
import '../../widget/home_card.dart';
import '../../widget/home_place_recomendation_list.dart';
import '../nightlife_page.dart';
import '../phone_login_pages.dart';
import '../private_ride.dart';
import '../ridesharebus_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth authData = FirebaseAuth.instance;

  bool _isLoading = true;
  bool _isLoadingDestination = true;
  bool _isLoadingNightlife = true;

  late List _nightlifeList;
  late List _nightlifeGroupList;
  late List _destinationByMarketList;
  late List _marketSectionList;
  int selectedMarketChip = 0;
  int selectedNightlifeChip = 0;
  final _databaseRef = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    checkUserIsLogin();
    _nightlifeList = [];
    _nightlifeGroupList = [];
    _destinationByMarketList = [];
    _marketSectionList = [];
    _fetchMarketSection();
    // _fetchDestinationData();
    // _fetchNightlifeData();
    // _fetchData();
  }

  Future<void> checkUserIsLogin() async {
    final userSnapshot = await FirebaseDatabase.instance
        .ref()
        .child('users')
        .orderByChild('uid')
        .equalTo(authData.currentUser?.uid)
        .once();

    final Map<dynamic, dynamic>? userData =
        userSnapshot.snapshot.value as Map<dynamic, dynamic>?;

    if (userData == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Session expired, please login again'),
          backgroundColor: Colors.red,
        ),
      );
      Navigator.popUntil(context, (route) => false);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PhoneLoginPage()),
      );
    }
  }

  User? getCurrentUser() {
    return authData.currentUser;
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

    _fetchDestinationByMarket();
  }

  Future<void> _fetchDestinationByMarket() async {
    setState(() {
      _isLoadingDestination = true;
    });

    final rideShareDestinationSnapshot = await _databaseRef
        .child('rideShareBusDestination')
        //filter y category
        .orderByChild("market_section")
        .equalTo(_marketSectionList[selectedMarketChip]['id'])
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

    final nightlifeSnapshot = await _databaseRef
        .child('nightlifeDestination')
        .orderByChild("market_section")
        .equalTo(_marketSectionList[selectedMarketChip]['id'])
        .once();

    final Map<dynamic, dynamic>? nightlifeData =
        nightlifeSnapshot.snapshot.value as Map<dynamic, dynamic>?;

    if (nightlifeData != null) {
      nightlifeData.forEach((key, value) async {
        final nightlifeMap = {
          'id': key,
          'name': value['destination_name'],
          'type': 'nightlife',
          'image_url': value['destination_image_url'],
          'address': value['destination_address'],
        };
        tempDestinationByMarket.add(nightlifeMap);
      });
    }

    tempDestinationByMarket.sort((a,b){
      return a['name'].compareTo(b['name']);
    });

    setState(() {
      _destinationByMarketList = tempDestinationByMarket;
    });

    setState(() {
      _isLoadingDestination = false;
    });
  }

  // Future<void> _fetchData() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult != ConnectivityResult.none) {
  //     final nightlifeSnapshot = await _databaseRef
  //         .child('nightlifeDestination')
  //         .limitToLast(15)
  //         .once();
  //
  //     final Map<dynamic, dynamic>? destinationData =
  //         nightlifeSnapshot.snapshot.value as Map<dynamic, dynamic>?;
  //     final List tempNightlifeList = [];
  //
  //     if (destinationData != null) {
  //       destinationData.forEach((key, value) async {
  //         final destinationMap = {
  //           'id': key,
  //           'name': value['destination_name'],
  //           // 'description': value['destination_description'],
  //           'image_url': value['destination_image_url'],
  //           'address': value['destination_address']
  //         };
  //         tempNightlifeList.add(destinationMap);
  //       });
  //     }
  //
  //     setState(() {
  //       _nightlifeList = tempNightlifeList;
  //     });
  //   } else {
  //     // ignore: use_build_context_synchronously
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: const Text("No Internet Connection"),
  //           content: const Text("Please check your internet connection."),
  //           actions: [
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: const Text("OK"),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.normal),
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 24),
              Text(
                "Hello, ${getCurrentUser()?.displayName != "" ? getCurrentUser()?.displayName : "Set Your Name"}",
                style: const TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 28,
              ),
              RichText(
                  textAlign: TextAlign.start,
                  text: const TextSpan(
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                      children: [
                        TextSpan(text: "Travel like a Rockstar when "),
                        TextSpan(
                            text: "ULimo",
                            style: TextStyle(color: yellowPrimary)),
                      ])),
              const SizedBox(height: 24),
              homeCard(
                  title: "Private Ride",
                  subtitle: "Custom trips for just you and group",
                  imageAsset: "assets/icon/home_private_ride.svg",
                  onTap: () {
                    //go to private ride page
                    if (getCurrentUser()?.displayName == "") {
                      Fluttertoast.showToast(
                          msg: "Please add your name first in profile menu",
                          backgroundColor: Colors.red);
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const PrivateRidePage())));
                      // throw Exception();
                    }
                  }),
              const SizedBox(
                height: 10,
              ),
              homeCard(
                  title: "Ride Share Bus",
                  subtitle: "Socialize and make new friends",
                  imageAsset: "assets/icon/home_ride_share.svg",
                  onTap: () {
                    //go to share bus page
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const RideShareBusPage())));
                  }),
              const SizedBox(
                height: 10,
              ),
              homeCard(
                  title: "Nightlife Deals",
                  subtitle: "The best nightlife deals around you",
                  imageAsset: "assets/icon/home_nightlife.svg",
                  onTap: () {
                    //go to night life page
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const NightLifePage())));
                  }),
              const SizedBox(
                height: 36,
              ),
              const Text(
                "Top Destinations",
                style: TextStyle(fontSize: 18, color: yellowPrimary),
              ),
              SingleChildScrollView(
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
                        selected: selectedMarketChip == index,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              selectedMarketChip = index;
                            });
                            //refresh data with selected chip
                            _fetchDestinationByMarket();
                          }
                        },
                        selectedColor: yellowPrimary,
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: SvgPicture.asset(
                    "assets/icon/home_arrow_continue.svg",
                    width: 30,
                  )),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 260,
                child: _isLoadingDestination
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: _destinationByMarketList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: recommendationListLayout(context,
                                  onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            _destinationByMarketList[index]
                                                        ['type'] ==
                                                    'rideShare'
                                                ? RideShareBusDetailPage(
                                                    destinationId:
                                                        _destinationByMarketList[
                                                            index]['id'])
                                                : NightLifePageDetailPage(
                                                    nightlifeDestinationId:
                                                        _destinationByMarketList[
                                                            index]['id'])));
                              },
                                  name: _destinationByMarketList[index]['name'],
                                  address: _destinationByMarketList[index]
                                      ['address'],
                                  imageUrl: _destinationByMarketList[index]
                                      ['image_url']));
                        }),
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
