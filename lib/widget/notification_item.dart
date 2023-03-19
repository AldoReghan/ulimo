import 'package:flutter/cupertino.dart';

import '../base/utils.dart';

Widget notificationItem(
    {required double fem,
    required double ffem,
    required String title,
    required String subtitle,
    required String timeStamp}) {
  return IntrinsicHeight(
    child: Container(
      // group7612dct (0:1037)
      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 20 * fem),
      padding: EdgeInsets.fromLTRB(8.45 * fem, 8 * fem, 8.45 * fem, 8 * fem),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0x0caaaaaa)),
        color: const Color(0xff201f1f),
        borderRadius: BorderRadius.circular(6 * fem),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: SafeGoogleFont(
              'Saira',
              fontSize: 16 * ffem,
              fontWeight: FontWeight.w500,
              height: 1.575 * ffem / fem,
              color: const Color(0xffffffff),
            ),
          ),
          Text(
            subtitle,
            style: SafeGoogleFont(
              'Saira',
              fontSize: 10 * ffem,
              fontWeight: FontWeight.w500,
              height: 1.4 * ffem / fem,
              color: const Color(0xffaaaaaa),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            timeStamp,
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
  );
}
