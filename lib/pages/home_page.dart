import 'package:flutter/material.dart';
import 'package:ulimo/pages/cart_page.dart';
import 'package:ulimo/pages/nightlife_page.dart';
import 'package:ulimo/pages/private_ride.dart';
import 'package:ulimo/pages/ridesharebus_page.dart';
import 'package:ulimo/pages/userprofile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
          actions: [
            IconButton(
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const UserProfilePage()));
                },
                icon: const Icon(Icons.person)),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CardView(
                title: 'Private Ride',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const PrivateRidePage())));
                },
              ),
              const SizedBox(height: 16.0),
              CardView(
                title: 'Ride Share Bus',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const RideShareBusPage())));
                },
              ),
              const SizedBox(height: 16.0),
              CardView(
                title: 'Night Life',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const NightLifePage())));
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => CartPage(
                            user_id: '-NPcUkP6HIjb8nxqcFV9',
                          ))));
            },
            child: const Icon(Icons.shopping_cart_outlined)));
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
