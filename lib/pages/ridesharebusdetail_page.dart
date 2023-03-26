import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:ulimo/base/base_background_scaffold.dart';
import 'package:ulimo/base/base_color.dart';
import 'package:ulimo/pages/cart_page.dart';
import 'package:ulimo/pages/thank_you_page.dart';
import 'package:ulimo/widget/date_available_item.dart';

import '../base/utils.dart';
import '../widget/date_available_list.dart';
import 'check_out_page.dart';

class RideShareBusDetailPage extends StatefulWidget {
  final String destinationId;

  const RideShareBusDetailPage({Key? key, required this.destinationId})
      : super(key: key);

  @override
  _RideShareBusDetailPageState createState() => _RideShareBusDetailPageState();
}

class _RideShareBusDetailPageState extends State<RideShareBusDetailPage> {
  late Map<dynamic, dynamic> _destinationData;
  final _databaseRef = FirebaseDatabase.instance.ref('rideShareBusTicket');
  late int _passengerSeat = 1;
  late int _availableSeat = 1;
  late int _availableRide = 1;
  late int _availableEntry = 1;
  int _selectedEntry = 1;
  int _selectedRide = 1;
  String _entryPrice = "0.00";
  String _ridePrice = "0.00";
  double _entrySubTotalPrice = 0.00;
  double _rideSubTotalPrice = 0.00;
  String _totalPrice = "0.00";
  String? _selectedTime;
  String? _selectedDate;
  int _selectedTimeIndex = 0;
  late List<String> _rideShareBusTicketOrderId;
  int _selectedDateIndex = 0;
  late String _totalRideQuantity = "";
  late String _totalEntryQuantity = "";
  DateTime? _selectedDateTime;
  String? _selectedDateISO;
  bool _isRideTicket = false;
  bool _isEntryTicket = false;
  bool _isLoading = true;
  DateTime _date = DateTime.now();
  TimeOfDay _pickupTime = TimeOfDay.now();

  final _formKey = GlobalKey<FormState>();
  final _quantityController = TextEditingController(text: '0');

  @override
  void initState() {
    super.initState();
    _destinationData = {};
    _rideShareBusTicketOrderId = [];
    _fetchData(widget.destinationId);
    print(widget.destinationId);
  }

  Future<void> _fetchData(String destinationId) async {
    setState(() {
      _isLoading = true;
    });

    final destinationDataSnapshot = await FirebaseDatabase.instance
        .ref('rideShareBusDestination')
        .orderByKey()
        .equalTo(destinationId)
        // .equalTo("-as7dadjkkldsa")
        .once();

    final destinationTicketSnapshot = await FirebaseDatabase.instance
        .ref('rideShareBusTicket')
        .orderByChild('destination_id')
        .equalTo(destinationId)
        // .equalTo("-as7dadjkkldsa")
        .once();

    final Map<dynamic, dynamic>? ticketData =
        destinationTicketSnapshot.snapshot.value as Map<dynamic, dynamic>?;

    final Map<dynamic, dynamic>? destinationData =
        destinationDataSnapshot.snapshot.value as Map<dynamic, dynamic>?;

    if (destinationData != null) {
      Map<String, dynamic> tempDestinationData;
      destinationData.forEach((dataKey, dataValue) async {
        if (ticketData != null) {
          final availableTime = [];
          final ticketPriceList = [];
          final List<String> tempRideShareBusOrderIds = [];
          ticketData.forEach((ticketKey, ticketValue) {
            availableTime.add(ticketValue['time']);
            ticketPriceList.add(ticketValue);

            tempRideShareBusOrderIds.add(ticketKey);
          });

          tempDestinationData = {
            'name': dataValue['destination_name'],
            'address': dataValue['destination_address'],
            'image_url': dataValue['destination_image_url'],
            'description': dataValue['destination_description'],
            'available_time': availableTime,
            'ticket_price': ticketPriceList
          };

          setState(() {
            _destinationData = tempDestinationData;
            _rideShareBusTicketOrderId = (tempRideShareBusOrderIds);
          });

          updateAvailableSeat();
        }
      });
    }

    setState(() {
      _isLoading = false;
      _ridePrice =
          _destinationData['ticket_price'][_selectedTimeIndex]['ride_price'];

      _entryPrice =
          _destinationData['ticket_price'][_selectedTimeIndex]['entry_price'];

      _totalEntryQuantity = _destinationData['ticket_price'][_selectedTimeIndex]
          ['entry_quantity'];

      _totalRideQuantity =
          _destinationData['ticket_price'][_selectedTimeIndex]['ride_quantity'];
    });
  }

