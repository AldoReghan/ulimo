import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ulimo/base/base_background_scaffold.dart';

import '../../base/utils.dart';

class MyTicketPage extends StatefulWidget {
  const MyTicketPage({Key? key}) : super(key: key);

  @override
  State<MyTicketPage> createState() => _MyTicketPageState();
}

class _MyTicketPageState extends State<MyTicketPage> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return defaultBackgroundScaffold(
        scaffold: Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.fromLTRB(20 * fem, 40.21 * fem, 20 * fem, 54 * fem),
        child: Column(
          children: [
            Container(
              // arrowKep (0:1098)
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 36 * fem),
              width: double.infinity,
              child: Align(
                alignment: Alignment.topLeft,
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
            ),
            Container(
              // categoriesCF2 (0:710)
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 24 * fem),
              width: double.infinity,
              height: 40 * fem,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // button1vRv (0:711)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 11.97 * fem, 0 * fem),
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(
                            6.13 * fem, 6 * fem, 6.13 * fem, 6 * fem),
                        width: 97.63 * fem,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xfffdcb5b),
                          borderRadius: BorderRadius.circular(6 * fem),
                        ),
                        child: SizedBox(
                          // group7566bnx (0:713)
                          width: 75 * fem,
                          height: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // group75619Za (0:714)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 6 * fem, 0 * fem),
                                width: 28 * fem,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xff000000)),
                                  borderRadius: BorderRadius.circular(14 * fem),
                                ),
                                child: Center(
                                  child: Text(
                                    '0',
                                    style: SafeGoogleFont(
                                      'Saira',
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.575 * ffem / fem,
                                      color: const Color(0xff000000),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                // activeoPE (0:717)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 1 * fem, 0 * fem, 0 * fem),
                                child: Text(
                                  'Active',
                                  style: SafeGoogleFont(
                                    'Saira',
                                    fontSize: 14 * ffem,
                                    fontWeight: FontWeight.w500,
                                    height: 1.575 * ffem / fem,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    // button2WYY (0:718)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 11.97 * fem, 0 * fem),
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(
                            6.13 * fem, 6 * fem, 6.13 * fem, 6 * fem),
                        width: 108.16 * fem,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xff2c2b2b),
                          borderRadius: BorderRadius.circular(6 * fem),
                        ),
                        child: SizedBox(
                          // group7568Q88 (0:720)
                          width: 88 * fem,
                          height: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // group7562Z12 (0:721)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 6 * fem, 0 * fem),
                                width: 28 * fem,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xa5aaaaaa)),
                                  borderRadius: BorderRadius.circular(14 * fem),
                                ),
                                child: Center(
                                  child: Text(
                                    '0',
                                    style: SafeGoogleFont(
                                      'Saira',
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w500,
                                      height: 1.575 * ffem / fem,
                                      color: const Color(0xa5aaaaaa),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                // pendingSac (0:724)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 1 * fem, 0 * fem, 0 * fem),
                                child: Text(
                                  'Pending',
                                  style: SafeGoogleFont(
                                    'Saira',
                                    fontSize: 14 * ffem,
                                    fontWeight: FontWeight.w500,
                                    height: 1.575 * ffem / fem,
                                    color: const Color(0xa5aaaaaa),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    // button39zp (0:725)
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(
                          6.13 * fem, 6 * fem, 6.13 * fem, 6 * fem),
                      width: 105.27 * fem,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xff2c2b2b),
                        borderRadius: BorderRadius.circular(6 * fem),
                      ),
                      child: SizedBox(
                        // group7570Tkc (0:727)
                        width: 84 * fem,
                        height: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // group7563Qfr (0:728)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 6 * fem, 0 * fem),
                              width: 28 * fem,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xa5aaaaaa)),
                                borderRadius: BorderRadius.circular(14 * fem),
                              ),
                              child: Center(
                                child: Text(
                                  '0',
                                  style: SafeGoogleFont(
                                    'Saira',
                                    fontSize: 14 * ffem,
                                    fontWeight: FontWeight.w600,
                                    height: 1.575 * ffem / fem,
                                    color: const Color(0xa5aaaaaa),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              // expiredVhJ (0:731)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 1 * fem, 0 * fem, 0 * fem),
                              child: Text(
                                'Expired',
                                style: SafeGoogleFont(
                                  'Saira',
                                  fontSize: 14 * ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.575 * ffem / fem,
                                  color: const Color(0xa5aaaaaa),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    ));
  }
}
