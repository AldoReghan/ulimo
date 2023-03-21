import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';

import '../base/base_color.dart';
import '../base/utils.dart';

Widget dateAvailableItem(
    {required double fem,
    required double ffem,
    required selectedIndex,
    required index,
    required Function(int) onTap}) {
  return Padding(
    padding: const EdgeInsets.only(right: 6),
    child: GestureDetector(
      onTap: () {
        onTap.call(index);
      },
      child: IntrinsicWidth(
        child: DottedBorder(
          borderType: BorderType.RRect,
          strokeWidth: 1,
          color: selectedIndex == index
              ? yellowPrimary
              : const Color(0xFFAAAAAA).withOpacity(0.65),
          radius: const Radius.circular(6),
          child: Container(
            padding: EdgeInsets.fromLTRB(
                16.5 * fem, 16.8 * fem, 15.5 * fem, 15.8 * fem),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // febJ5N (0:1268)
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 9 * fem),
                  child: Text(
                    'FEB',
                    style: SafeGoogleFont(
                      'Gilroy',
                      fontSize: 16 * ffem,
                      fontWeight: FontWeight.w800,
                      height: 1.2575 * ffem / fem,
                      color: selectedIndex == index
                          ? yellowPrimary
                          : const Color(0xFFAAAAAA).withOpacity(0.65),
                    ),
                  ),
                ),
                Container(
                  // Qu6 (0:1269)
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 1 * fem, 0 * fem),
                  child: Text(
                    '24',
                    style: SafeGoogleFont(
                      'Gilroy',
                      fontSize: 16 * ffem,
                      fontWeight: FontWeight.w800,
                      height: 1.2575 * ffem / fem,
                      color: selectedIndex == index
                          ? yellowPrimary
                          : const Color(0xFFAAAAAA).withOpacity(0.65),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
