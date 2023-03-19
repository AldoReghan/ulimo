import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../base/utils.dart';

Widget profileMenu({required BuildContext context, required String title, required String iconAsset, required Function() onTap}){
  double baseWidth = 375;
  double fem = MediaQuery.of(context).size.width / baseWidth;
  double ffem = fem * 0.97;
  return GestureDetector(
    onTap: (){
      onTap.call();
    },
    child: Container(
      // info2Gik (0:529)
      margin: EdgeInsets.fromLTRB(
          0.4 * fem, 0 * fem, 0 * fem, 20 * fem),
      padding: EdgeInsets.fromLTRB(
          11.4 * fem, 13 * fem, 10.6 * fem, 13 * fem),
      width: double.infinity,
      height: 50 * fem,
      decoration: BoxDecoration(
        color: const Color(0xff2b2b2b),
        borderRadius: BorderRadius.circular(6 * fem),
        boxShadow: [
          BoxShadow(
            color: const Color(0x14000000),
            offset: Offset(0 * fem, 4 * fem),
            blurRadius: 24 * fem,
          ),
        ],
      ),
      child: SizedBox(
        // group7594LyW (0:531)
        width: double.infinity,
        height: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // frameHtk (0:536)
                margin: EdgeInsets.fromLTRB(
                    0 * fem, 0 * fem, 8 * fem, 0 * fem),
                width: 24 * fem,
                height: 24 * fem,
                child: SvgPicture.asset(
                    iconAsset)),
            Expanded(
              child: Container(
                // setingsb8k (0:532)
                margin: EdgeInsets.fromLTRB(
                    0 * fem, 0 * fem, 0 * fem, 0 * fem),
                child: Text(
                  title,
                  style: SafeGoogleFont(
                    'Saira',
                    fontSize: 14 * ffem,
                    fontWeight: FontWeight.w500,
                    height: 1.4285714286 * ffem / fem,
                    color: const Color(0xffaaaaaa),
                  ),
                ),
              ),
            ),
            const Icon(Icons.keyboard_arrow_right,
                size: 24, color: Colors.white)
          ],
        ),
      ),
    ),
  );
}