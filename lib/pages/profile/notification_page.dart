import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ulimo/base/base_background_scaffold.dart';
import 'package:ulimo/widget/notification_item.dart';

import '../../base/utils.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return defaultBackgroundScaffold(
        scaffold: Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 40 * fem,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      // arrow7W8 (0:1031)
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
                          color: Colors.white,
                          size: 24 * fem,
                        ),
                      )),
                  Text(
                    // notificationspQY (0:1035)
                    'Notifications',
                    style: SafeGoogleFont(
                      'Saira',
                      fontSize: 24 * ffem,
                      fontWeight: FontWeight.w500,
                      height: 1.575 * ffem / fem,
                      color: const Color(0xffffffff),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 36 * fem,
              ),
              Expanded(
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return notificationItem(
                          fem: fem,
                          ffem: ffem,
                          title: "Private ride",
                          subtitle: "Your request has been accepted, visit the Ticket tab to pay.",
                          timeStamp: "03 FEB 2023 6:20 PM");
                    }),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
