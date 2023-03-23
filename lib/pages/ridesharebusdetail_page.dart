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
  late String _availableRide;
  late String _availableEntry;
  int _selectedEntry = 1;
  int _selectedRide = 1;
  String _entryPrice = "0.00";
  String _ridePrice = "0.00";
  double _entrySubTotalPrice = 0.00;
  double _rideSubTotalPrice = 0.00;
  double _totalPrice = 0.00;
  String? _selectedTime;
  String? _selectedDate;
  int _selectedTimeIndex = 0;
  int _selectedDateIndex = 0;
  late String _totalRideQuantity;
  late String _totalEntryQuantity;
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
    _fetchData(widget.destinationId);
  }

  Future<void> _fetchData(String destinationId) async {
    setState(() {
      _isLoading = true;
    });

    final destinationDataSnapshot = await FirebaseDatabase.instance
        .ref('destination')
        .orderByKey()
        .equalTo('-as7dadjkkldsa')
        .once();

    //old data
    // final destinationTicketSnapshot = await FirebaseDatabase.instance
    //     .ref('rideShareBusTicket')
    //     .child('-as7dadjkkldsa')
    //     .child('ticket_price')
    //     // .orderByKey()
    //     // .orderByChild('destination_id')
    //     // .equalTo(destinationId)
    //     // .equalTo("-as7dadjkkldsa")
    //     .once();

    final destinationTicketSnapshot = await FirebaseDatabase.instance
        .ref('rideShareBusTicket')
        .orderByChild('destination_id')
        .equalTo('-as7dadjkkldsa')
        // .orderByKey()
        // .orderByChild('destination_id')
        // .equalTo(destinationId)
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
          // final availableDate = <String>{};
          final availableTime = [];
          final ticketPriceList = [];
          ticketData.forEach((ticketKey, ticketValue) {
            // DateTime ticketSchedule = DateTime.parse(ticketKey);

            // String timeFormat = DateFormat('HH:mm').format(ticketSchedule);
            // String formatDate = DateFormat('yyyy-MM-dd').format(ticketSchedule);

            // availableDate.add(formatDate);
            // availableTime.add(timeFormat);
            availableTime.add(ticketValue['time']);
            ticketPriceList.add(ticketValue);
          });

          tempDestinationData = {
            'name': dataValue['destination_name'],
            'address': dataValue['destination_address'],
            'image_url': dataValue['destination_image_url'],
            'description': dataValue['destination_description'],
            // 'available_date': availableDate,
            'available_time': availableTime,
            'ticket_price': ticketPriceList
          };

          setState(() {
            _destinationData = tempDestinationData;
          });
        }
      });
    }

    setState(() {
      _isLoading = false;
      _ridePrice =
          _destinationData['ticket_price'][_selectedTimeIndex]['ride_price'];
      _entryPrice =
          _destinationData['ticket_price'][_selectedTimeIndex]['entry_price'];

      _availableRide = _destinationData['ticket_price'][_selectedTimeIndex]
          ['ride_quantity_left'];
      _availableEntry = _destinationData['ticket_price'][_selectedTimeIndex]
          ['entry_quantity_left'];

      _totalEntryQuantity = _destinationData['ticket_price'][_selectedTimeIndex]
          ['entry_quantity'];

      _totalRideQuantity =
          _destinationData['ticket_price'][_selectedTimeIndex]['ride_quantity'];
    });
  }

  void _showQuantityForm(BuildContext context) {
    final TextEditingController _quantityController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Quantity'),
          content: TextField(
            controller: _quantityController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Enter Quantity',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final String quantity = _quantityController.text.trim();
                if (quantity.isNotEmpty) {
                  _saveData(quantity);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
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
                                                onTap: () => _selectDate(
                                                    context,
                                                    fem,
                                                    ffem,
                                                    _destinationData[
                                                            'available_date']
                                                        .length),
                                                child: Text(
                                                  "",
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
                                                    });
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
                                    children: [
                                      Container(
                                        // group7511jx4 (0:1242)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 188 * fem, 0 * fem),
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
                                        '\$$_rideSubTotalPrice',
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
                                        '$_availableRide of $_totalRideQuantity} tickets available ',
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
                                        child: Slider(
                                          value: _selectedRide.toDouble(),
                                          min: 1,
                                          max: double.parse(_availableRide),
                                          onChanged: (newValue) {
                                            setState(() {
                                              _selectedRide = newValue.round();
                                              // setState(() {
                                              //   _totalPrice +=
                                              //       double.parse(_entryPrice);
                                              // });
                                              _rideSubTotalPrice =
                                                  double.parse(_ridePrice) *
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
                                    children: [
                                      Container(
                                        // group7511jx4 (0:1242)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 188 * fem, 0 * fem),
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
                                        '\$$_entrySubTotalPrice',
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
                                        child: Slider(
                                          value: _selectedEntry.toDouble(),
                                          min: 1,
                                          max: double.parse(_availableEntry),
                                          onChanged: (newValue) {
                                            setState(() {
                                              _selectedEntry = newValue.round();
                                              _entrySubTotalPrice =
                                                  double.parse(_entryPrice) *
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
                      // child: Container(
                      //   // group7533cRW (0:1255)
                      //   margin: EdgeInsets.fromLTRB(
                      //       19.94 * fem, 0 * fem, 20.06 * fem, 46 * fem),
                      //   width: double.infinity,
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Container(
                      //         // group7532Mdz (0:1256)
                      //         margin: EdgeInsets.fromLTRB(
                      //             0.11 * fem, 0 * fem, 241.89 * fem, 10 * fem),
                      //         width: double.infinity,
                      //         child: Row(
                      //           crossAxisAlignment: CrossAxisAlignment.center,
                      //           children: [
                      //             Container(
                      //                 // framet88 (0:1259)
                      //                 margin: EdgeInsets.fromLTRB(
                      //                     0 * fem, 0 * fem, 4 * fem, 0 * fem),
                      //                 width: 20 * fem,
                      //                 height: 20 * fem,
                      //                 child: SvgPicture.asset(
                      //                     "assets/icon/checkbox.svg")),
                      //             Text(
                      //               'Ride ticket',
                      //               style: SafeGoogleFont(
                      //                 'Saira',
                      //                 fontSize: 14 * ffem,
                      //                 fontWeight: FontWeight.w500,
                      //                 height: 1.4285714286 * ffem / fem,
                      //                 color: const Color(0xfffdcb5b),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //       Container(
                      //           // group7528ArL (0:1262)
                      //           padding: EdgeInsets.fromLTRB(
                      //               6.53 * fem, 6.35 * fem, 6.53 * fem, 6.35 * fem),
                      //           width: double.infinity,
                      //           height: 100 * fem,
                      //           decoration: BoxDecoration(
                      //             border: Border.all(color: const Color(0x0caaaaaa)),
                      //             color: const Color(0xff2c2b2b),
                      //             borderRadius: BorderRadius.circular(8 * fem),
                      //           ),
                      //           child: DateAvailableList(fem: fem, ffem: ffem, onTap: (index){
                      //             //do something when clicked
                      //           })),
                      //     ],
                      //   ),
                      // ),
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
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      // CartPage(user_id: "user_id")));
                                      const CheckOutPage(
                                        privateRideId: '',
                                      )));
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Container(
                              width: 215.47 * fem,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xfffdcb5b),
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
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Ride Share Bus'),
    //   ),
    //   body: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Container(
    //         height: 80,
    //         padding: const EdgeInsets.symmetric(horizontal: 16),
    //         child: _destinationList.isEmpty
    //             ? const Center(child: CircularProgressIndicator())
    //             : ListView.builder(
    //                 scrollDirection: Axis.horizontal,
    //                 itemCount: _destinationList.length,
    //                 itemBuilder: (context, index) {
    //                   return GestureDetector(
    //                     onTap: () {
    //                       setState(() {
    //                         _selectedTime =
    //                             _destinationList[index]['time'] as String?;
    //                       });
    //                     },
    //                     child: Container(
    //                       margin: const EdgeInsets.symmetric(
    //                           horizontal: 10, vertical: 10),
    //                       padding: const EdgeInsets.symmetric(
    //                           horizontal: 16, vertical: 12),
    //                       decoration: BoxDecoration(
    //                         color: _isSelectedTime(
    //                                 _destinationList[index]['time'] as String)
    //                             ? Colors.blue
    //                             : Colors.white,
    //                         border: Border.all(
    //                           color: Colors.blue,
    //                           width: 2,
    //                         ),
    //                         borderRadius: BorderRadius.circular(10),
    //                       ),
    //                       child: Text(
    //                         _destinationList[index]['time'] as String,
    //                         style: TextStyle(
    //                           color: _isSelectedTime(
    //                                   _destinationList[index]['time'] as String)
    //                               ? Colors.white
    //                               : Colors.black,
    //                           fontWeight: FontWeight.bold,
    //                           fontSize: 16,
    //                         ),
    //                       ),
    //                     ),
    //                   );
    //                 },
    //               ),
    //       ),
    //       Expanded(
    //         child: _selectedTime == null
    //             ? const Center(child: Text('Please select time'))
    //             : ListView.builder(
    //                 padding: const EdgeInsets.all(16),
    //                 itemCount: _destinationList.length,
    //                 itemBuilder: (context, index) {
    //                   if (_destinationList[index]['time'] == _selectedTime &&
    //                       _isSelectedTime(_selectedTime!)) {
    //                     return Form(
    //                       key: _formKey,
    //                       child: Card(
    //                         margin: const EdgeInsets.symmetric(vertical: 8),
    //                         elevation: 4,
    //                         shape: RoundedRectangleBorder(
    //                           borderRadius: BorderRadius.circular(10),
    //                         ),
    //                         child: Padding(
    //                           padding: const EdgeInsets.all(16),
    //                           child: Column(
    //                             crossAxisAlignment: CrossAxisAlignment.start,
    //                             children: [
    //                               const Text(
    //                                 'Quantity',
    //                                 style: TextStyle(
    //                                   fontWeight: FontWeight.bold,
    //                                   fontSize: 18,
    //                                 ),
    //                               ),
    //                               const SizedBox(height: 8),
    //                               Row(
    //                                 children: [
    //                                   IconButton(
    //                                     onPressed: () {
    //                                       if (_quantityController
    //                                           .text.isNotEmpty) {
    //                                         int currentValue = int.parse(
    //                                             _quantityController.text);
    //                                         setState(() {
    //                                           currentValue--;
    //                                           _quantityController.text =
    //                                               (currentValue > 0
    //                                                       ? currentValue
    //                                                       : 0)
    //                                                   .toString();
    //                                         });
    //                                       }
    //                                     },
    //                                     icon: const Icon(Icons.remove),
    //                                   ),
    //                                   Expanded(
    //                                     child: TextFormField(
    //                                       keyboardType: TextInputType.number,
    //                                       controller: _quantityController,
    //                                       decoration: const InputDecoration(
    //                                         labelText: 'Quantity',
    //                                         hintText: 'Enter the quantity',
    //                                       ),
    //                                       validator: (value) {
    //                                         if (value == null ||
    //                                             value.isEmpty) {
    //                                           return 'Please enter a quantity';
    //                                         }
    //                                         return null;
    //                                       },
    //                                     ),
    //                                   ),
    //                                   IconButton(
    //                                     onPressed: () {
    //                                       if (_quantityController
    //                                           .text.isNotEmpty) {
    //                                         int currentValue = int.parse(
    //                                             _quantityController.text);
    //                                         setState(() {
    //                                           currentValue++;
    //                                           _quantityController.text =
    //                                               currentValue.toString();
    //                                         });
    //                                       }
    //                                     },
    //                                     icon: const Icon(Icons.add),
    //                                   ),
    //                                 ],
    //                               ),
    //                               const SizedBox(height: 16),
    //                               Row(
    //                                 mainAxisAlignment:
    //                                     MainAxisAlignment.spaceBetween,
    //                                 children: [
    //                                   const Text(
    //                                     'Price',
    //                                     style: TextStyle(
    //                                       fontWeight: FontWeight.bold,
    //                                       fontSize: 18,
    //                                     ),
    //                                   ),
    //                                   Text(
    //                                     '\$${NumberFormat("#,##0.00", "en_US").format((_destinationList[index]['price'] ?? 0) * int.parse(_quantityController.text))}',
    //                                     style: const TextStyle(
    //                                       fontWeight: FontWeight.bold,
    //                                       fontSize: 18,
    //                                       color: Colors.green,
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                               const SizedBox(height: 16),
    //                               SizedBox(
    //                                 width: MediaQuery.of(context).size.width,
    //                                 child: ElevatedButton(
    //                                   onPressed: () {
    //                                     // redirect to thank you page
    //                                     Navigator.pushReplacement(
    //                                       context,
    //                                       MaterialPageRoute(
    //                                         builder: (context) =>
    //                                             const ThankYouPage(),
    //                                       ),
    //                                     );
    //                                   },
    //                                   child: const Text('Add to Cart'),
    //                                 ),
    //                               )
    //                             ],
    //                           ),
    //                         ),
    //                       ),
    //                     );
    //                   }
    //                   return const SizedBox.shrink();
    //                 },
    //               ),
    //       ),
    //     ],
    //   ),
    // );
  }

  bool _isSelectedTime(String time) {
    return _selectedTime != null && _selectedTime == time;
  }

  Future<void> _selectDate(
      BuildContext context, double fem, double ffem, int dateCount) async {
    // showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (context) {
    //       return AlertDialog(
    //         title: Text(
    //           "Available Date",
    //           textAlign: TextAlign.center,
    //           style: SafeGoogleFont(
    //             'Saira',
    //             fontSize: 14 * ffem,
    //             fontWeight: FontWeight.w500,
    //             height: 1.4285714286 * ffem / fem,
    //             color: const Color(0xfffdcb5b),
    //           ),
    //         ),
    //         backgroundColor: darkPrimary,
    //         content: ConstrainedBox(
    //           constraints: const BoxConstraints(maxHeight: 300),
    //           child: ListView.builder(
    //               itemCount: dateCount,
    //               itemBuilder: (context, index) {
    //                 return Container(
    //                   margin: const EdgeInsets.only(bottom: 12),
    //                   width: MediaQuery.of(context).size.width / 3,
    //                   height: 46 * fem,
    //                   child: DottedBorder(
    //                     borderType: BorderType.RRect,
    //                     radius: const Radius.circular(6),
    //                     color: const Color(0xFFFDCB5B),
    //                     strokeWidth: 1,
    //                     child: SizedBox(
    //                       height: double.infinity,
    //                       child: SizedBox(
    //                         // group7535hLk (0:1167)
    //                         width: double.infinity,
    //                         height: double.infinity,
    //                         child: Padding(
    //                           padding:
    //                               const EdgeInsets.symmetric(horizontal: 15),
    //                           child: GestureDetector(
    //                             onTap: () {
    //                               setState(() {
    //                                 _selectedDateIndex = index;
    //                               });
    //                               //update price for ticket
    //
    //                               Map<dynamic, dynamic>? ticketList =
    //                                   _destinationData['ticket_price'];
    //
    //                               print("ticketList $ticketList");
    //
    //                               setState(() {
    //                                 _selectedDateTime = DateTime.parse(
    //                                     "${_destinationData['available_date'].elementAt(index)}T${_destinationData['available_time'].elementAt(index)}:00Z");
    //                               });
    //
    //                               print(
    //                                   "selectedDate${_selectedDateTime?.year} ");
    //
    //                               setState(() {
    //                                 // _selectedDateTime?.day = 4;
    //                                 _selectedDateISO =
    //                                     "${_destinationData['available_date'].elementAt(index)}T${_destinationData['available_time'].elementAt(index)}:00Z";
    //                               });
    //
    //                               print("selectedDateISOO $_selectedDateISO");
    //
    //                               setState(() {
    //                                 _availableEntry =
    //                                     ticketList?[_selectedDateISO]
    //                                             ['entry_quantity'] ??
    //                                         "";
    //                                 _availableRide =
    //                                     ticketList?[_selectedDateISO]
    //                                             ['ride_quantity'] ??
    //                                         "";
    //                                 _entryPrice = ticketList?[_selectedDateISO]
    //                                         ['entry_price'] ??
    //                                     "";
    //                                 _ridePrice = ticketList?[_selectedDateISO]
    //                                         ['ride_price'] ??
    //                                     "";
    //                                 _availableEntry =
    //                                     ticketList?[_selectedDateISO]
    //                                             ['entry_quantity'] ??
    //                                         "";
    //                                 _totalPrice = double.parse(_entryPrice) +
    //                                     double.parse(_ridePrice);
    //                               });
    //
    //                               //
    //                               Navigator.pop(context);
    //                             },
    //                             child: Center(
    //                               child: Text(
    //                                 _destinationData['available_date']
    //                                     .elementAt(index),
    //                                 textAlign: TextAlign.center,
    //                                 style: SafeGoogleFont(
    //                                   'Saira',
    //                                   fontSize: 14 * ffem,
    //                                   fontWeight: FontWeight.w500,
    //                                   height: 1.4285714286 * ffem / fem,
    //                                   color: const Color(0xfffdcb5b),
    //                                 ),
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 );
    //               }),
    //         ),
    //       );
    //     });

    // final DateTime? picked = await showDatePicker(
    //   context: context,
    //   initialDate: _date,
    //   firstDate: DateTime.now(),
    //   lastDate: DateTime(2100),
    //   builder: (BuildContext context, Widget? child) {
    //     return Theme(
    //       data: ThemeData(
    //         primaryColor: darkPrimary, // change the selected date color
    //         colorScheme: const ColorScheme.light(
    //           primary: darkPrimary,
    //           // change the text color of the header
    //           onPrimary: Colors.white,
    //           // change the color of the icons in the header
    //           surface: darkPrimary,
    //           // change the background color of the calendar
    //           onSurface: Colors.black, // change the text color of the calendar
    //         ),
    //       ),
    //       child: child ?? const SizedBox.shrink(),
    //     );
    //   },
    // );
    // if (picked != null && picked != _date) {
    //   setState(() {
    //     _date = picked;
    //   });
    // }
  }

  Future<void> _selectPickupTime(
      BuildContext context, double fem, double ffem, int dateCount) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Available Time",
              textAlign: TextAlign.center,
              style: SafeGoogleFont(
                'Saira',
                fontSize: 14 * ffem,
                fontWeight: FontWeight.w500,
                height: 1.4285714286 * ffem / fem,
                color: const Color(0xfffdcb5b),
              ),
            ),
            backgroundColor: darkPrimary,
            content: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 300),
              child: ListView.builder(
                  itemCount: dateCount,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      width: MediaQuery.of(context).size.width / 3,
                      height: 46 * fem,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedTimeIndex = index;
                                  });
                                  //update price for ticket

                                  //
                                  Navigator.pop(context);
                                },
                                child: Center(
                                  child: Text(
                                    _destinationData['available_time']
                                        .elementAt(index),
                                    textAlign: TextAlign.center,
                                    style: SafeGoogleFont(
                                      'Saira',
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w500,
                                      height: 1.4285714286 * ffem / fem,
                                      color: const Color(0xfffdcb5b),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          );
        });

    // final DateTime? picked = await showDatePicker(
    //   context: context,
    //   initialDate: _date,
    //   firstDate: DateTime.now(),
    //   lastDate: DateTime(2100),
    //   builder: (BuildContext context, Widget? child) {
    //     return Theme(
    //       data: ThemeData(
    //         primaryColor: darkPrimary, // change the selected date color
    //         colorScheme: const ColorScheme.light(
    //           primary: darkPrimary,
    //           // change the text color of the header
    //           onPrimary: Colors.white,
    //           // change the color of the icons in the header
    //           surface: darkPrimary,
    //           // change the background color of the calendar
    //           onSurface: Colors.black, // change the text color of the calendar
    //         ),
    //       ),
    //       child: child ?? const SizedBox.shrink(),
    //     );
    //   },
    // );
    // if (picked != null && picked != _date) {
    //   setState(() {
    //     _date = picked;
    //   });
    // }
  }

  String countTotalPrice(double rideSubTotalPrice, double entrySubTotalPrice) {
    return (rideSubTotalPrice + entrySubTotalPrice).toStringAsFixed(2);
  }
}