  Future<void> updateAvailableSeat() async {
    final destinationTicketSnapshot = await FirebaseDatabase.instance
        .ref('rideShareBusTicketOrder')
        // .child(_rideShareBusTicketOrderId[_selectedTimeIndex])
        .orderByChild('date')
        .equalTo(DateFormat('dd-MM-yyyy').format(_date))
        .once();

    final Map<dynamic, dynamic>? ticketOrderData =
        destinationTicketSnapshot.snapshot.value as Map<dynamic, dynamic>?;

    if (ticketOrderData != null) {
      int tempQuantityRide = 0;
      int tempQuantityEntry = 0;

      ticketOrderData.forEach((key, value) {
        if (value['rideShareBusTicket_id'] ==
            _rideShareBusTicketOrderId[_selectedTimeIndex]) {
          tempQuantityRide += value['ride_quantity'] as int;
          tempQuantityEntry += value['entry_quantity'] as int;
        }
      });

      setState(() {
        _availableEntry = int.parse(_totalEntryQuantity) - tempQuantityEntry;
        _availableRide = int.parse(_totalRideQuantity) - tempQuantityRide;
      });
    } else {
      setState(() {
        _availableEntry = int.parse(_totalEntryQuantity);
        _availableRide = int.parse(_totalRideQuantity);
      });
    }
    setState(() {
      _selectedRide = 1;
      _selectedEntry = 1;
    });

    if (_isRideTicket) {
      setState(() {
        _rideSubTotalPrice = double.parse(_ridePrice) * _selectedRide;
      });
    } else {
      setState(() {
        _rideSubTotalPrice = 0.00;
      });
    }

    if (_isEntryTicket) {
      setState(() {
        _entrySubTotalPrice = double.parse(_entryPrice) * _selectedEntry;
      });
    } else {
      setState(() {
        _entrySubTotalPrice = 0.00;
      });
    }
  }

