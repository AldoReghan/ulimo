import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../base/base_color.dart';
import '../base/utils.dart';

Widget ticketActiveItem(
    {required double fem,
    required double ffem,
    required String address,
    required String date,
    required String time,
    required String status,
    required String rideName}) {
  return Container(
    padding:
        EdgeInsets.fromLTRB(22.43 * fem, 16.83 * fem, 21.52 * fem, 18.26 * fem),
    margin: const EdgeInsets.only(bottom: 24),
    width: double.infinity,
    decoration: const BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage("assets/ticket_active_background.png"),
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
              Container(
                // group15oHS (1:1385)
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 27.6 * fem, 0 * fem),
                width: 177 * fem,
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
                      DateFormat("h:mm a")
                          .format(DateFormat("H:mm").parse(time)),
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
                      DateFormat("dd MMM yyyy")
                          .format(DateFormat("dd-MM-yyyy").parse(date)),
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
            dashColor: Color(0xff0B7E00),
          ),
        ),
        Container(
          // ticketstatusEfa (1:1382)
          margin: EdgeInsets.fromLTRB(6.41 * fem, 0 * fem, 0 * fem, 6 * fem),
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
            'Active',
            style: SafeGoogleFont(
              'Saira',
              fontSize: 12 * ffem,
              fontWeight: FontWeight.w500,
              height: 1.1666666667 * ffem / fem,
              color: const Color(0xff0B7E00),
            ),
          ),
        ),
      ],
    ),
  );
}
