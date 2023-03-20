import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ulimo/base/base_background_scaffold.dart';
import 'package:ulimo/pages/payment_success_page.dart';

import '../base/base_color.dart';
import '../base/utils.dart';
import 'cart_page.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
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
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 24,
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
                                "assets/icon/profile_ticket.svg")),
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
                                          'PRIVATE RIDE',
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
                                          '5224 W Neptune Way, Tampa, FL to Hyde Park Cafe',
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
                                      '03 FEB 2023',
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
                                    '6:20 PM',
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
                        'Holder Name',
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
                      child: TextField(
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
              Container(
                // info2Pq2 (0:1079)
                margin: EdgeInsets.fromLTRB(
                    0.08 * fem, 0 * fem, 0.08 * fem, 36 * fem),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // cardnumberLkG (0:1080)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 10 * fem),
                      child: Text(
                        'Card number',
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
                      // group19f1r (0:1081)
                      width: double.infinity,
                      height: 54 * fem,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0x0caaaaaa)),
                        color: const Color(0xff2c2b2b),
                        borderRadius: BorderRadius.circular(6 * fem),
                      ),
                      child: TextField(
                        cursorColor: yellowPrimary,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(right: 10 * fem),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/icon/paypal.png',
                                  height: 25 * fem,
                                  width: 30 * fem,
                                ),
                                const SizedBox(width: 2),
                                Image.asset(
                                  'assets/icon/stripe.png',
                                  height: 25 * fem,
                                  width: 30 * fem,
                                ),
                                const SizedBox(width: 2),
                                Image.asset(
                                  'assets/icon/master_card.png',
                                  height: 25 * fem,
                                  width: 30 * fem,
                                ),
                              ],
                            ),
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.fromLTRB(
                              15 * fem, 14 * fem, 15 * fem, 13 * fem),
                          hintText: '5000 0000 0000 0000',
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
              IntrinsicHeight(
                child: Container(
                  // info3NS4 (0:1068)
                  margin: EdgeInsets.fromLTRB(
                      0.08 * fem, 0 * fem, 0.08 * fem, 36 * fem),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6 * fem),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // group23uRz (0:1069)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 21.64 * fem, 0 * fem),
                        width: 156.6 * fem,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6 * fem),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // expirationb3v (0:1070)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 10 * fem),
                              child: Text(
                                'Expiration',
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
                              // group22vbz (0:1071)
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6 * fem),
                                border:
                                    Border.all(color: const Color(0x0caaaaaa)),
                                color: const Color(0xff2c2b2b),
                              ),
                              child: TextField(
                                cursorColor: yellowPrimary,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.fromLTRB(
                                      15 * fem, 14 * fem, 15 * fem, 13 * fem),
                                  hintText: '09/10',
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
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // group24bi8 (0:1074)
                        width: 156.6 * fem,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6 * fem),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // cvvMSQ (0:1075)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 10 * fem),
                              child: Text(
                                'Cvv',
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
                              // group175dJ (0:1076)
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6 * fem),
                                border:
                                    Border.all(color: const Color(0x0caaaaaa)),
                                color: const Color(0xff2c2b2b),
                              ),
                              child: TextField(
                                cursorColor: yellowPrimary,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.fromLTRB(
                                      14.76 * fem,
                                      14 * fem,
                                      14.76 * fem,
                                      13 * fem),
                                  hintText: '000',
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
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                        'Passcode code',
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
                      // group16cWk (0:1065)
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6 * fem),
                        border: Border.all(color: const Color(0x0caaaaaa)),
                        color: const Color(0xff2c2b2b),
                      ),
                      child: TextField(
                        cursorColor: yellowPrimary,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.fromLTRB(
                              15 * fem, 14 * fem, 15 * fem, 13 * fem),
                          hintText: '******',
                          hintStyle: const TextStyle(color: Color(0xa5aaaaaa)),
                        ),
                        style: SafeGoogleFont(
                          'Saira',
                          fontSize: 14 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.575 * ffem / fem,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // group7530qqJ (0:1290)
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
                          0 * fem, 0 * fem, 45.42 * fem, 0 * fem),
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
                          Text(
                            // QX2 (0:1297)
                            '\$20.00',
                            style: SafeGoogleFont(
                              'Barlow',
                              fontSize: 24 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.2 * ffem / fem,
                              color: const Color(0xfffdcb5b),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      // button8hv (0:1291)
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const PaymentSuccessPage()));
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
              ),
              const SizedBox(
                height: 22,
              ),
              SizedBox(
                // poweredbystriperZW (1:945)
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      // poweredbyBrg (1:946)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 12 * fem, 0 * fem),
                      child: Text(
                        'Powered by',
                        textAlign: TextAlign.center,
                        style: SafeGoogleFont(
                          'Saira',
                          fontSize: 12 * ffem,
                          fontWeight: FontWeight.w700,
                          height: 1.8333333333 * ffem / fem,
                          color: const Color(0xff707070),
                        ),
                      ),
                    ),
                    Container(
                        // stripe42ha8 (1:947)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 0.07 * fem),
                        width: 38 * fem,
                        height: 15.93 * fem,
                        child: Image.asset("assets/icon/stripe_flat.png")),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    ));
  }
}
