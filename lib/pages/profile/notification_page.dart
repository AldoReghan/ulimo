import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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
  FirebaseAuth authData = FirebaseAuth.instance;

  final _databaseRef = FirebaseDatabase.instance.ref();
  late List _notificationData;
  bool _isLoading = true;

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    final notificationSnapshot = await _databaseRef
        .child('notifications')
        .orderByChild('user_id')
        .equalTo(authData.currentUser?.uid)
        .once();

    final Map<dynamic, dynamic>? notificationData =
        notificationSnapshot.snapshot.value as Map<dynamic, dynamic>?;

    if (notificationData != null) {
      final List tempNotificationData = [];
      notificationData.forEach((key, value) {
        final notificationMap = {
          'title': value['title'],
          'subtitle': value['subtitle'],
          'date': value['date'],
          'time': value['time']
        };

        tempNotificationData.add(notificationMap);
      });
      setState(() {
        _notificationData = tempNotificationData;
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _notificationData = [];
    _fetchData();
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
                    itemCount: _notificationData.length,
                    itemBuilder: (context, index) {
                      return notificationItem(
                          fem: fem,
                          ffem: ffem,
                          title: _notificationData[index]['title'],
                          subtitle: _notificationData[index]['subtitle'],
                          timeStamp:
                              "${_notificationData[index]['date']} ${_notificationData[index]['time']}");
                    }),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
