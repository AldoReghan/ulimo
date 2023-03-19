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
import 'home/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {



    final List<Widget> mainScreens = [
      const HomePage(),
      CartPage(user_id: "user_id"),
      const UserProfilePage(),
    ];

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
        body: mainScreens[selectedIndex],
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
            setState(() {
              selectedIndex = index;
            });
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
