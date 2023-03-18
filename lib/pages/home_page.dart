import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ulimo/base/base_background_scaffold.dart';
import 'package:ulimo/pages/cart_page.dart';
import 'package:ulimo/pages/nightlife_page.dart';
import 'package:ulimo/pages/private_ride.dart';
import 'package:ulimo/pages/ridesharebus_page.dart';
import 'package:ulimo/pages/userprofile_page.dart';
import 'package:ulimo/widget/custom_bottom_navigation_bar.dart';
import 'package:ulimo/widget/home_card.dart';
import 'package:ulimo/widget/home_place_recomendation_list.dart';

import '../base/base_color.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return defaultBackgroundScaffold(
      scaffold: Scaffold(
        backgroundColor: Colors.transparent,
        // appBar: AppBar(
        //   title: const Text('Home Page'),
        //   actions: [
        //     IconButton(
        //         onPressed: () {
        //           // Navigator.push(
        //           //     context,
        //           //     MaterialPageRoute(
        //           //         builder: (context) => const UserProfilePage()));
        //         },
        //         icon: const Icon(Icons.person)),
        //     IconButton(
        //       icon: const Icon(Icons.logout),
        //       onPressed: () {
        //         Navigator.pop(context);
        //       },
        //     ),
        //   ],
        // ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
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
                                  builder: ((context) =>
                                      const RideShareBusPage())));
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
                      child: Flexible(
                        fit: FlexFit.loose,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: recomendationListLayout(context));
                            }),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //     onPressed: () {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //               builder: ((context) =>
        //                   CartPage(
        //                     user_id: '-NPcUkP6HIjb8nxqcFV9',
        //                   ))));
        //     },
        //     child: const Icon(Icons.shopping_cart_outlined))
        bottomNavigationBar: CustomBottomNavigationBar(
          icons: const [
            "assets/icon/bottom_nav_home.svg",
            "assets/icon/bottom_nav_ticket.svg",
            "assets/icon/bottom_nav_profile.svg"
          ],
          onTap: (index) {
            //do some thing
          },
          labels: const ['Home', 'Ticket', 'Profile'],
          selectedIcons: const [
            "assets/icon/bottom_nav_home_selected.svg",
            "assets/icon/bottom_nav_ticket_selected.svg",
            "assets/icon/bottom_nav_profile_selected.svg"
          ],
        ),
      ),
    );
  }
}

class CardView extends StatelessWidget {
  const CardView({Key? key, required this.title, required this.onPressed})
      : super(key: key);

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      child: Card(
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
