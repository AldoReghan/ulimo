import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../base/base_color.dart';
import '../base/utils.dart';

Widget ticketExpiredItem(
    {required double fem,
    required double ffem,
    required String address,
    required String date,
    required String time,
    required String status,
    required String rideName}) {
  return Container(
    // autogroup8kvhNC8 (B1LcCTg9vHsnNENVyN8kVh)
    padding:
    EdgeInsets.fromLTRB(22.43 * fem, 16.83 * fem, 21.52 * fem, 18.26 * fem),
    margin: const EdgeInsets.only(bottom: 24),
    width: double.infinity,
    decoration: const BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.fitWidth,
        image: AssetImage("assets/ticket_expired_background.png"),
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
                          rideName,
                          overflow: TextOverflow.ellipsis,
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
          child: const DottedLine(
            dashColor: Color(0xffFB1B1B),
          ),
        ),
        Container(
          // ticketstatusEfa (1:1382)
          margin: const EdgeInsets.only(left: 6, right: 6, bottom: 10, top: 3),
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
          margin: EdgeInsets.fromLTRB(8.04 * fem, 0 * fem, 0 * fem, 0 * fem),
          child: Text(
            // toBeginningOfSentenceCase(status) ?? status,
            "Expired",
            style: SafeGoogleFont(
              'Saira',
              fontSize: 12 * ffem,
              fontWeight: FontWeight.w500,
              height: 1.1666666667 * ffem / fem,
              color: const Color(0xffFB1B1B),
            ),
          ),
        ),
      ],
    ),
  );
}
