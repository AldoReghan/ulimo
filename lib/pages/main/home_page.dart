import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ulimo/pages/nightlifedetail_page.dart';

import '../../base/base_color.dart';
import '../../widget/home_card.dart';
import '../../widget/home_place_recomendation_list.dart';
import '../nightlife_page.dart';
import '../private_ride.dart';
import '../ridesharebus_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth authData = FirebaseAuth.instance;

  late List _destinationList;
  final _databaseRef = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    _destinationList = [];
    _fetchData();
  }

  User? getCurrentUser() {
    return authData.currentUser;
  }

  Future<void> _fetchData() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      final destinationSnapshot =
          await _databaseRef.child('destination').limitToFirst(15).once();

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
            'address': value['destination_address'],
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
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
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
                "Hello, ${getCurrentUser()?.displayName != "" ? getCurrentUser()?.displayName : "Set Your Name"}.",
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
                  title: "Ride Share Bus",
                  subtitle: "Socialize and make new friends",
                  imageAsset: "assets/icon/home_car.png",
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
                  title: "Private Ride",
                  subtitle: "Custom trips for just you and group",
                  imageAsset: "assets/icon/home_bus.png",
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
                    }
                  }),
              const SizedBox(
                height: 10,
              ),
              homeCard(
                  title: "Nightlife Deals For You",
                  subtitle: "The best nightlife deals around you",
                  imageAsset: "assets/icon/home_moon.png",
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
                "Tampa",
                style: TextStyle(fontSize: 18, color: yellowPrimary),
              ),
              const SizedBox(
                height: 3,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: SvgPicture.asset("assets/icon/home_underline.svg")),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 260,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: _destinationList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: recomendationListLayout(context, onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NightLifePageDetailPage(
                                      destinationId: _destinationList[index]
                                          ['id'])),
                            );
                          },
                              name: _destinationList[index]['name'],
                              address: _destinationList[index]['address'],
                              imageUrl: _destinationList[index]['image_url']));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
