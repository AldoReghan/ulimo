import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ulimo/base/base_background_scaffold.dart';
import 'package:ulimo/pages/profile/notification_page.dart';

import '../../base/utils.dart';
import '../../widget/profile_menu.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:intl/intl.dart';

import '../phone_login_pages.dart';

class UserProfilePage extends StatefulWidget {
  final BuildContext parentContext;

  const UserProfilePage({Key? key, required this.parentContext})
      : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  FirebaseAuth authData = FirebaseAuth.instance;

  final _databaseRef = FirebaseDatabase.instance.ref();
  late List _ticketListData;
  bool _isLoading = true;
  int _notificationCount = 0;

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
      _ticketListData.clear();
    });

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      final privateRideSnapshot = await _databaseRef
          .child('privateRide')
          .orderByChild('user_id')
          .equalTo(authData.currentUser?.uid)
          .once();

      final rideShareBusOrderSnapshot = await _databaseRef
          .child('rideShareBusTicketOrder')
          .orderByChild('users_id')
          .equalTo(authData.currentUser?.uid)
          .once();

      final nightlifeOrderSnapshot = await _databaseRef
          .child('nightlifeOrder')
          .orderByChild('users_id')
          .equalTo(authData.currentUser?.uid)
          .once();

      final Map<dynamic, dynamic>? nightlifeOrderData =
          nightlifeOrderSnapshot.snapshot.value as Map<dynamic, dynamic>?;

      final Map<dynamic, dynamic>? privateRideData =
          privateRideSnapshot.snapshot.value as Map<dynamic, dynamic>?;
      final Map<dynamic, dynamic>? rideShareBusOrderData =
          rideShareBusOrderSnapshot.snapshot.value as Map<dynamic, dynamic>?;
      final List tempRideShareBusOrderList = [];

      if (privateRideData != null ||
          rideShareBusOrderData != null ||
          nightlifeOrderData != null) {
        privateRideData?.forEach((key, value) async {
          final privateRideMap = {
            'id': key,
            'address': value['pickup_address'],
            'date': value['date'],
            'time': value['pickup_time'],
            'name': 'PRIVATE RIDE',
            'price': value['price'],
            'status': value['status']
          };
          // tempPrivateRideList.add(privateRideMap);
          setState(() {
            _ticketListData.add(privateRideMap);
          });
        });

        rideShareBusOrderData?.forEach((key, value) async {
          final destinationTicketSnapshot = await FirebaseDatabase.instance
              .ref('rideShareBusTicket')
              .orderByKey()
              .equalTo(value['rideShareBusTicket_id'])
              .once();

          final Map<dynamic, dynamic>? ticketData = destinationTicketSnapshot
              .snapshot.value as Map<dynamic, dynamic>?;

          if (ticketData != null) {
            ticketData.forEach((ticketKey, ticketValue) async {
              final destinationSnapshot = await FirebaseDatabase.instance
                  .ref('rideShareBusDestination')
                  .orderByKey()
                  .equalTo(ticketValue['destination_id'])
                  .once();

              final Map<dynamic, dynamic>? destinationData =
                  destinationSnapshot.snapshot.value as Map<dynamic, dynamic>?;

              destinationData?.forEach((destinationKey, destinationValue) {
                final rideShareBusOrderMap = {
                  'id': key,
                  'address': destinationValue['destination_address'],
                  'date': value['date'],
                  'time': ticketValue['time'],
                  'name': destinationValue['destination_name'],
                  'status': value['status']
                };
                tempRideShareBusOrderList.add(rideShareBusOrderMap);
                setState(() {
                  _ticketListData.add(rideShareBusOrderMap);
                });
              });
            });
          }
        });

        nightlifeOrderData?.forEach((key, value) async {
          final nightlifeDestinationSnapshot = await FirebaseDatabase.instance
              .ref('nightlifeDestination')
              .orderByKey()
              .equalTo(value['nightlife_id'])
              .once();

          final Map<dynamic, dynamic>? nightlifeDestinationData =
              nightlifeDestinationSnapshot.snapshot.value
                  as Map<dynamic, dynamic>?;

          nightlifeDestinationData?.forEach((destinationKey, destinationValue) {
            final nightlifeOrderMap = {
              'id': key,
              'address': destinationValue['destination_address'],
              'date': value['date'],
              'time': '',
              'name': destinationValue['destination_name'],
              'status': value['status']
            };
            setState(() {
              _ticketListData.add(nightlifeOrderMap);
            });
          });
        });
      }

      final notificationSnapshot = await _databaseRef
          .child('notifications')
          .orderByChild('user_id')
          .equalTo(authData.currentUser?.uid)
          .once();

      final Map<dynamic, dynamic>? notificationData =
          notificationSnapshot.snapshot.value as Map<dynamic, dynamic>?;

      if (notificationData != null) {
        setState(() {
          _notificationCount = notificationData.length;
        });
      }
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
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUserIsLogin();
    _ticketListData = [];
    _fetchData();
  }

  Future<void> deleteAccount(
      ) async{

    if(Platform.isIOS){
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text("Delete Account"),
          content: const Text("Are you sure you want to delete this account?"),
          actions: <Widget>[

            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text("Yes"),
              onPressed: () async {
                try{
                  await authData.currentUser?.delete();
                  Navigator.of(context).pop(true);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (_) => const PhoneLoginPage()),
                  );
                }catch(e){
                  Navigator.of(context).pop(true);
                  showCupertinoDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: const Text("Delete Account Failed", style: TextStyle(color: Colors.red),),
                      content: const Text("Login again and try to delete your account again"),
                      actions: <Widget>[

                        CupertinoDialogAction(
                          isDestructiveAction: true,
                          child: const Text("Ok"),
                          onPressed: () async {
                            try{
                              await authData.signOut();
                              Navigator.of(context).pop(true);
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (_) => const PhoneLoginPage()),
                              );
                            }catch(e){

                            }
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
            ),

            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text("No"),
              onPressed: () => Navigator.of(context).pop(false),
            ),

          ],
        ),
      );
    }else{
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delete Account"),
            content: const Text("Are you sure you want to delete this account?"),
            actions: [
              TextButton(
                onPressed: () async {
                  try{
                    await authData.currentUser?.delete();
                    Navigator.of(context).pop(true);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (_) => const PhoneLoginPage()),
                    );
                  }catch(e){
                    Navigator.of(context).pop(true);
                    showDialog(context: context, builder: (BuildContext context){
                      return AlertDialog(
                        title: const Text("Delete Account Failed", style: TextStyle(color: Colors.red),),
                        content: const Text("Login again and try to delete your account again"),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              await authData.signOut();
                              Navigator.of(context).pop(true);
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (_) => const PhoneLoginPage()),
                              );
                            },
                            child: const Text("Ok"),
                          ),
                        ],
                      );
                    });
                  }
                },
                child: const Text("Yes"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancel"),
              ),
            ],
          );
        },
      );
    }


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
        MaterialPageRoute(
            builder: (context) => const PhoneLoginPage()),
      );
    }
  }

  User? getCurrentUser() {
    return authData.currentUser;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
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
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 50),
              Container(
                // group7560aeL (0:603)
                margin: EdgeInsets.fromLTRB(
                    20.4 * fem, 0 * fem, 0 * fem, 0.1 * fem),
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // arrowuRi (0:604)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 27 * fem, 0 * fem),
                      child: Text(
                        // myprofilecqv (0:608)
                        'My Profile',
                        style: SafeGoogleFont(
                          'Saira',
                          fontSize: 24 * ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.575 * ffem / fem,
                          color: const Color(0xffffffff),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  // autogroupeqgtgYx (B1LFznqT5Bc34g7UgKEQgT)
                  padding: EdgeInsets.fromLTRB(
                      20 * fem, 36 * fem, 20 * fem, 0.21 * fem),
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // cardwtC (0:493)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0.4 * fem, 46 * fem),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // group7586TLk (0:494)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 4 * fem),
                                width: double.infinity,
                                height: 95 * fem,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      // group7585BnY (0:495)
                                      left: 0 * fem,
                                      top: 0 * fem,
                                      child: Container(
                                        width: 335 * fem,
                                        height: 95 * fem,
                                        decoration: BoxDecoration(
                                          color: const Color(0xa52b2b2b),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(6 * fem),
                                            topRight: Radius.circular(6 * fem),
                                          ),
                                        ),
                                        child: Align(
                                          // rectangle3sfN (0:497)
                                          alignment: Alignment.bottomCenter,
                                          child: SizedBox(
                                              width: 335 * fem,
                                              height: 0.44 * fem),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      // group7584CBr (0:498)
                                      top: 4.7908935547 * fem,
                                      child: SizedBox(
                                        width: 335 * fem,
                                        height: 85.42 * fem,
                                        child: Container(
                                          // group7578oBe (0:500)
                                          margin: EdgeInsets.fromLTRB(
                                              0 * fem,
                                              2.21 * fem,
                                              0 * fem,
                                              2.21 * fem),
                                          width: 134 * fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(
                                                    2 * fem),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: double.infinity,
                                                height: 29 * fem,
                                                child: Text(
                                                  getCurrentUser()
                                                      ?.displayName ==
                                                      ""
                                                      ? "Set Your Name"
                                                      : getCurrentUser()
                                                      ?.displayName ??
                                                      "",
                                                  textAlign: TextAlign.center,
                                                  style:
                                                  SafeGoogleFont(
                                                    'Saira',
                                                    fontSize:
                                                    18 * ffem,
                                                    fontWeight:
                                                    FontWeight
                                                        .w500,
                                                    height:
                                                    1.575 *
                                                        ffem /
                                                        fem,
                                                    color: const Color(
                                                        0xffffffff),
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(
                                                width: double.infinity,
                                                height: 19 * fem,
                                                child: Text(
                                                  authData.currentUser
                                                      ?.phoneNumber ??
                                                      "",
                                                  textAlign: TextAlign.center,
                                                  style:
                                                  SafeGoogleFont(
                                                    'Saira',
                                                    fontSize:
                                                    12 * ffem,
                                                    fontWeight:
                                                    FontWeight
                                                        .w500,
                                                    height:
                                                    1.575 *
                                                        ffem /
                                                        fem,
                                                    color: const Color(
                                                        0xa5aaaaaa),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                // group75835gt (0:507)
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        // rectangle4SXS (0:508)
                                        width: 335 * fem,
                                        height: 0.44 * fem),
                                    Container(
                                      // group7582BE8 (0:509)
                                      padding: EdgeInsets.fromLTRB(143.5 * fem,
                                          7.62 * fem, 143.5 * fem, 7.62 * fem),
                                      width: double.infinity,
                                      height: 53.24 * fem,
                                      decoration: BoxDecoration(
                                        color: const Color(0xa52b2b2b),
                                        borderRadius: BorderRadius.only(
                                          bottomRight:
                                              Radius.circular(65 * fem),
                                          bottomLeft: Radius.circular(65 * fem),
                                        ),
                                      ),
                                      child: SizedBox(
                                        // group7580Hnx (0:512)
                                        width: double.infinity,
                                        height: double.infinity,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              // drp (0:513)
                                              left: 18.5 * fem,
                                              top: 0 * fem,
                                              child: Align(
                                                child: SizedBox(
                                                  height: 26 * fem,
                                                  child: Text(
                                                    "${_ticketListData.where((element) {
                                                          final timeNow =
                                                              DateTime.now();
                                                          final dataDate =
                                                              element['date'];
                                                          final DateFormat
                                                              dateFormat =
                                                              DateFormat(
                                                                  'MM/dd/yyyy');
                                                          String todayDate =
                                                              dateFormat.format(
                                                                  DateTime
                                                                      .now());

                                                          if ((todayDate !=
                                                                  dataDate) &&
                                                              element['status'] ==
                                                                  'paid') {
                                                            return (DateFormat(
                                                                    'MM/dd/yyyy')
                                                                .parse(element[
                                                                    'date'])
                                                                .isAfter(
                                                                    timeNow));
                                                          } else if (todayDate ==
                                                                  dataDate &&
                                                              element['status'] ==
                                                                  'paid') {
                                                            if (element[
                                                                    'time'] ==
                                                                '') {
                                                              return true;
                                                            } else {
                                                              final DateTime
                                                                  currentTime =
                                                                  DateFormat(
                                                                          'MM/dd/yyyy h:mm a')
                                                                      .parse(
                                                                          "${element['date']} ${element['time']}");

                                                              return (currentTime
                                                                  .isAfter(
                                                                      timeNow));
                                                            }
                                                          } else {
                                                            return false;
                                                          }
                                                        }).toList().length}",
                                                    style: SafeGoogleFont(
                                                      'Saira',
                                                      fontSize: 16 * ffem,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height:
                                                          1.575 * ffem / fem,
                                                      color: const Color(
                                                          0xffffffff),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              // ticketsKje (0:514)
                                              left: 0 * fem,
                                              top: 19 * fem,
                                              child: Align(
                                                child: SizedBox(
                                                  width: 48 * fem,
                                                  height: 19 * fem,
                                                  child: Text(
                                                    'TICKETS',
                                                    style: SafeGoogleFont(
                                                      'Saira',
                                                      fontSize: 12 * ffem,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height:
                                                          1.575 * ffem / fem,
                                                      color: const Color(
                                                          0xffaaaaaa),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // menuBWx (0:515)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 14 * fem),
                          child: Text(
                            'Menu',
                            style: SafeGoogleFont(
                              'Saira',
                              fontSize: 18 * ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.575 * ffem / fem,
                              color: const Color(0xffffffff),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const NotificationPage()));
                          },
                          child: Container(
                            // info179i (0:516)
                            margin: EdgeInsets.fromLTRB(
                                0.4 * fem, 0 * fem, 0 * fem, 20 * fem),
                            padding: EdgeInsets.fromLTRB(11.4 * fem,
                                12.08 * fem, 10.6 * fem, 12.08 * fem),
                            width: double.infinity,
                            height: 50 * fem,
                            decoration: BoxDecoration(
                              color: const Color(0xff2b2b2b),
                              borderRadius: BorderRadius.circular(6 * fem),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0x14000000),
                                  offset: Offset(0 * fem, 4 * fem),
                                  blurRadius: 24 * fem,
                                ),
                              ],
                            ),
                            child: SizedBox(
                              // group7596yBv (0:518)
                              width: double.infinity,
                              height: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // autogroupm88bKma (B1LGnSC4aek8Cv8GaVM88b)
                                    padding: EdgeInsets.fromLTRB(0 * fem,
                                        0.92 * fem, 134.45 * fem, 0.92 * fem),
                                    height: double.infinity,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                            // frameEde (0:526)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 8 * fem, 0 * fem),
                                            width: 24 * fem,
                                            height: 24 * fem,
                                            child: SvgPicture.asset(
                                                "assets/icon/profile_notification.svg")),
                                        Text(
                                          // notifications9kc (0:519)
                                          'Notifications',
                                          style: SafeGoogleFont(
                                            'Saira',
                                            fontSize: 14 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.4285714286 * ffem / fem,
                                            color: const Color(0xffaaaaaa),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // group7588UXz (0:520)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 10 * fem, 0 * fem),
                                    width: 29.55 * fem,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xa5aaaaaa)),
                                      color: const Color(0x0cd4af34),
                                      borderRadius:
                                          BorderRadius.circular(7 * fem),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "$_notificationCount",
                                        style: SafeGoogleFont(
                                          'Saira',
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w600,
                                          height: 1.4285714286 * ffem / fem,
                                          color: const Color(0xa5aaaaaa),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.keyboard_arrow_right,
                                    size: 24,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        profileMenu(
                            context: context,
                            title: 'ULimo Instagram',
                            iconAsset: "assets/icon/profile_instagram.svg",
                            onTap: () async {
                              final instagramUrl = Uri(
                                  scheme: 'https',
                                  host: 'www.instagram.com',
                                  path: '/ulimoinc');
                              if (await canLaunchUrl(instagramUrl)) {
                                await launchUrl(instagramUrl);
                              } else {
                                throw 'Could not launch $instagramUrl';
                              }
                            }),
                        // profileMenu(
                        //   context: context,
                        //   title: 'Invite a friend',
                        //   iconAsset: "assets/icon/profile_invite.svg",
                        //   onTap: () async {
                        //     await FlutterShare.share(
                        //       title: 'Invite a friend',
                        //       text: 'Check out this cool app!',
                        //       linkUrl: 'https://www.ulimo.co/',
                        //       chooserTitle: 'Invite a friend',
                        //     );
                        //   },
                        // ),
                        profileMenu(
                            context: context,
                            title: 'More info',
                            iconAsset: "assets/icon/profile_info.svg",
                            onTap: () async {
                              final ulimoWeb = Uri(
                                  scheme: 'https',
                                  host: 'www.ulimo.co',
                                  path: '/');
                              if (await canLaunchUrl(ulimoWeb)) {
                                await launchUrl(ulimoWeb);
                              } else {
                                throw 'Could not launch $ulimoWeb';
                              }
                            }),
                        GestureDetector(
                          onTap: () async {
                            await authData.signOut();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (_) => const PhoneLoginPage()),
                            );
                          },
                          child: Container(
                            // logoutbutton8tg (0:559)
                            margin: EdgeInsets.fromLTRB(
                                0.4 * fem, 0 * fem, 0 * fem, 0 * fem),
                            width: double.infinity,
                            height: 50 * fem,
                            decoration: BoxDecoration(
                              color: const Color(0xff3586ff),
                              borderRadius: BorderRadius.circular(5 * fem),
                            ),
                            child: Center(
                              child: Text(
                                'Log Out',
                                style: SafeGoogleFont(
                                  'Saira',
                                  fontSize: 20 * ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.575 * ffem / fem,
                                  color: const Color(0xffffffff),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: GestureDetector(
                            onTap: () async {
                              // await authData.currentUser?.delete();
                              // Navigator.of(context).pushReplacement(
                              //   MaterialPageRoute(
                              //       builder: (_) => const PhoneLoginPage()),
                              // );
                              deleteAccount();
                            },
                            child: Container(
                              // logoutbutton8tg (0:559)
                              margin: EdgeInsets.fromLTRB(
                                  0.4 * fem, 0 * fem, 0 * fem, 0 * fem),
                              width: double.infinity,
                              height: 50 * fem,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5 * fem),
                              ),
                              child: Center(
                                child: Text(
                                  'Delete Account',
                                  style: SafeGoogleFont(
                                    'Saira',
                                    fontSize: 20 * ffem,
                                    fontWeight: FontWeight.w500,
                                    height: 1.575 * ffem / fem,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: const Text('Profile'),
//     ),
//     body: Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const CircleAvatar(
//             radius: 50,
//             child: Icon(
//               Icons.person,
//               size: 50,
//             ),
//           ),
//           const SizedBox(height: 16),
//           TextField(
//             controller: _nameController,
//             decoration: const InputDecoration(
//               labelText: 'Name',
//               hintText: 'Enter your name',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           const SizedBox(height: 16),
//           TextField(
//             controller: _phoneNumberController,
//             keyboardType: TextInputType.phone,
//             decoration: const InputDecoration(
//               labelText: 'Phone Number',
//               hintText: 'Enter your phone number',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           const SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: () {
//               // Perform save operation here, e.g. update user profile data
//               // with new values from text controllers.
//               print('Name: ${_nameController.text}');
//               print('Phone number: ${_phoneNumberController.text}');
//             },
//             child: const Text('Save'),
//           ),
//         ],
//       ),
//     ),
//   );
// }
}
