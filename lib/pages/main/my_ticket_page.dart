import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ulimo/base/base_background_scaffold.dart';
import 'package:ulimo/pages/ticket/active_ticket.dart';
import 'package:ulimo/pages/ticket/expired_ticket.dart';
import 'package:ulimo/pages/ticket/pending_ticket.dart';
import 'package:ulimo/widget/my_ticket_button.dart';

import 'package:intl/intl.dart';

import '../../base/utils.dart';
import '../phone_login_pages.dart';

class MyTicketPage extends StatefulWidget {
  const MyTicketPage({Key? key}) : super(key: key);

  @override
  State<MyTicketPage> createState() => _MyTicketPageState();
}

class _MyTicketPageState extends State<MyTicketPage> {
  int _selectedIndex = 0;
  String _selectedLabel = "Active";
  final List<String> labels = ["Active", "Pending", "Expired"];
  final _databaseRef = FirebaseDatabase.instance.ref();
  final authData = FirebaseAuth.instance;
  late List _ticketListData;
  final ticketPageController = PageController(initialPage: 0);
  bool _isLoading = true;

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

      final Map<dynamic, dynamic>? privateRideData =
          privateRideSnapshot.snapshot.value as Map<dynamic, dynamic>?;

      final Map<dynamic, dynamic>? nightlifeOrderData =
          nightlifeOrderSnapshot.snapshot.value as Map<dynamic, dynamic>?;

      final Map<dynamic, dynamic>? rideShareBusOrderData =
          rideShareBusOrderSnapshot.snapshot.value as Map<dynamic, dynamic>?;
      final List tempRideShareBusOrderList = [];

      if (privateRideData != null || rideShareBusOrderData != null || nightlifeOrderData != null) {
        privateRideData?.forEach((key, value) async {
          final privateRideMap = {
            'id': key,
            'address': value['pickup_address'],
            'date': value['date'],
            'time': value['pickup_time'],
            'name': 'PRIVATE RIDE',
            'price': value['price'],
            'status': value['status'],
            'rideQuantity': 0,
            'entryQuantity': 0
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
            // final availableDate = <String>{};
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
                  'status': value['status'],
                  'rideQuantity': value['ride_quantity'],
                  'entryQuantity': value['entry_quantity']
                };
                tempRideShareBusOrderList.add(rideShareBusOrderMap);
                setState(() {
                  _ticketListData.add(rideShareBusOrderMap);
                });
              });
            });
          }
          // });
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
              'status': value['status'],
              'rideQuantity': value['ride_quantity'],
              'entryQuantity': value['entry_quantity']
            };
            setState(() {
              _ticketListData.add(nightlifeOrderMap);
            });
          });
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

  List<int> getCount() {
    return [
      getActiveData().length,
      getPendingData().length,
      getExpiredData().length
    ];
  }

  List getActiveData() {

    List sortedList = _ticketListData.where((element) {
      final timeNow = DateTime.now();
      final dataDate = element['date'];
      final DateFormat dateFormat = DateFormat('MM/dd/yyyy');
      String todayDate = dateFormat.format(DateTime.now());

      if ((todayDate != dataDate) && element['status'] == 'paid') {
        return (DateFormat('MM/dd/yyyy').parse(element['date']).isAfter(timeNow));
      } else if (todayDate == dataDate && element['status'] == 'paid') {
        if (element['time'] == '') {
          return true;
        } else {
          final DateTime currentTime = DateFormat('MM/dd/yyyy h:mm a').parse(
              "${element['date']} ${element['time']}");
          return (currentTime.isAfter(timeNow));
        }
      } else {
        return false;
      }
    }).toList();

    sortedList.sort((b, a) {
      final DateTime dateA = DateFormat('MM/dd/yyyy')
          .parse("${a['date']}", true)
          .toUtc();
      final DateTime dateB = DateFormat('MM/dd/yyyy')
          .parse("${b['date']}", true)
          .toUtc();
      return dateA.compareTo(dateB);
    });

    return sortedList;
  }

  List getPendingData() {
    List sortedList = _ticketListData.where((element) {
      return (element['status'] == 'pending') ||
          (element['status'] == 'approved');
    }).toList();

    sortedList.sort((b, a) {
      final DateTime dateA = DateFormat('MM/dd/yyyy')
          .parse("${a['date']}", true)
          .toUtc();
      final DateTime dateB = DateFormat('MM/dd/yyyy')
          .parse("${b['date']}", true)
          .toUtc();
      return dateA.compareTo(dateB);
    });

    return sortedList;
  }

  List getExpiredData() {
    List sortedList = _ticketListData.where((element) {

      final timeNow = DateTime.now();
      final dataDate = element['date'];
      final DateFormat dateFormat = DateFormat('MM/dd/yyyy');
      String todayDate = dateFormat.format(DateTime.now());

      if((element['status'] == 'expired') ||
          (element['status'] == 'denied')){
        return true;
      }else{
        if ((todayDate != dataDate)) {

          return (DateFormat('MM/dd/yyyy')
              .parse(element['date'])
              .isBefore(timeNow));
        }else{
          if(element['time'] == ''){
            return false;
          }else{
            final DateTime currentTime =
            DateFormat('MM/dd/yyyy h:mm a').parse("${element['date']} ${element['time']}");

            return (currentTime.isBefore(timeNow));
          }
        }
      }
    }).toList();

    sortedList.sort((b, a) {
      final DateTime dateA = DateFormat('MM/dd/yyyy')
          .parse("${a['date']}", true)
          .toUtc();
      final DateTime dateB = DateFormat('MM/dd/yyyy')
          .parse("${b['date']}", true)
          .toUtc();
      return dateA.compareTo(dateB);
    });

    return sortedList;

  }

  List<Widget> getTicketList(double fem, double ffem) {
    return [
      ActiveTicket(
        fem: fem,
        ffem: ffem,
        activeTicketData: getActiveData(),
      ),
      PendingTicket(
        fem: fem,
        ffem: ffem,
        pendingData: getPendingData(),
      ),
      ExpiredTicket(
        fem: fem,
        ffem: ffem,
        expiredData: getExpiredData(),
      )
    ];
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
          child: Container(
        padding: EdgeInsets.fromLTRB(20 * fem, 40.21 * fem, 20 * fem, 4 * fem),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  MyTicketButton(
                    fem: fem,
                    ffem: ffem,
                    labels: labels,
                    count: getCount(),
                    onTap: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                      ticketPageController.animateToPage(_selectedIndex,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    },
                    selectedIndex: _selectedIndex,
                  ),
                  Container(
                    // editprofileKYL (0:1096)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 24 * fem, 0 * fem, 30 * fem),
                    width: double.infinity,
                    child: Text(
                      'My Tickets',
                      style: SafeGoogleFont(
                        'Saira',
                        fontSize: 24 * ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.575 * ffem / fem,
                        color: const Color(0xffffffff),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "${labels[_selectedIndex]} ticket(s) (${getCount()[_selectedIndex]})",
                      style: SafeGoogleFont(
                        'Saira',
                        fontSize: 18 * ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.575 * ffem / fem,
                        color: const Color(0xffffffff),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: PageView(
                        physics: const BouncingScrollPhysics(),
                        controller: ticketPageController,
                        children: getTicketList(fem, ffem),
                        onPageChanged: (index) {
                          setState(() {
                            _selectedIndex = index;
                          });
                        }),
                  )
                ],
              ),
      )),
    ));
  }
}
