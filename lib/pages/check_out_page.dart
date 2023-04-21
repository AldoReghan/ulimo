import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pay/pay.dart';
import 'package:ulimo/base/base_background_scaffold.dart';
import 'package:ulimo/base/payment_configuration.dart';
import 'package:ulimo/pages/payment_success_page.dart';

import '../base/base_color.dart';
import '../base/utils.dart';
import 'cart_page.dart';

class CheckOutPage extends StatefulWidget {
  final String orderId;
  final String rideType;
  final String destinationName;
  final String destinationAddress;
  final String date;
  final String time;
  final String price;
  final int rideQuantity;
  final int entryQuantity;

  const CheckOutPage(
      {Key? key,
      required this.orderId,
      required this.rideType,
      required this.destinationName,
      required this.destinationAddress,
      required this.date,
      required this.time,
      required this.price,
      required this.rideQuantity,
      required this.entryQuantity})
      : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

const _paymentItems = [
  PaymentItem(
    label: 'Total',
    amount: '99.99',
    status: PaymentItemStatus.final_price,
  )
];

class _CheckOutPageState extends State<CheckOutPage> {
  String _subtitle = "";
  String _title = "";
  String _date = "";
  String _time = "";
  String _price = "0.00";
  double _discountRate = 0.00;
  String _discountName = "";
  bool isCodeValid = false;
  bool _isLoading = false;
  DateTime _discountExpiredDate = DateTime.now();
  final promoController = TextEditingController();
  final _holderNameController = TextEditingController();

  // final cardController = CardFormEditController();

  Map<String, dynamic>? paymentIntent;

  final _databaseRef = FirebaseDatabase.instance.ref();
  final authData = FirebaseAuth.instance;

  String _totalPrice = "0.00";

  late PaymentItem paymentItem;

  late final Pay _payClient;

