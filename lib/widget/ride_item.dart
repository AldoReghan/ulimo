import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../base/utils.dart';

Widget rideItem(
    {required double fem,
    required double ffem,
    required String title,
    required String ticketType,
    required String ticketType2,
    required String imageUrl,
    required Function() onTap}) {
  return IntrinsicHeight(
    child: GestureDetector(
      onTap: (){
        onTap.call();
      },
      child: Container(
        // group7557oBN (0:324)
        margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 20 * fem),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0x0caaaaaa)),
          color: const Color(0xff201f1f),
          borderRadius: BorderRadius.circular(6 * fem),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              // imagesS8 (0:326)
              width: 64.58 * fem,
              height: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6 * fem),
                  bottomLeft: Radius.circular(6 * fem),
                ),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                // autogroupc2wvBxc (B1LDMx4TM8gPK6XHesC2wV)
                padding:
                    EdgeInsets.fromLTRB(10 * fem, 7 * fem, 15 * fem, 7 * fem),
                height: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      // thetampaclubEfz (0:329)
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: Text(
                          title,
                          style: SafeGoogleFont(
                            'Saira',
                            fontSize: 16 * ffem,
                            fontWeight: FontWeight.w500,
                            height: 1.25 * ffem / fem,
                            color: const Color(0xffffffff),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              // rideticketUaL (0:331)
                              ticketType,
                              style: SafeGoogleFont(
                                'Saira',
                                fontSize: 10 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 2 * ffem / fem,
                                color: const Color(0xffffffff),
                              ),
                            ),
                            Container(
                              // autogroupthgwDnp (B1LDb2WzuBGZTuw1bHthGw)
                              padding: EdgeInsets.fromLTRB(
                                  3 * fem, 0 * fem, 0 * fem, 0 * fem),
                              height: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // ellipse3Kqr (0:333)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 4 * fem, 0 * fem),
                                    width: 5.49 * fem,
                                    height: 5.49 * fem,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          2.7470855713 * fem),
                                      color: const Color(0xfffdcb5b),
                                    ),
                                  ),
                                  Text(
                                    // entryticket3Wx (0:332)
                                    ticketType2,
                                    style: SafeGoogleFont(
                                      'Saira',
                                      fontSize: 10 * ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 2 * ffem / fem,
                                      color: const Color(0xffffffff),
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
            ),
            Padding(
              padding: const EdgeInsets.only(right: 17),
              child: Icon(
                Icons.keyboard_arrow_right,
                size: 24 * fem,
                color: const Color(0xFFAAAAAA),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
