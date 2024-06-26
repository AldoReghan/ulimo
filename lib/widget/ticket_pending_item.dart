import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../base/base_color.dart';
import '../base/utils.dart';

Widget ticketPendingItem(
    {required double fem,
    required double ffem,
    required String address,
    required String date,
    required String time,
    required String price,
    required String status,
    required Function() onTap}) {
  final backgroundTicket = status == "pending"
      ? const AssetImage("assets/ticket_pending_background.png")
      : const AssetImage("assets/ticket_approved_background.png");

  final baseColor =
      status == "pending" ? yellowPrimary : const Color(0xFF3586FF);

  final showPayButton = status == "approved" ? true : false;

  return Container(
    // autogroup8kvhNC8 (B1LcCTg9vHsnNENVyN8kVh)
    padding:
      EdgeInsets.fromLTRB(22.43 * fem, 16.83 * fem, 21.52 * fem, 18.26 * fem),
    margin: const EdgeInsets.only(bottom: 24),
    width: double.infinity,
    decoration: BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.fitWidth,
        image: backgroundTicket,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // group7607UFA (1:1384)
          margin:
              EdgeInsets.fromLTRB(8.04 * fem, 0 * fem, 4.41 * fem, 25.6 * fem),
          width: double.infinity,
          height: 41 * fem,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  // group15oHS (1:1385)
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 27.6 * fem, 0 * fem),
                  height: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // privaterideYF2 (1:1386)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 1 * fem),
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
                      SizedBox(
                        // group14eor (1:1387)
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                // frameowe (1:1389)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 5 * fem, 0 * fem),
                                width: 14 * fem,
                                height: 14 * fem,
                                child:
                                    SvgPicture.asset("assets/icon/location.svg")),
                            Text(
                              // wplattsttampafl33606LRn (1:1388)
                              address,
                              overflow: TextOverflow.ellipsis,
                              style: SafeGoogleFont(
                                'Saira',
                                fontSize: 10 * ffem,
                                fontWeight: FontWeight.w500,
                                height: 1.4 * ffem / fem,
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
              Container(
                // group7606sRi (1:1392)
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 1.5 * fem, 0 * fem, 1.5 * fem),
                height: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // pmQwS (1:1394)
                      time == ''? '' : time,
                      style: SafeGoogleFont(
                        'Saira',
                        fontSize: 12 * ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.575 * ffem / fem,
                        color: const Color(0xffffffff),
                      ),
                    ),
                    Text(
                      // feb2023kkQ (1:1393)
                      DateFormat("MMM dd yyyy")
                          .format(DateFormat("MM/dd/yyyy").parse(date)),
                      style: SafeGoogleFont(
                        'Saira',
                        fontSize: 12 * ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.575 * ffem / fem,
                        color: const Color(0xffffffff),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 24.6 * fem),
          child: DottedLine(
            dashColor: baseColor,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 6, right: 6, bottom: 10),
          width: double.infinity,
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // ticketstatusEfa (1:1382)
                      margin: EdgeInsets.fromLTRB(
                          6.41 * fem, 0 * fem, 0 * fem, 6 * fem),
                      child: Text(
                        'Ticket Status',
                        style: SafeGoogleFont(
                          'Saira',
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w500,
                          height: 0.875 * ffem / fem,
                          color: const Color(0xffffffff),
                        ),
                      ),
                    ),
                    Container(
                      // confirmedkdv (1:1383)
                      margin: EdgeInsets.fromLTRB(
                          8.04 * fem, 0 * fem, 0 * fem, 0 * fem),
                      child: Text(
                        toBeginningOfSentenceCase(status) ?? status,
                        style: SafeGoogleFont(
                          'Saira',
                          fontSize: 12 * ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.1666666667 * ffem / fem,
                          color: baseColor,
                        ),
                      ),
                    ),
                  ],
                ),
                showPayButton
                    ? SizedBox(
                        height: 30 * fem,
                        child: ElevatedButton(
                          // button8hv (0:1291)
                          onPressed: () {
                            onTap.call();
                          },
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              backgroundColor: yellowPrimary),
                          child: Center(
                            child: Text(
                              'PAY \$$price',
                              style: SafeGoogleFont(
                                'Saira',
                                fontSize: 16 * ffem,
                                fontWeight: FontWeight.w500,
                                height: 1.575 * ffem / fem,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        )
      ],
    ),
  );
}
