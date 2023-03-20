import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
              const Text(
                "Hello, Daniel",
                style: TextStyle(color: Colors.white, fontSize: 18),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const PrivateRidePage())));
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
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: recomendationListLayout(context, onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const NightLifePageDetailPage(
                                          destinationId: "destinationId")),
                            );
                          }));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
