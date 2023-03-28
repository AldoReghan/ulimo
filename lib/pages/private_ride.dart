import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:ulimo/base/base_background_scaffold.dart';
import 'package:ulimo/base/base_color.dart';
import 'package:ulimo/pages/check_out_page.dart';
import 'package:ulimo/pages/thank_you_page.dart';
import 'package:connectivity/connectivity.dart';
import 'package:ulimo/services/stripe_services.dart';

import '../base/utils.dart';

class PrivateRidePage extends StatefulWidget {
  const PrivateRidePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PrivateRidePageState createState() => _PrivateRidePageState();
}

class _PrivateRidePageState extends State<PrivateRidePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _pickupAddressController = TextEditingController();
  final _destinationController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _passengersController = TextEditingController();
  bool _isRoundTrip = false;
  DateTime _date = DateTime.now();
  TimeOfDay _pickupTime = TimeOfDay.now();
  bool _isLoading = false;

  FirebaseAuth authData = FirebaseAuth.instance;

  Map<String, dynamic>? paymentIntent;

  Future<bool> checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    return true;
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!await checkConnectivity()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No network connection'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Send data to Firebase
    final rideDetails = {
      'name': authData.currentUser?.displayName,
      'user_id': authData.currentUser?.uid,
      'date': DateFormat('yyyy-MM-dd').format(_date),
      'pickup_time': _pickupTime.format(context),
      'pickup_address': _pickupAddressController.text,
      'destination': _destinationController.text,
      'phone_number': authData.currentUser?.phoneNumber,
      'email': _emailController.text.trim(),
      'passenger': _passengersController.text.trim(),
      'is_round_trip': _isRoundTrip,
      'price': '',
      'status': 'pending'
    };

    try {
      // await makePayment();

      final databaseRef = FirebaseDatabase.instance.ref('privateRide').push();
      await databaseRef.set(rideDetails);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Private ride details submitted successfully'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop();

      SchedulerBinding.instance.addPostFrameCallback((_) {
        _formKey.currentState!.reset();
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) =>
        //         CheckOutPage(privateRideId: databaseRef.key ?? ""),
        //   ),
        // );
        // Fluttertoast.showToast(msg: 'Invalid OTP code');
        // Navigator.of(context).pop();
      });
    } catch (e) {
      print('makePayment() was canceled');
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    if (Platform.isIOS) {
    // if (true) {
      //show ios date picker
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              height: 250,
              width: MediaQuery.of(context).size.width * 0.8,
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: 200.0,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: CupertinoDatePicker(
                      initialDateTime: _date,
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (value) {
                        setState(() {
                          _date = value;
                        });
                      },
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Select",
                        style: TextStyle(color: yellowPrimary),
                      ))
                ],
              ),
            ),
          );
        },
      );

    } else {
      //show android date picker
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
                onSurface:
                    Colors.black, // change the text color of the calendar
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
      }
    }

    // showCupertinoDialog(context: context, builder: (context) {
    //
    // },);
  }

  Future<void> _selectPickupTime(BuildContext context) async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {

      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              height: 250,
              width: MediaQuery.of(context).size.width * 0.8,
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: 200.0,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: CupertinoDatePicker(
                      initialDateTime: _date,
                      mode: CupertinoDatePickerMode.time,
                      onDateTimeChanged: (value) {
                        setState(() {
                          _pickupTime = TimeOfDay.fromDateTime(value);
                        });
                      },
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Select",
                        style: TextStyle(color: yellowPrimary),
                      ))
                ],
              ),
            ),
          );
        },
      );
      // showCupertinoDialog(
      //   context: context,
      //   builder: (context) {
      //     return CupertinoAlertDialog(
      //       content: CupertinoDatePicker(
      //         initialDateTime: _date,
      //         mode: CupertinoDatePickerMode.time,
      //         onDateTimeChanged: (value) {
      //           setState(() {
      //             _pickupTime = TimeOfDay.fromDateTime(value);
      //           });
      //           Navigator.pop(context);
      //         },
      //       ),
      //     );
      //   },
      // );
    } else {
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: _pickupTime,
      );
      if (picked != null && picked != _pickupTime) {
        setState(() {
          _pickupTime = picked;
        });
      }
    }
  }

  Future<void> makePayment() async {
    paymentIntent = await StripeServices.createPaymentIntent(
      '120000',
      'USD',
    );

    await StripeServices.displayPaymentSheet(
        paymentIntent!['client_secret'],
        _nameController.text.trim(),
        _emailController.text.trim(),
        '12000',
        () {});
    await StripeServices.savePaymentToFirebase(
      '9876678',
      _nameController.text.trim(),
      _emailController.text.trim(),
      '12000',
    );
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return defaultBackgroundScaffold(
        scaffold: Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        // requestridepage6oz (0:1133)
        padding: EdgeInsets.fromLTRB(19.78 * fem, 60 * fem, 20 * fem, 0 * fem),
        width: double.infinity,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  // group7560J9N (0:1194)
                  margin: EdgeInsets.fromLTRB(
                      0.12 * fem, 0 * fem, 32.1 * fem, 10 * fem),
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          // arrowRUt (0:1195)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 27 * fem, 0 * fem),
                          width: 24 * fem,
                          height: 24 * fem,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 24 * fem,
                            ),
                          )),
                      RichText(
                        // requestaprivaterideVje (0:1199)
                        text: TextSpan(
                          style: SafeGoogleFont(
                            'Saira',
                            fontSize: 24 * ffem,
                            fontWeight: FontWeight.w500,
                            height: 1.575 * ffem / fem,
                            color: const Color(0xffffffff),
                          ),
                          children: [
                            const TextSpan(
                              text: 'Request a ',
                            ),
                            TextSpan(
                              text: 'Private Ride',
                              style: SafeGoogleFont(
                                'Saira',
                                fontSize: 24 * ffem,
                                fontWeight: FontWeight.w500,
                                height: 1.575 * ffem / fem,
                                color: const Color(0xfffdcb5b),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // getacustomtripforjustyouandyou (0:1193)
                  margin: EdgeInsets.fromLTRB(
                      0 * fem, 0 * fem, 9.78 * fem, 19.52 * fem),
                  constraints: BoxConstraints(
                    maxWidth: 325 * fem,
                  ),
                  child: Text(
                    'Get a custom trip for just you and your group. You will receive a quote from us within 24 hours !',
                    style: SafeGoogleFont(
                      'Saira',
                      fontSize: 14 * ffem,
                      fontWeight: FontWeight.w500,
                      height: 1.575 * ffem / fem,
                      color: const Color(0xbfaaaaaa),
                    ),
                  ),
                ),
                Container(
                  // info1pYx (0:1186)
                  margin: EdgeInsets.fromLTRB(
                      0.11 * fem, 0 * fem, 0.11 * fem, 30 * fem),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8 * fem),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // whereshouldwepickyoufrom9r8 (0:1187)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 5 * fem),
                        child: Text(
                          'Where should we pick you from?',
                          style: SafeGoogleFont(
                            'Saira',
                            fontSize: 16 * ffem,
                            fontWeight: FontWeight.w500,
                            height: 1.575 * ffem / fem,
                            color: const Color(0xffffffff),
                          ),
                        ),
                      ),
                      Container(
                        // group6GA4 (0:1188)
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8 * fem),
                          border: Border.all(color: const Color(0x0caaaaaa)),
                          color: const Color(0xff2c2b2b),
                        ),
                        child: TextFormField(
                          cursorColor: yellowPrimary,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.fromLTRB(
                                12.5 * fem, 15 * fem, 12.5 * fem, 15 * fem),
                            hintText: 'E.g 14, Oliver street, Quake Rd, Tampa',
                            hintStyle:
                                const TextStyle(color: Color(0x59ffffff)),
                          ),
                          controller: _pickupAddressController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the pickup address';
                            }
                            return null;
                          },
                          style: SafeGoogleFont(
                            'Saira',
                            fontSize: 14 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.1428571429 * ffem / fem,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // info2JcY (0:1180)
                  margin: EdgeInsets.fromLTRB(
                      0.11 * fem, 0 * fem, 0.11 * fem, 30 * fem),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8 * fem),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // wherewillyouliketogooJQ (0:1181)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 5 * fem),
                        child: Text(
                          'Where will you like to go?',
                          style: SafeGoogleFont(
                            'Saira',
                            fontSize: 16 * ffem,
                            fontWeight: FontWeight.w500,
                            height: 1.575 * ffem / fem,
                            color: const Color(0xffffffff),
                          ),
                        ),
                      ),
                      Container(
                        // group67pt (0:1182)
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8 * fem),
                          border: Border.all(color: const Color(0x0caaaaaa)),
                          color: const Color(0xff2c2b2b),
                        ),
                        child: TextFormField(
                          controller: _destinationController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the destination';
                            }
                            return null;
                          },
                          cursorColor: yellowPrimary,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.fromLTRB(
                                12.5 * fem, 15 * fem, 12.5 * fem, 15 * fem),
                            hintText: 'E.g 14, Oliver street, Quake Rd, Tampa',
                            hintStyle:
                                const TextStyle(color: Color(0x59ffffff)),
                          ),
                          style: SafeGoogleFont(
                            'Saira',
                            fontSize: 14 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.1428571429 * ffem / fem,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // info3HeQ (0:1161)
                  margin: EdgeInsets.fromLTRB(
                      0.11 * fem, 0 * fem, 0.11 * fem, 30 * fem),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // wherewillyouliketogop8Y (0:1162)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 9 * fem),
                        child: Text(
                          'Where will you like to go?',
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
                                            onTap: () => _selectDate(context),
                                            child: Text(
                                              DateFormat('dd MMM yyyy')
                                                  .format(_date),
                                              style: SafeGoogleFont(
                                                'Saira',
                                                fontSize: 14 * ffem,
                                                fontWeight: FontWeight.w500,
                                                height:
                                                    1.4285714286 * ffem / fem,
                                                color: const Color(0xfffdcb5b),
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
                                          GestureDetector(
                                            onTap: () =>
                                                _selectPickupTime(context),
                                            child: Text(
                                              _pickupTime.format(context),
                                              style: SafeGoogleFont(
                                                'Saira',
                                                fontSize: 14 * ffem,
                                                fontWeight: FontWeight.w500,
                                                height:
                                                    1.4285714286 * ffem / fem,
                                                color: const Color(0xfffdcb5b),
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // info1pYx (0:1186)
                  margin: EdgeInsets.fromLTRB(
                      0.11 * fem, 0 * fem, 0.11 * fem, 30 * fem),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8 * fem),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // whereshouldwepickyoufrom9r8 (0:1187)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 5 * fem),
                        child: Text(
                          'Passengers',
                          style: SafeGoogleFont(
                            'Saira',
                            fontSize: 16 * ffem,
                            fontWeight: FontWeight.w500,
                            height: 1.575 * ffem / fem,
                            color: const Color(0xffffffff),
                          ),
                        ),
                      ),
                      Container(
                        // group6GA4 (0:1188)
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8 * fem),
                          border: Border.all(color: const Color(0x0caaaaaa)),
                          color: const Color(0xff2c2b2b),
                        ),
                        child: TextFormField(
                          cursorColor: yellowPrimary,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.fromLTRB(
                                12.5 * fem, 15 * fem, 12.5 * fem, 15 * fem),
                            hintText: 'How many people will be going?',
                            hintStyle:
                                const TextStyle(color: Color(0x59ffffff)),
                          ),
                          controller: _passengersController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter passenger';
                            }
                            return null;
                          },
                          style: SafeGoogleFont(
                            'Saira',
                            fontSize: 14 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.1428571429 * ffem / fem,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                IntrinsicHeight(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xff2c2b2b),
                      borderRadius: BorderRadius.circular(6 * fem),
                    ),
                    child: SizedBox(
                      height: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CheckboxListTile(
                              contentPadding: const EdgeInsets.all(4),
                              value: _isRoundTrip,
                              onChanged: (value) {
                                setState(() {
                                  _isRoundTrip = value ?? false;
                                });
                              },
                              subtitle: Text(
                                'Tick this if you’d like us to bring you back',
                                style: SafeGoogleFont(
                                  'Saira',
                                  fontSize: 12 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.6666666667 * ffem / fem,
                                  color: const Color(0xffaaaaaa),
                                ),
                              ),
                              title: Text(
                                // takeroundtripr7i (0:1156)
                                'Take Round-trip',
                                style: SafeGoogleFont(
                                  'Saira',
                                  fontSize: 16 * ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.25 * ffem / fem,
                                  color: const Color(0xffffffff),
                                ),
                              ),
                              side: const BorderSide(
                                  color: Colors.white, width: 2),
                              controlAffinity: ListTileControlAffinity.leading,
                              activeColor: Colors.white,
                              checkColor: Colors.black),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8 * fem),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // emailQYQ (0:1140)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 5 * fem),
                        child: Text(
                          'Email',
                          style: SafeGoogleFont(
                            'Saira',
                            fontSize: 16 * ffem,
                            fontWeight: FontWeight.w500,
                            height: 1.575 * ffem / fem,
                            color: const Color(0xffffffff),
                          ),
                        ),
                      ),
                      Container(
                        // group68jJ (0:1141)
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8 * fem),
                          border: Border.all(color: const Color(0x0caaaaaa)),
                          color: const Color(0xff2c2b2b),
                        ),
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: yellowPrimary,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.fromLTRB(
                                12.5 * fem, 15 * fem, 12.5 * fem, 15 * fem),
                            hintText: 'xyz.edu@hotmail.com',
                            hintStyle:
                                const TextStyle(color: Color(0x59ffffff)),
                          ),
                          style: SafeGoogleFont(
                            'Saira',
                            fontSize: 14 * ffem,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: yellowPrimary,
                      maximumSize: const Size(double.infinity, 50),
                      padding: const EdgeInsets.all(12)),
                  onPressed: _isLoading ? null : _submitForm,
                  child: _isLoading
                      ? const AspectRatio(
                          aspectRatio: 1, child: CircularProgressIndicator())
                      : Text(
                          'Place Order',
                          style: SafeGoogleFont(
                            'Saira',
                            fontSize: 20 * ffem,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff000000),
                          ),
                        ),
                ),
                const SizedBox(
                  height: 24,
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