  void _saveData(String quantity) async {
    await _databaseRef.push().set({
      'destination_id': _destinationData[0]['destination_id'],
      'time': _selectedTime,
      'quantity': quantity,
    });
    setState(() {
      _selectedTime = null;
    });
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 37 / 27,
                          child: SizedBox(
                            // imageiBA (0:1202)
                            width: double.infinity,
                            child: Image.network(
                              _destinationData['image_url'] ?? "",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                              // arrowCc8 (0:1203)
                              margin: EdgeInsets.fromLTRB(
                                  20 * fem, 20 * fem, 0 * fem, 0 * fem),
                              width: 24 * fem,
                              height: 24 * fem,
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 24 * fem,
                                color: Colors.white,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15 * fem,
                    ),
                    Container(
                      // group7441Kgk (0:1206)
                      margin: EdgeInsets.fromLTRB(
                          19.89 * fem, 0 * fem, 0 * fem, 30 * fem),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // gasparsgrottoquz (0:1207)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 4 * fem),
                            child: Text(
                              _destinationData['name'] ?? "",
                              style: SafeGoogleFont(
                                'Saira',
                                fontSize: 22 * ffem,
                                fontWeight: FontWeight.w500,
                                height: 1.575 * ffem / fem,
                                color: const Color(0xffffffff),
                              ),
                            ),
                          ),
                          Container(
                            // group7440M7e (0:1208)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 97 * fem, 0 * fem),
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    // frame6b2 (0:1209)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 6 * fem, 0 * fem),
                                    width: 16 * fem,
                                    height: 16 * fem,
                                    child: SvgPicture.asset(
                                        "assets/icon/location.svg")),
                                Text(
                                  // tampaaWC (0:1212)
                                  _destinationData['address'] ?? "",
                                  style: SafeGoogleFont(
                                    'Saira',
                                    fontSize: 14 * ffem,
                                    fontWeight: FontWeight.w500,
                                    height: 1.1428571429 * ffem / fem,
                                    color: const Color(0xff3586ff),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // group7442XgL (0:1213)
                      margin: EdgeInsets.fromLTRB(
                          19.89 * fem, 0 * fem, 20.11 * fem, 36 * fem),
                      width: double.infinity,
                      height: 85 * fem,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description',
                            style: SafeGoogleFont(
                              'Saira',
                              fontSize: 18 * ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.575 * ffem / fem,
                              color: const Color(0xffffffff),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              _destinationData['description'] ?? "",
                              style: SafeGoogleFont(
                                'Saira',
                                fontSize: 12 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.575 * ffem / fem,
                                color: const Color(0xffffffff),
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // group7671ZFe (0:1216)
                      margin: EdgeInsets.fromLTRB(
                          19.94 * fem, 0 * fem, 20 * fem, 36 * fem),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // group7463h6x (0:1217)
                            margin: EdgeInsets.fromLTRB(
                                0.06 * fem, 0 * fem, 0 * fem, 10 * fem),
                            padding: EdgeInsets.fromLTRB(
                                12.95 * fem, 11 * fem, 12.11 * fem, 11 * fem),
                            width: double.infinity,
                            height: 46 * fem,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0x0caaaaaa)),
                              color: const Color(0xff2c2b2b),
                              borderRadius: BorderRadius.circular(8 * fem),
                            ),
                            child: SizedBox(
                              // group7462neC (0:1219)
                              width: double.infinity,
                              height: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    // purchaseXLt (0:1220)
                                    child: Text(
                                      'Purchase',
                                      style: SafeGoogleFont(
                                        'Saira',
                                        fontSize: 14 * ffem,
                                        fontWeight: FontWeight.w500,
                                        height: 1.575 * ffem / fem,
                                        color: const Color(0xffffffff),
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 24 * fem,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            // group7534Z2g (0:1224)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0.06 * fem, 0 * fem),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0x0caaaaaa)),
                              color: const Color(0xff2c2b2b),
                              borderRadius: BorderRadius.circular(6 * fem),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: IntrinsicHeight(
                                        child: CheckboxListTile(
                                            value: _isRideTicket,
                                            onChanged: (value) {
                                              setState(() {
                                                _isRideTicket = value ?? false;
                                              });

                                              if (value == true) {
                                                setState(() {
                                                  // _totalPrice += (double.parse(
                                                  //     _rideSubTotalPrice));
                                                  _rideSubTotalPrice =
                                                      double.parse(_ridePrice) *
                                                          _selectedRide;
                                                });
                                              } else {
                                                setState(() {
                                                  _rideSubTotalPrice = 0.00;
                                                  _selectedRide = 1;
                                                  // _totalPrice -= (double.parse(
                                                  //     _rideSubTotalPrice));
                                                });
                                              }
                                            },
                                            title: Text(
                                              // rideticketCE4 (0:1229)
                                              'Ride ticket',
                                              style: SafeGoogleFont(
                                                'Saira',
                                                fontSize: 14 * ffem,
                                                fontWeight: FontWeight.w500,
                                                height:
                                                    1.4285714286 * ffem / fem,
                                                color: const Color(0xffffffff),
                                              ),
                                            ),
                                            side: const BorderSide(
                                                color: Colors.white, width: 2),
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            activeColor: yellowPrimary,
                                            checkColor: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 10 * fem),
                                      child: Text(
                                        // whS (0:1227)
                                        '\$$_ridePrice',
                                        style: SafeGoogleFont(
                                          'Saira',
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.4285714286 * ffem / fem,
                                          color: const Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  // line2gf2 (0:1226)
                                  margin: EdgeInsets.fromLTRB(
                                      0.93 * fem, 0 * fem, 0 * fem, 8.8 * fem),
                                  width: 317.14 * fem,
                                  height: 0.5 * fem,
                                  decoration: const BoxDecoration(
                                    color: Color(0x3faaaaaa),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: IntrinsicHeight(
                                        child: CheckboxListTile(
                                            value: _isEntryTicket,
                                            onChanged: (value) {
                                              setState(() {
                                                _isEntryTicket = value ?? false;
                                              });
                                              if (value == true) {
                                                setState(() {
                                                  // _totalPrice += double.parse(
                                                  //     _entrySubTotalPrice);
                                                  _entrySubTotalPrice =
                                                      double.parse(
                                                              _entryPrice) *
                                                          _selectedEntry;
                                                });
                                              } else {
                                                setState(() {
                                                  _entrySubTotalPrice = 0.00;
                                                  _selectedEntry = 1;
                                                  // _totalPrice -= double.parse(
                                                  //     _entrySubTotalPrice);
                                                });
                                              }
                                            },
                                            title: Text(
                                              // rideticketCE4 (0:1229)
                                              'Entry ticket',
                                              style: SafeGoogleFont(
                                                'Saira',
                                                fontSize: 14 * ffem,
                                                fontWeight: FontWeight.w500,
                                                height:
                                                    1.4285714286 * ffem / fem,
                                                color: const Color(0xffffffff),
                                              ),
                                            ),
                                            side: const BorderSide(
                                                color: Colors.white, width: 2),
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            activeColor: yellowPrimary,
                                            checkColor: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 10 * fem),
                                      child: Text(
                                        // whS (0:1227)
                                        '\$$_entryPrice',
                                        style: SafeGoogleFont(
                                          'Saira',
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.4285714286 * ffem / fem,
                                          color: const Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // info3HeQ (0:1161)
                      margin: EdgeInsets.fromLTRB(
                          19.94 * fem, 0 * fem, 20.17 * fem, 42.82 * fem),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // wherewillyouliketogop8Y (0:1162)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 9 * fem),
                            child: Text(
                              'When will you go?',
                              style: SafeGoogleFont(
                                'Saira',
                                fontSize: 16 * ffem,
                                fontWeight: FontWeight.w500,
                                height: 1.575 * ffem / fem,
                                color: const Color(0xffffffff),
                              ),
                            ),
                          ),
                          SizedBox(
                            // group7540L6t (0:1163)
                            width: double.infinity,
                            height: 46 * fem,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                  child: DottedBorder(
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(6),
                                    color: const Color(0xFFFDCB5B),
                                    strokeWidth: 1,
                                    child: SizedBox(
                                      height: double.infinity,
                                      child: SizedBox(
                                        // group7535hLk (0:1167)
                                        width: double.infinity,
                                        height: double.infinity,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: () =>
                                                    _selectDate(context),
                                                child: Text(
                                                  DateFormat('dd MMM yyyy')
                                                      .format(_date),
                                                  // _destinationData[
                                                  //         'available_date']
                                                  //     .elementAt(
                                                  //         _selectedDateIndex),
                                                  style: SafeGoogleFont(
                                                    'Saira',
                                                    fontSize: 14 * ffem,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.4285714286 *
                                                        ffem /
                                                        fem,
                                                    color:
                                                        const Color(0xfffdcb5b),
                                                  ),
                                                ),
                                              ),
                                              Icon(
                                                Icons.keyboard_arrow_down,
                                                size: 20 * fem,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Flexible(
                                  child: DottedBorder(
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(6),
                                    color: const Color(0xFFFDCB5B),
                                    strokeWidth: 1,
                                    child: SizedBox(
                                      height: double.infinity,
                                      child: SizedBox(
                                        // group7537o2Q (0:1175)
                                        width: double.infinity,
                                        height: double.infinity,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              DropdownButtonHideUnderline(
                                                child: DropdownButton<int>(
                                                  value: _selectedTimeIndex,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  icon: const SizedBox.shrink(),
                                                  dropdownColor: darkPrimary,
                                                  items: List.generate(
                                                      _destinationData[
                                                              'available_time']
                                                          .length, (index) {
                                                    return DropdownMenuItem<
                                                            int>(
                                                        value: index,
                                                        child: Text(
                                                          _destinationData[
                                                                  'available_time']
                                                              [index],
                                                          style: SafeGoogleFont(
                                                            'Saira',
                                                            fontSize: 14 * ffem,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height:
                                                                1.4285714286 *
                                                                    ffem /
                                                                    fem,
                                                            color: const Color(
                                                                0xfffdcb5b),
                                                          ),
                                                        ));
                                                  }),
                                                  onChanged: (int? value) {
                                                    setState(() {
                                                      _selectedTimeIndex =
                                                          value ?? 0;
                                                      _ridePrice = _destinationData[
                                                                  'ticket_price']
                                                              [
                                                              _selectedTimeIndex]
                                                          ['ride_price'];
                                                      _selectedTime =
                                                          _destinationData[
                                                                  'available_time']
                                                              [value];
                                                    });
                                                    updateAvailableSeat();
                                                  },
                                                ),
                                              ),
                                              Icon(
                                                Icons.keyboard_arrow_down,
                                                size: 20 * fem,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      maintainSize: false,
                      visible: _isRideTicket,
                      child: Column(
                        children: [
                          Container(
                            // group7520ZPN (0:1239)
                            margin: EdgeInsets.fromLTRB(
                                20 * fem, 0 * fem, 20 * fem, 24 * fem),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // group75125Mi (0:1240)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 10 * fem),
                                  width: double.infinity,
                                  height: 20 * fem,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        // group7511jx4 (0:1242)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 0 * fem, 5 * fem, 0 * fem),
                                        height: double.infinity,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                // frameGwz (0:1244)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    4 * fem,
                                                    0 * fem),
                                                width: 20 * fem,
                                                height: 20 * fem,
                                                child: SvgPicture.asset(
                                                    "assets/icon/checkbox.svg")),
                                            Text(
                                              // entryticket9Vz (0:1243)
                                              'Ride ticket',
                                              style: SafeGoogleFont(
                                                'Saira',
                                                fontSize: 14 * ffem,
                                                fontWeight: FontWeight.w500,
                                                height:
                                                    1.4285714286 * ffem / fem,
                                                color: const Color(0xfffdcb5b),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        // Vpk (0:1241)
                                        '\$${_rideSubTotalPrice.toStringAsFixed(2)}',
                                        style: SafeGoogleFont(
                                          'Saira',
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.4285714286 * ffem / fem,
                                          color: const Color(0xfffdcb5b),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  // group7519ehe (0:1247)
                                  padding: EdgeInsets.fromLTRB(10.53 * fem,
                                      10 * fem, 10.53 * fem, 10 * fem),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0x0caaaaaa)),
                                    color: const Color(0xff2c2b2b),
                                    borderRadius:
                                        BorderRadius.circular(8 * fem),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        // of15ticketsavailableWE4 (0:1250)
                                        '$_availableRide of $_totalRideQuantity tickets available ',
                                        style: SafeGoogleFont(
                                          'Saira',
                                          fontSize: 12 * ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.6666666667 * ffem / fem,
                                          color: const Color(0xffffffff),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 6 * fem,
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: _availableRide == 0
                                            ? const Text("No ticket available")
                                            : Slider(
                                                value: _selectedRide.toDouble(),
                                                min: 1,
                                                max: _availableRide.toDouble(),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    _selectedRide =
                                                        newValue.round();
                                                    // setState(() {
                                                    //   _totalPrice +=
                                                    //       double.parse(_entryPrice);
                                                    // });
                                                    _rideSubTotalPrice =
                                                        double.parse(
                                                                _ridePrice) *
                                                            _selectedRide;
                                                  });
                                                },
                                                activeColor: yellowPrimary,
                                              ),
                                      ),
                                      SizedBox(
                                        height: 6 * fem,
                                      ),
                                      Text(
                                        // seatxrk (0:1251)
                                        '$_selectedRide Seat',
                                        style: SafeGoogleFont(
                                          'Saira',
                                          fontSize: 12 * ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.6666666667 * ffem / fem,
                                          color: const Color(0xffffffff),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // line46CG (0:1298)
                            margin: EdgeInsets.fromLTRB(
                                21.49 * fem, 0 * fem, 21.49 * fem, 23 * fem),
                            width: double.infinity,
                            height: 1 * fem,
                            decoration: const BoxDecoration(
                              color: Color(0x3faaaaaa),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      maintainSize: false,
                      visible: _isEntryTicket,
                      child: Column(
                        children: [
                          Container(
                            // group7520ZPN (0:1239)
                            margin: EdgeInsets.fromLTRB(
                                20 * fem, 0 * fem, 20 * fem, 24 * fem),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // group75125Mi (0:1240)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 10 * fem),
                                  width: double.infinity,
                                  height: 20 * fem,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        // group7511jx4 (0:1242)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 0 * fem, 6 * fem, 0 * fem),
                                        height: double.infinity,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                // frameGwz (0:1244)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    4 * fem,
                                                    0 * fem),
                                                width: 20 * fem,
                                                height: 20 * fem,
                                                child: SvgPicture.asset(
                                                    "assets/icon/checkbox.svg")),
                                            Text(
                                              // entryticket9Vz (0:1243)
                                              'Entry ticket',
                                              style: SafeGoogleFont(
                                                'Saira',
                                                fontSize: 14 * ffem,
                                                fontWeight: FontWeight.w500,
                                                height:
                                                    1.4285714286 * ffem / fem,
                                                color: const Color(0xfffdcb5b),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        // Vpk (0:1241)
                                        '\$${_entrySubTotalPrice.toStringAsFixed(2)}',
                                        style: SafeGoogleFont(
                                          'Saira',
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.4285714286 * ffem / fem,
                                          color: const Color(0xfffdcb5b),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  // group7519ehe (0:1247)
                                  padding: EdgeInsets.fromLTRB(10.53 * fem,
                                      10 * fem, 10.53 * fem, 10 * fem),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0x0caaaaaa)),
                                    color: const Color(0xff2c2b2b),
                                    borderRadius:
                                        BorderRadius.circular(8 * fem),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        // of15ticketsavailableWE4 (0:1250)
                                        '$_availableEntry of $_totalEntryQuantity tickets available ',
                                        style: SafeGoogleFont(
                                          'Saira',
                                          fontSize: 12 * ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.6666666667 * ffem / fem,
                                          color: const Color(0xffffffff),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 6 * fem,
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: _availableEntry == 0
                                            ? const Text("No ticket available")
                                            : Slider(
                                                value:
                                                    _selectedEntry.toDouble(),
                                                min: 1,
                                                max: _availableEntry.toDouble(),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    _selectedEntry =
                                                        newValue.round();
                                                    _entrySubTotalPrice =
                                                        double.parse(
                                                                _entryPrice) *
                                                            _selectedEntry;
                                                  });
                                                },
                                                activeColor: yellowPrimary,
                                              ),
                                      ),
                                      SizedBox(
                                        height: 6 * fem,
                                      ),
                                      Text(
                                        // seatxrk (0:1251)
                                        '$_selectedEntry Seat',
                                        style: SafeGoogleFont(
                                          'Saira',
                                          fontSize: 12 * ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.6666666667 * ffem / fem,
                                          color: const Color(0xffffffff),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // line46CG (0:1298)
                            margin: EdgeInsets.fromLTRB(
                                21.49 * fem, 0 * fem, 21.49 * fem, 23 * fem),
                            width: double.infinity,
                            height: 1 * fem,
                            decoration: const BoxDecoration(
                              color: Color(0x3faaaaaa),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // group7530qqJ (0:1290)
                      margin: EdgeInsets.fromLTRB(
                          19.94 * fem, 0 * fem, 20.17 * fem, 42.82 * fem),
                      width: double.infinity,
                      height: 50 * fem,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5 * fem),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // group7529Asa (0:1295)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 25.42 * fem, 0 * fem),
                            height: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // totalpriceKVa (0:1296)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 4 * fem),
                                  child: Text(
                                    'Total Price',
                                    style: SafeGoogleFont(
                                      'Barlow',
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w500,
                                      height: 1.2 * ffem / fem,
                                      color: const Color(0xffffffff),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 80 * fem,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      // QX2 (0:1297)
                                      '\$${countTotalPrice(_rideSubTotalPrice, _entrySubTotalPrice)}',
                                      style: SafeGoogleFont(
                                        'Barlow',
                                        fontSize: 24 * ffem,
                                        fontWeight: FontWeight.w600,
                                        height: 1.2 * ffem / fem,
                                        color: const Color(0xfffdcb5b),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            // button8hv (0:1291)
                            onPressed: () {
                              if (_isRideTicket || _isEntryTicket) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CheckOutPage(
                                          price: countTotalPrice(
                                              _rideSubTotalPrice,
                                              _entrySubTotalPrice),
                                          date: DateFormat("dd-MM-yyyy")
                                              .format(_date),
                                          time: '',
                                          rideType: 'ridesharebus',
                                          orderId: _rideShareBusTicketOrderId[
                                              _selectedTimeIndex],
                                          destinationName:
                                              _destinationData['name'],
                                          destinationAddress:
                                              _destinationData['address'],
                                          rideQuantity:
                                              _isRideTicket ? _selectedRide : 0,
                                          entryQuantity: _isEntryTicket
                                              ? _selectedEntry
                                              : 0,
                                        )));
                              }
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Container(
                              width: 215.47 * fem,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: (_isRideTicket || _isEntryTicket)
                                    ? const Color(0xfffdcb5b)
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(5 * fem),
                              ),
                              child: Center(
                                child: Text(
                                  'Purchase Ticket',
                                  style: SafeGoogleFont(
                                    'Saira',
                                    fontSize: 20 * ffem,
                                    fontWeight: FontWeight.w500,
                                    height: 1.575 * ffem / fem,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
        ),
      ),
    ));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            primaryColor: darkPrimary, // change the selected date color
            colorScheme: const ColorScheme.light(
              primary: darkPrimary,
              // change the text color of the header
              onPrimary: Colors.white,
              // change the color of the icons in the header
              surface: darkPrimary,
              // change the background color of the calendar
              onSurface: Colors.black, // change the text color of the calendar
            ),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
      updateAvailableSeat();
    }
  }

  String countTotalPrice(double rideSubTotalPrice, double entrySubTotalPrice) {
    return (rideSubTotalPrice + entrySubTotalPrice).toStringAsFixed(2);
  }
}
