import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ulimo/base/base_background_scaffold.dart';
import 'package:ulimo/base/base_color.dart';
import 'package:ulimo/pages/main/main_page.dart';
import 'package:ulimo/widget/ticket_checkout_item.dart';
import 'package:ulimo/widget/ticket_pending_item.dart';

import '../base/utils.dart';

class PaymentSuccessPage extends StatefulWidget {
  final String destinationName;
  final String destinationAddress;
  final String date;
  final String time;
  final String status;

  const PaymentSuccessPage(
      {Key? key,
      required this.destinationName,
      required this.destinationAddress,
      required this.date,
      required this.time,
      required this.status})
      : super(key: key);

  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return defaultBackgroundScaffold(
        scaffold: Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      20 * fem, 40.21 * fem, 20 * fem, 54 * fem),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Container(
                        // group7560aeL (0:603)
                        margin: EdgeInsets.fromLTRB(
                            10 * fem, 0 * fem, 0 * fem, 0.1 * fem),
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
                              'Success',
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
                      Container(
                        // text2LUQ (1:1209)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 24 * fem, 0 * fem, 3.08 * fem),
                        child: RichText(
                          text: TextSpan(
                            style: SafeGoogleFont(
                              'Saira',
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.575 * ffem / fem,
                              color: const Color(0xfffdcb5b),
                            ),
                            children: [
                              TextSpan(
                                text: 'Your Private Ride Ticket has been ',
                                style: SafeGoogleFont(
                                  'Saira',
                                  fontSize: 16 * ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.575 * ffem / fem,
                                  color: const Color(0xffffffff),
                                ),
                              ),
                              const TextSpan(
                                text: 'Purchased!',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        // text32Ek (1:1233)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 23.5 * fem),
                        child: Text(
                          'Check your email and Tickets for more details.',
                          textAlign: TextAlign.start,
                          style: SafeGoogleFont(
                            'Saira',
                            fontSize: 14 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.575 * ffem / fem,
                            color: const Color(0xffffffff),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        // group7608LmE (1:1373)
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // purchasedtickets1fHi (1:1374)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 9.5 * fem),
                              child: Text(
                                'Purchased Tickets (1)',
                                style: SafeGoogleFont(
                                  'Saira',
                                  fontSize: 18 * ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.575 * ffem / fem,
                                  color: const Color(0xffffffff),
                                ),
                              ),
                            ),
                            ticketCheckoutItem(
                                fem: fem,
                                ffem: ffem,
                                address: widget.destinationAddress,
                                date: widget.date,
                                time: widget.time,
                                onTap: () {}, title: widget.destinationName)
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          Container(
            // buttonWS4 (1:1268)
            margin:
                EdgeInsets.fromLTRB(20 * fem, 0 * fem, 20 * fem, 15.79 * fem),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const MainPage()),
                );
              },
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
          ),
        ],
      )),
    ));
  }
}
