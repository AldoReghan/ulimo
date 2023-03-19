import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ulimo/base/base_background_scaffold.dart';
import 'package:ulimo/base/base_color.dart';
import 'package:ulimo/base/base_color.dart';
import 'package:ulimo/base/base_color.dart';
import 'package:ulimo/base/base_color.dart';
import 'package:ulimo/base/base_color.dart';

import '../../base/utils.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
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
                  padding: EdgeInsets.fromLTRB(
                      20 * fem, 40.21 * fem, 20 * fem, 54 * fem),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // arrowKep (0:1098)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 36 * fem),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          child: SizedBox(
                              width: 24 * fem,
                              height: 24 * fem,
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 24 * fem,
                                color: Colors.white,
                              )),
                        ),
                      ),
                      Container(
                        // textoK6 (0:1094)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 36 * fem),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // editprofileKYL (0:1096)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 4 * fem),
                              child: Text(
                                'Edit Profile',
                                style: SafeGoogleFont(
                                  'Saira',
                                  fontSize: 24 * ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.575 * ffem / fem,
                                  color: const Color(0xffffffff),
                                ),
                              ),
                            ),
                            Container(
                              // nobodycanseeyourcreditcarddeta (0:1097)
                              constraints: BoxConstraints(
                                maxWidth: 335 * fem,
                              ),
                              child: Text(
                                'Nobody can see your credit card details other than Stripe',
                                style: SafeGoogleFont(
                                  'Saira',
                                  fontSize: 16 * ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5625 * ffem / fem,
                                  color: const Color(0xbfaaaaaa),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                                  hintStyle:
                                      const TextStyle(color: Color(0xffaaaaaa)),
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
                                    padding:  EdgeInsets.only(right: 10 * fem),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          'assets/icon/paypal.png',
                                          height: 25 * fem,
                                          width: 30* fem,
                                        ),
                                        const SizedBox(width: 2),
                                        Image.asset(
                                          'assets/icon/stripe.png',
                                          height: 25 * fem,
                                          width: 30* fem,
                                        ),
                                        const SizedBox(width: 2),
                                        Image.asset(
                                          'assets/icon/master_card.png',
                                          height: 25 * fem,
                                          width: 30* fem,
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
                                  hintStyle:
                                  const TextStyle(color: Color(0xffaaaaaa)),
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
                                        border: Border.all(
                                            color: const Color(0x0caaaaaa)),
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
                                          hintStyle: const TextStyle(
                                              color: Color(0xa5aaaaaa)),
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
                                        border: Border.all(
                                            color: const Color(0x0caaaaaa)),
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
                                          hintStyle: const TextStyle(
                                              color: Color(0xa5aaaaaa)),
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
                      TextButton(
                        // buttonHct (0:1059)
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 50 * fem,
                          decoration: BoxDecoration(
                            color: const Color(0xfffdcb5b),
                            borderRadius: BorderRadius.circular(5 * fem),
                          ),
                          child: Center(
                            child: Text(
                              'Continue',
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
              ),
            )));
  }
}
