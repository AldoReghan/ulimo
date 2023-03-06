import 'package:flutter/material.dart';
import 'package:ulimo/pages/nightlife_page.dart';
import 'package:ulimo/pages/private_ride.dart';
import 'package:ulimo/pages/ridesharebus_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CardView(
              title: 'Private Ride',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) => PrivateRidePage())));
              },
            ),
            const SizedBox(height: 16.0),
            CardView(
              title: 'Ride Share Bus',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) => RideShareBusPage())));
              },
            ),
            const SizedBox(height: 16.0),
            CardView(
              title: 'Night Life',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) => NightLifePage())));
              },
            ),
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