  Future<void> _getCheckoutData() async {
    if (widget.rideType == 'private') {
      setState(() {
        _price = widget.price;
      });
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult != ConnectivityResult.none) {
        final privateRideSnapshot = await _databaseRef
            .child("privateRide")
            .orderByKey()
            .equalTo(widget.orderId)
            .once();

        final Map<dynamic, dynamic>? privateRideData =
            privateRideSnapshot.snapshot.value as Map<dynamic, dynamic>?;

        if (privateRideData != null) {
          privateRideData.forEach((key, value) async {
            setState(() {
              _title = "PRIVATE RIDE";
              _subtitle =
                  "${value['pickup_address']} to ${value['destination']}";
              _time = "${value['pickup_time']}";
              _date = "${value['date']}";
              // _price = value['price'];
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
    } else {
      setState(() {
        _title = widget.destinationName;
        _subtitle = widget.destinationAddress;
        _time = widget.time;
        _date = widget.date;
        _price = widget.price;
      });
    }
  }

  List<PaymentItem> getPaymentItem() {
    return [
      PaymentItem(
        label: 'Total',
        amount: countTotalPrice(),
        status: PaymentItemStatus.final_price,
      )
    ];
  }

  Future<void> _getPromoCode() async {
    final promoCode = promoController.text.trim();

    final promoCodeSnapshot = await _databaseRef
        .child("discountCode")
        .orderByChild('code')
        .equalTo(promoCode)
        .once();

    final Map<dynamic, dynamic>? promoCodeData =
        promoCodeSnapshot.snapshot.value as Map<dynamic, dynamic>?;

    if (promoCodeData != null) {
      promoCodeData.forEach((key, value) async {
        setState(() {
          _discountRate = double.parse(value['discount_rate']);
          _discountName = value['discount_name'];
          //format yyyy-MM-dd
          _discountExpiredDate = DateTime.parse(value['discount_date_expired']);
        });
        if (_discountExpiredDate.isBefore(DateTime.now())) {
          Fluttertoast.showToast(
              msg: "Promo code is expired",
              backgroundColor: Colors.red,
              textColor: Colors.white);
          setState(() {
            _discountRate = 0;
          });
        } else {
          setState(() {
            isCodeValid = true;
          });
          Fluttertoast.showToast(
              msg: _discountName,
              backgroundColor: CupertinoColors.activeGreen,
              textColor: Colors.white);
        }
      });
    } else {
      Fluttertoast.showToast(
          msg: "Promo code is not available",
          backgroundColor: Colors.red,
          textColor: Colors.white);
      setState(() {
        _discountRate = 0;
        isCodeValid = false;
      });
    }
  }

  void _checkOutTicket() async {
    setState(() {
      _isLoading = true;
    });
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      switch (widget.rideType) {
        case "private":
          {
            await _databaseRef
                .child("privateRide")
                .child(widget.orderId)
                .update({"status": "paid"});
          }
          break;

        case "ridesharebus":
          {
            await _databaseRef.child("rideShareBusTicketOrder").push().set({
              "date": widget.date,
              "entry_quantity": widget.entryQuantity,
              "ride_quantity": widget.rideQuantity,
              "rideShareBusTicket_id": widget.orderId,
              "status": "paid",
              "users_id": authData.currentUser?.uid
            });
          }
          break;

        case "nightlife":
          {
            await _databaseRef.child("nightlifeOrder").push().set({
              "date": widget.date,
              "entry_quantity": widget.entryQuantity,
              "ride_quantity": widget.rideQuantity,
              "nightlife_id": widget.orderId,
              "status": "paid",
              "users_id": authData.currentUser?.uid
            });
          }
          break;
      }

      final databaseReference = FirebaseDatabase.instance.ref('payments');
      await databaseReference.push().set({
        'customerId': authData.currentUser?.uid,
        'name': _holderNameController.text,
        'email': authData.currentUser?.email,
        'amount': countTotalPrice(),
        'status': 'Paid',
      });

      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => PaymentSuccessPage(
                destinationName: _title,
                destinationAddress: _subtitle,
                date: _date,
                time: _time,
                status: 'Confirmed')));
      });
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

  void onApplePayResult(paymentResult) {
    // Send the resulting Apple Pay token to your server / PSP
    _checkOutTicket();
  }

  void onGooglePayResult(paymentResult) {
    // Send the resulting Google Pay token to your server / PSP
    _checkOutTicket();
  }

  void onGooglePayPressed() async {
    // final result = await _payClient.showPaymentSelector(
    await _payClient.showPaymentSelector(
      PayProvider.google_pay,
      [
        PaymentItem(
            label: 'Total',
            amount: countTotalPrice(),
            status: PaymentItemStatus.final_price,
            type: PaymentItemType.total)
      ],
    );
    // Send the resulting Google Pay token to your server / PSP
    _checkOutTicket();
  }

  void onApplePayPressed() async {
    // final result = await _payClient.showPaymentSelector(
    await _payClient.showPaymentSelector(
      PayProvider.apple_pay,
      [
        PaymentItem(
            label: 'Total',
            amount: countTotalPrice(),
            status: PaymentItemStatus.final_price,
            type: PaymentItemType.total)
      ],
    );
    // Send the resulting Google Pay token to your server / PSP
    _checkOutTicket();
  }

  String countTotalPrice() {
    final totalDiscount = double.parse(_price) * (_discountRate / 100);
    final totalPrice = double.parse(_price) - totalDiscount;
    setState(() {
      _totalPrice = totalPrice.toStringAsFixed(2);
    });
    return totalPrice.toStringAsFixed(2);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCheckoutData();
    _holderNameController.text = authData.currentUser?.displayName ?? "";

    _payClient = Pay({
      PayProvider.google_pay:
          PaymentConfiguration.fromJsonString(defaultGooglePay),
      PayProvider.apple_pay:
          PaymentConfiguration.fromJsonString(defaultApplePay),
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
        child: Container(
          padding:
              EdgeInsets.fromLTRB(20 * fem, 40.21 * fem, 20 * fem, 54 * fem),
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 30),
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
                        width: 24 * fem,
                        height: 24 * fem,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 24,
                          ),
                        )),
                    Text(
                      // myprofilecqv (0:608)
                      'Check Out (1)',
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
              ),
              SizedBox(
                height: 40 * fem,
              ),
              Container(
                // group7613HXn (1:1132)
                width: double.infinity,
                height: 80 * fem,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0x0caaaaaa)),
                  color: const Color(0xff201f1f),
                  borderRadius: BorderRadius.circular(6 * fem),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      // ticketzSC (1:1303)
                      left: 123 * fem,
                      top: 8.375 * fem,
                      child: Align(
                        child: SizedBox(
                            width: 24 * fem,
                            height: 24 * fem,
                            child: SvgPicture.asset(
                                "assets/icon/bottom_nav_ticket.svg")),
                      ),
                    ),
                    Positioned(
                      // group7611JSt (1:1134)
                      left: 8.4503173828 * fem,
                      top: 8 * fem,
                      child: SizedBox(
                        width: 242 * fem,
                        height: 64 * fem,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // group7610qBv (1:1135)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 6 * fem),
                              width: double.infinity,
                              height: 39 * fem,
                              child: Stack(
                                children: [
                                  Positioned(
                                    // privaterideAzt (1:1136)
                                    left: 0 * fem,
                                    top: 0 * fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 105 * fem,
                                        height: 26 * fem,
                                        child: Text(
                                          _title,
                                          style: SafeGoogleFont(
                                            'Saira',
                                            fontSize: 16 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.575 * ffem / fem,
                                            color: const Color(0xffffffff),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // wneptunewaytampafltohydeparkca (1:1138)
                                    left: 0 * fem,
                                    top: 25 * fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 242 * fem,
                                        height: 14 * fem,
                                        child: Text(
                                          _subtitle,
                                          style: SafeGoogleFont(
                                            'Saira',
                                            fontSize: 10 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.4 * ffem / fem,
                                            color: const Color(0xffaaaaaa),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // group7609kCQ (1:1139)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 115 * fem, 0 * fem),
                              width: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // feb2023h7e (1:1140)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 5 * fem, 0 * fem),
                                    child: Text(
                                      _date,
                                      style: SafeGoogleFont(
                                        'Saira',
                                        fontSize: 12 * ffem,
                                        fontWeight: FontWeight.w500,
                                        height: 1.575 * ffem / fem,
                                        color: const Color(0xff3586ff),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    // pmD5z (1:1141)
                                    _time,
                                    style: SafeGoogleFont(
                                      'Saira',
                                      fontSize: 12 * ffem,
                                      fontWeight: FontWeight.w500,
                                      height: 1.575 * ffem / fem,
                                      color: const Color(0xff3586ff),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30 * fem,
              ),
              Container(
                // info1fVi (0:1089)
                margin: EdgeInsets.fromLTRB(
                    0.12 * fem, 0 * fem, 0.12 * fem, 36 * fem),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6 * fem),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // holdernameobv (0:1090)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 10 * fem),
                      child: Text(
                        'Name',
                        style: SafeGoogleFont(
                          'Saira',
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.5625 * ffem / fem,
                          color: const Color(0xffffffff),
                        ),
                      ),
                    ),
                    Container(
                      // group1599z (0:1091)
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6 * fem),
                        border: Border.all(color: const Color(0x0caaaaaa)),
                        color: const Color(0xff2c2b2b),
                      ),
                      child: TextFormField(
                        controller: _holderNameController,
                        cursorColor: yellowPrimary,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.fromLTRB(
                              15 * fem, 14 * fem, 15 * fem, 13 * fem),
                          hintText: 'Daniel B. Dalton',
                          hintStyle: const TextStyle(color: Color(0xffaaaaaa)),
                        ),
                        style: SafeGoogleFont(
                          'Saira',
                          fontSize: 14 * ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.575 * ffem / fem,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Container(
              //   // info2Pq2 (0:1079)
              //   margin: EdgeInsets.fromLTRB(
              //       0.08 * fem, 0 * fem, 0.08 * fem, 36 * fem),
              //   width: double.infinity,
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Container(
              //         // cardnumberLkG (0:1080)
              //         margin: EdgeInsets.fromLTRB(
              //             0 * fem, 0 * fem, 0 * fem, 10 * fem),
              //         child: Text(
              //           'Card number',
              //           style: SafeGoogleFont(
              //             'Saira',
              //             fontSize: 16 * ffem,
              //             fontWeight: FontWeight.w500,
              //             height: 1.5625 * ffem / fem,
              //             color: const Color(0xffffffff),
              //           ),
              //         ),
              //       ),
              //       Container(
              //         // group19f1r (0:1081)
              //         width: double.infinity,
              //         height: 54 * fem,
              //         decoration: BoxDecoration(
              //           border: Border.all(color: const Color(0x0caaaaaa)),
              //           color: const Color(0xff2c2b2b),
              //           borderRadius: BorderRadius.circular(6 * fem),
              //         ),
              //         child: TextField(
              //           cursorColor: yellowPrimary,
              //           keyboardType: TextInputType.number,
              //           decoration: InputDecoration(
              //             suffixIcon: Padding(
              //               padding: EdgeInsets.only(right: 10 * fem),
              //               child: Row(
              //                 mainAxisSize: MainAxisSize.min,
              //                 children: [
              //                   Image.asset(
              //                     'assets/icon/paypal.png',
              //                     height: 25 * fem,
              //                     width: 30 * fem,
              //                   ),
              //                   const SizedBox(width: 2),
              //                   Image.asset(
              //                     'assets/icon/stripe.png',
              //                     height: 25 * fem,
              //                     width: 30 * fem,
              //                   ),
              //                   const SizedBox(width: 2),
              //                   Image.asset(
              //                     'assets/icon/master_card.png',
              //                     height: 25 * fem,
              //                     width: 30 * fem,
              //                   ),
              //                 ],
              //               ),
              //             ),
              //             border: InputBorder.none,
              //             focusedBorder: InputBorder.none,
              //             enabledBorder: InputBorder.none,
              //             errorBorder: InputBorder.none,
              //             disabledBorder: InputBorder.none,
              //             contentPadding: EdgeInsets.fromLTRB(
              //                 15 * fem, 14 * fem, 15 * fem, 13 * fem),
              //             hintText: '5000 0000 0000 0000',
              //             hintStyle: const TextStyle(color: Color(0xffaaaaaa)),
              //           ),
              //           style: SafeGoogleFont(
              //             'Saira',
              //             fontSize: 14 * ffem,
              //             fontWeight: FontWeight.w500,
              //             height: 1.575 * ffem / fem,
              //             color: Colors.white,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // IntrinsicHeight(
              //   child: Container(
              //     // info3NS4 (0:1068)
              //     margin: EdgeInsets.fromLTRB(
              //         0.08 * fem, 0 * fem, 0.08 * fem, 36 * fem),
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(6 * fem),
              //     ),
              //     child: Row(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         Container(
              //           // group23uRz (0:1069)
              //           margin: EdgeInsets.fromLTRB(
              //               0 * fem, 0 * fem, 21.64 * fem, 0 * fem),
              //           width: 156.6 * fem,
              //           height: double.infinity,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(6 * fem),
              //           ),
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Container(
              //                 // expirationb3v (0:1070)
              //                 margin: EdgeInsets.fromLTRB(
              //                     0 * fem, 0 * fem, 0 * fem, 10 * fem),
              //                 child: Text(
              //                   'Expiration',
              //                   style: SafeGoogleFont(
              //                     'Saira',
              //                     fontSize: 16 * ffem,
              //                     fontWeight: FontWeight.w500,
              //                     height: 1.5625 * ffem / fem,
              //                     color: const Color(0xffffffff),
              //                   ),
              //                 ),
              //               ),
              //               Container(
              //                 // group22vbz (0:1071)
              //                 width: double.infinity,
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(6 * fem),
              //                   border:
              //                       Border.all(color: const Color(0x0caaaaaa)),
              //                   color: const Color(0xff2c2b2b),
              //                 ),
              //                 child: TextField(
              //                   cursorColor: yellowPrimary,
              //                   decoration: InputDecoration(
              //                     border: InputBorder.none,
              //                     focusedBorder: InputBorder.none,
              //                     enabledBorder: InputBorder.none,
              //                     errorBorder: InputBorder.none,
              //                     disabledBorder: InputBorder.none,
              //                     contentPadding: EdgeInsets.fromLTRB(
              //                         15 * fem, 14 * fem, 15 * fem, 13 * fem),
              //                     hintText: '09/10',
              //                     hintStyle:
              //                         const TextStyle(color: Color(0xa5aaaaaa)),
              //                   ),
              //                   style: SafeGoogleFont(
              //                     'Saira',
              //                     fontSize: 14 * ffem,
              //                     fontWeight: FontWeight.w400,
              //                     height: 1.575 * ffem / fem,
              //                     color: Colors.white,
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //         Container(
              //           // group24bi8 (0:1074)
              //           width: 156.6 * fem,
              //           height: double.infinity,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(6 * fem),
              //           ),
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Container(
              //                 // cvvMSQ (0:1075)
              //                 margin: EdgeInsets.fromLTRB(
              //                     0 * fem, 0 * fem, 0 * fem, 10 * fem),
              //                 child: Text(
              //                   'Cvv',
              //                   style: SafeGoogleFont(
              //                     'Saira',
              //                     fontSize: 16 * ffem,
              //                     fontWeight: FontWeight.w500,
              //                     height: 1.5625 * ffem / fem,
              //                     color: const Color(0xffffffff),
              //                   ),
              //                 ),
              //               ),
              //               Container(
              //                 // group175dJ (0:1076)
              //                 width: double.infinity,
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(6 * fem),
              //                   border:
              //                       Border.all(color: const Color(0x0caaaaaa)),
              //                   color: const Color(0xff2c2b2b),
              //                 ),
              //                 child: TextField(
              //                   cursorColor: yellowPrimary,
              //                   decoration: InputDecoration(
              //                     border: InputBorder.none,
              //                     focusedBorder: InputBorder.none,
              //                     enabledBorder: InputBorder.none,
              //                     errorBorder: InputBorder.none,
              //                     disabledBorder: InputBorder.none,
              //                     contentPadding: EdgeInsets.fromLTRB(
              //                         14.76 * fem,
              //                         14 * fem,
              //                         14.76 * fem,
              //                         13 * fem),
              //                     hintText: '000',
              //                     hintStyle:
              //                         const TextStyle(color: Color(0xa5aaaaaa)),
              //                   ),
              //                   style: SafeGoogleFont(
              //                     'Saira',
              //                     fontSize: 14 * ffem,
              //                     fontWeight: FontWeight.w400,
              //                     height: 1.575 * ffem / fem,
              //                     color: Colors.white,
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // CardFormField(
              //   style: CardFormStyle(
              //       placeholderColor: Colors.grey,
              //       backgroundColor: darkPrimary,
              //       textColor: yellowPrimary,
              //       borderColor: yellowPrimary,
              //       cursorColor: yellowPrimary,
              //       borderRadius: 10),
              //   controller: cardController,
              //   enablePostalCode: false,
              //   countryCode: 'USD',
              // ),
              Container(
                // info4ZoN (0:1063)
                margin: EdgeInsets.fromLTRB(
                    0.37 * fem, 0 * fem, 0.37 * fem, 46 * fem),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6 * fem),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // passcodecodeUQY (0:1064)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 10 * fem),
                      child: Text(
                        'Promo code',
                        style: SafeGoogleFont(
                          'Saira',
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.5625 * ffem / fem,
                          color: const Color(0xffffffff),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          // group16cWk (0:1065)
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6 * fem),
                            border: Border.all(color: const Color(0x0caaaaaa)),
                            color: const Color(0xff2c2b2b),
                          ),
                          child: TextField(
                            cursorColor: yellowPrimary,
                            controller: promoController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.fromLTRB(
                                  15 * fem, 14 * fem, 15 * fem, 13 * fem),
                              hintText: 'Your Promo Code',
                              hintStyle:
                                  const TextStyle(color: Color(0xa5aaaaaa)),
                            ),
                            style: SafeGoogleFont(
                              'Saira',
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.575 * ffem / fem,
                              color: Colors.white,
                            ),
                          ),
                        )),
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          height: 50 * fem,
                          child: ElevatedButton(
                            onPressed: () {
                              //check promo code
                              _getPromoCode();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  isCodeValid ? Colors.green : yellowPrimary,
                            ),
                            child: const Icon(Icons.check),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                // group7530qqJ (0:1290)
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 42.82 * fem),
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
                                '\$${countTotalPrice()}',
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

                    FutureBuilder(
                        future: _payClient.userCanPay(PayProvider.google_pay),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.data == true) {
                              return SizedBox(
                                width: 215.47 * fem,
                                height: double.infinity,
                                child: RawGooglePayButton(
                                  onPressed: () {
                                    onGooglePayPressed();
                                  },
                                  type: GooglePayButtonType.checkout,
                                ),
                              );
                              // return TextButton(
                              //   // button8hv (0:1291)
                              //   onPressed: () async {
                              //     onGooglePayPressed();
                              //   },
                              //   style: TextButton.styleFrom(
                              //     padding: EdgeInsets.zero,
                              //   ),
                              //   child: Container(
                              //     width: 215.47 * fem,
                              //     height: double.infinity,
                              //     decoration: BoxDecoration(
                              //       color: const Color(0xfffdcb5b),
                              //       borderRadius:
                              //           BorderRadius.circular(5 * fem),
                              //     ),
                              //     child: Center(
                              //       child: _isLoading
                              //           ? const AspectRatio(
                              //               aspectRatio: 1,
                              //               child: CircularProgressIndicator())
                              //           : Text(
                              //               'Purchase Ticket',
                              //               style: SafeGoogleFont(
                              //                 'Saira',
                              //                 fontSize: 20 * ffem,
                              //                 fontWeight: FontWeight.w500,
                              //                 height: 1.575 * ffem / fem,
                              //                 color: const Color(0xff000000),
                              //               ),
                              //             ),
                              //     ),
                              //   ),
                              // );
                            } else {
                              // userCanPay returned false
                              // Consider showing an alternative payment method
                              return const SizedBox.shrink();
                            }
                          } else {
                            // The operation hasn't finished loading
                            // Consider showing a loading indicator
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }),
                    FutureBuilder(
                        future: _payClient.userCanPay(PayProvider.apple_pay),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.data == true) {
                              return SizedBox(
                                width: 215.47 * fem,
                                height: double.infinity,
                                child: RawApplePayButton(
                                  onPressed: () {
                                    onApplePayPressed();
                                  },
                                  style: ApplePayButtonStyle.white,
                                  type: ApplePayButtonType.checkout,
                                ),
                              );
                              // return TextButton(
                              //   // button8hv (0:1291)
                              //   onPressed: () async {
                              //     onApplePayPressed();
                              //   },
                              //   style: TextButton.styleFrom(
                              //     padding: EdgeInsets.zero,
                              //   ),
                              //   child: Container(
                              //     width: 215.47 * fem,
                              //     height: double.infinity,
                              //     decoration: BoxDecoration(
                              //       color: const Color(0xfffdcb5b),
                              //       borderRadius:
                              //       BorderRadius.circular(5 * fem),
                              //     ),
                              //     child: Center(
                              //       child: _isLoading
                              //           ? const AspectRatio(
                              //           aspectRatio: 1,
                              //           child: CircularProgressIndicator())
                              //           : Text(
                              //         'Purchase Ticket',
                              //         style: SafeGoogleFont(
                              //           'Saira',
                              //           fontSize: 20 * ffem,
                              //           fontWeight: FontWeight.w500,
                              //           height: 1.575 * ffem / fem,
                              //           color: const Color(0xff000000),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // );
                            } else {
                              // userCanPay returned false
                              // Consider showing an alternative payment method
                              return const SizedBox.shrink();
                            }
                          } else {
                            // The operation hasn't finished loading
                            // Consider showing a loading indicator
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }),

                    // TextButton(
                    //   // button8hv (0:1291)
                    //   onPressed: () async {
                    //     //go to success page
                    //     _checkOutTicket();
                    //     // await makePayment();
                    //   },
                    //   style: TextButton.styleFrom(
                    //     padding: EdgeInsets.zero,
                    //   ),
                    //   child: Container(
                    //     width: 215.47 * fem,
                    //     height: double.infinity,
                    //     decoration: BoxDecoration(
                    //       color: const Color(0xfffdcb5b),
                    //       borderRadius: BorderRadius.circular(5 * fem),
                    //     ),
                    //     child: Center(
                    //       child: _isLoading
                    //           ? const AspectRatio(
                    //               aspectRatio: 1,
                    //               child: CircularProgressIndicator())
                    //           : Text(
                    //               'Purchase Ticket',
                    //               style: SafeGoogleFont(
                    //                 'Saira',
                    //                 fontSize: 20 * ffem,
                    //                 fontWeight: FontWeight.w500,
                    //                 height: 1.575 * ffem / fem,
                    //                 color: const Color(0xff000000),
                    //               ),
                    //             ),
                    //     ),
                    //   ),
                    // ),

                    // ApplePayButton(
                    //   paymentConfiguration:
                    //       PaymentConfiguration.fromJsonString(defaultApplePay),
                    //   paymentItems: [
                    //     PaymentItem(
                    //       label: 'Total',
                    //       amount: _totalPrice,
                    //       status: PaymentItemStatus.final_price,
                    //     )
                    //   ],
                    //   onPressed: (){
                    //
                    //   },
                    //   width: 215.47 * fem,
                    //   height: double.infinity,
                    //   style: ApplePayButtonStyle.white,
                    //   type: ApplePayButtonType.checkout,
                    //   margin: const EdgeInsets.only(top: 15.0),
                    //   onPaymentResult: onApplePayResult,
                    //   loadingIndicator: const Center(
                    //     child: CircularProgressIndicator(),
                    //   ),
                    // ),
                    //
                    //
                    // GooglePayButton(
                    //   paymentConfiguration: PaymentConfiguration.fromJsonString(
                    //       defaultGooglePay),
                    //   paymentItems: [
                    //     paymentItem
                    //   ],
                    //   onPressed: (){
                    //     paymentItem = PaymentItem(
                    //         label: 'Total',
                    //         amount: countTotalPrice(),
                    //         status: PaymentItemStatus.final_price,
                    //         type: PaymentItemType.total
                    //     );
                    //   },
                    //   width: 215.47 * fem,
                    //   height: double.infinity,
                    //   type: GooglePayButtonType.checkout,
                    //   onPaymentResult: onGooglePayResult,
                    //   loadingIndicator: const Center(
                    //     child: CircularProgressIndicator(),
                    //   ),
                    // ),
                  ],
                ),
              ),
              const SizedBox(
                height: 22,
              ),
            ],
          ),
        ),
      )),
    ));
  }
}
