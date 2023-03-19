import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ulimo/base/base_background_scaffold.dart';

import '../base/utils.dart';

class NightListPage extends StatefulWidget {
  const NightListPage({Key? key}) : super(key: key);

  @override
  State<NightListPage> createState() => _NightListPageState();
}

class _NightListPageState extends State<NightListPage> {
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // autogrouplczqZkt (B1LAVsAXW7wCDsdiquLCZq)
              padding: EdgeInsets.fromLTRB(
                  20 * fem, 60.21 * fem, 20 * fem, 244.08 * fem),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // group7560fov (0:367)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 113 * fem, 25.92 * fem),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            // arrowQFi (0:368)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 27 * fem, 0 * fem),
                            width: 24 * fem,
                            height: 24 * fem,
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 24 * fem,
                              color: Colors.white,
                            )),
                        RichText(
                          // nightlifedealsK7n (0:372)
                          text: TextSpan(
                            style: SafeGoogleFont(
                              'Saira',
                              fontSize: 24 * ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.575 * ffem / fem,
                              color: const Color(0xffffffff),
                            ),
                            children: [
                              const TextSpan(
                                text: 'NightLife ',
                              ),
                              TextSpan(
                                text: 'Deals',
                                style: SafeGoogleFont(
                                  'Saira',
                                  fontSize: 24 * ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.575 * ffem / fem,
                                  color: const Color(0xfffdcb5b),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // group7557oBN (0:324)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, 20 * fem),
                    width: double.infinity,
                    height: 58 * fem,
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
                          height: 58 * fem,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6 * fem),
                              bottomLeft: Radius.circular(6 * fem),
                            ),
                            child: Image.asset(
                              'assets/page-1/images/image-bSg.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          // autogroupc2wvBxc (B1LDMx4TM8gPK6XHesC2wV)
                          padding: EdgeInsets.fromLTRB(
                              10 * fem, 7 * fem, 15 * fem, 7 * fem),
                          height: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // group7554iBr (0:328)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 102.42 * fem, 0 * fem),
                                width: 119 * fem,
                                height: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      // thetampaclubEfz (0:329)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 4 * fem),
                                      child: Text(
                                        'The Tampa Club',
                                        style: SafeGoogleFont(
                                          'Saira',
                                          fontSize: 16 * ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.25 * ffem / fem,
                                          color: const Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // group7553Ygg (0:330)
                                      margin: EdgeInsets.fromLTRB(0 * fem,
                                          0 * fem, 4.51 * fem, 0 * fem),
                                      width: double.infinity,
                                      height: 20 * fem,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            // rideticketUaL (0:331)
                                            'Ride ticket',
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
                                                3 * fem,
                                                0 * fem,
                                                0 * fem,
                                                0 * fem),
                                            height: double.infinity,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  // ellipse3Kqr (0:333)
                                                  margin: EdgeInsets.fromLTRB(
                                                      0 * fem,
                                                      0 * fem,
                                                      4 * fem,
                                                      0 * fem),
                                                  width: 5.49 * fem,
                                                  height: 5.49 * fem,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.7470855713 * fem),
                                                    color:
                                                        const Color(0xfffdcb5b),
                                                  ),
                                                ),
                                                Text(
                                                  // entryticket3Wx (0:332)
                                                  'Entry ticket',
                                                  style: SafeGoogleFont(
                                                    'Saira',
                                                    fontSize: 10 * ffem,
                                                    fontWeight: FontWeight.w400,
                                                    height: 2 * ffem / fem,
                                                    color:
                                                        const Color(0xffffffff),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                // framenDe (0:334)
                                width: 24 * fem,
                                height: 24 * fem,
                                child: Image.asset(
                                  'assets/page-1/images/frame-MUU.png',
                                  width: 24 * fem,
                                  height: 24 * fem,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // info2WvL (0:311)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, 20 * fem),
                    width: double.infinity,
                    height: 58 * fem,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0x0caaaaaa)),
                      color: const Color(0xff201f1f),
                      borderRadius: BorderRadius.circular(6 * fem),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          // imageRXW (0:313)
                          width: 64.58 * fem,
                          height: 58 * fem,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6 * fem),
                              bottomLeft: Radius.circular(6 * fem),
                            ),
                            child: Image.asset(
                              'assets/page-1/images/image-muz.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          // autogroupio9dk3z (B1LCmtCtHT4BeEuM5Kio9d)
                          padding: EdgeInsets.fromLTRB(
                              10 * fem, 7 * fem, 15 * fem, 7 * fem),
                          height: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // group7554336 (0:314)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 106.42 * fem, 0 * fem),
                                width: 115 * fem,
                                height: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // gasparsgrottoANc (0:315)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 4 * fem),
                                      child: Text(
                                        'Gaspar’s Grotto',
                                        style: SafeGoogleFont(
                                          'Saira',
                                          fontSize: 16 * ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.25 * ffem / fem,
                                          color: const Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // group75534it (0:316)
                                      margin: EdgeInsets.fromLTRB(0 * fem,
                                          0 * fem, 0.51 * fem, 0 * fem),
                                      width: double.infinity,
                                      height: 20 * fem,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            // rideticketPmA (0:317)
                                            'Ride ticket',
                                            style: SafeGoogleFont(
                                              'Saira',
                                              fontSize: 10 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 2 * ffem / fem,
                                              color: const Color(0xffffffff),
                                            ),
                                          ),
                                          Container(
                                            // autogroup54bm8ik (B1LCzTgG8jxGEae7UV54bM)
                                            padding: EdgeInsets.fromLTRB(
                                                3 * fem,
                                                0 * fem,
                                                0 * fem,
                                                0 * fem),
                                            height: double.infinity,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  // ellipse3sgL (0:319)
                                                  margin: EdgeInsets.fromLTRB(
                                                      0 * fem,
                                                      0 * fem,
                                                      4 * fem,
                                                      0 * fem),
                                                  width: 5.49 * fem,
                                                  height: 5.49 * fem,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.7470855713 * fem),
                                                    color:
                                                        const Color(0xfffdcb5b),
                                                  ),
                                                ),
                                                Text(
                                                  // entryticketbsE (0:318)
                                                  'Entry ticket',
                                                  style: SafeGoogleFont(
                                                    'Saira',
                                                    fontSize: 10 * ffem,
                                                    fontWeight: FontWeight.w400,
                                                    height: 2 * ffem / fem,
                                                    color:
                                                        const Color(0xffffffff),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                // framevec (0:320)
                                width: 24 * fem,
                                height: 24 * fem,
                                child: Image.asset(
                                  'assets/page-1/images/frame-cs2.png',
                                  width: 24 * fem,
                                  height: 24 * fem,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // group7557e4p (0:298)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, 20 * fem),
                    width: double.infinity,
                    height: 58 * fem,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0x0caaaaaa)),
                      color: const Color(0xff201f1f),
                      borderRadius: BorderRadius.circular(6 * fem),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          // imagewJp (0:300)
                          width: 64.58 * fem,
                          height: 58 * fem,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6 * fem),
                              bottomLeft: Radius.circular(6 * fem),
                            ),
                            child: Image.asset(
                              'assets/page-1/images/image.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          // autogroupppthfVi (B1LC94vtrd8TPm692ppPTH)
                          padding: EdgeInsets.fromLTRB(
                              10 * fem, 7 * fem, 15 * fem, 7 * fem),
                          height: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // group7554PRi (0:302)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 106.93 * fem, 0 * fem),
                                width: 114.49 * fem,
                                height: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      // thekennedy7sW (0:303)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 4 * fem),
                                      child: Text(
                                        'The Kennedy',
                                        style: SafeGoogleFont(
                                          'Saira',
                                          fontSize: 16 * ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.25 * ffem / fem,
                                          color: const Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      // group7553cZN (0:304)
                                      width: double.infinity,
                                      height: 20 * fem,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            // rideticketN2k (0:305)
                                            'Ride ticket',
                                            style: SafeGoogleFont(
                                              'Saira',
                                              fontSize: 10 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 2 * ffem / fem,
                                              color: const Color(0xffffffff),
                                            ),
                                          ),
                                          Container(
                                            // autogroupneio6zL (B1LCPEBy6diWFwnbyKnEio)
                                            padding: EdgeInsets.fromLTRB(
                                                3 * fem,
                                                0 * fem,
                                                0 * fem,
                                                0 * fem),
                                            height: double.infinity,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  // ellipse33Pn (0:307)
                                                  margin: EdgeInsets.fromLTRB(
                                                      0 * fem,
                                                      0 * fem,
                                                      4 * fem,
                                                      0 * fem),
                                                  width: 5.49 * fem,
                                                  height: 5.49 * fem,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.7470855713 * fem),
                                                    color:
                                                        const Color(0xfffdcb5b),
                                                  ),
                                                ),
                                                Text(
                                                  // entryticketmag (0:306)
                                                  'Entry ticket',
                                                  style: SafeGoogleFont(
                                                    'Saira',
                                                    fontSize: 10 * ffem,
                                                    fontWeight: FontWeight.w400,
                                                    height: 2 * ffem / fem,
                                                    color:
                                                        const Color(0xffffffff),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                // frame7Pe (0:308)
                                width: 24 * fem,
                                height: 24 * fem,
                                child: Image.asset(
                                  'assets/page-1/images/frame-uXv.png',
                                  width: 24 * fem,
                                  height: 24 * fem,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // info2ePa (0:285)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, 20 * fem),
                    width: double.infinity,
                    height: 58 * fem,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0x0caaaaaa)),
                      color: const Color(0xff201f1f),
                      borderRadius: BorderRadius.circular(6 * fem),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          // imagew7n (0:287)
                          width: 64.58 * fem,
                          height: 58 * fem,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6 * fem),
                              bottomLeft: Radius.circular(6 * fem),
                            ),
                            child: Image.asset(
                              'assets/page-1/images/image-rwS.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          // autogroupxzxdf3n (B1LBV1BzAuyVF66Y9AXzXd)
                          padding: EdgeInsets.fromLTRB(
                              10 * fem, 7 * fem, 15 * fem, 7 * fem),
                          height: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // group7554awS (0:288)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 106.93 * fem, 0 * fem),
                                width: 114.49 * fem,
                                height: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      // whiskeynorthiXr (0:289)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 4 * fem),
                                      child: Text(
                                        'Whiskey North',
                                        style: SafeGoogleFont(
                                          'Saira',
                                          fontSize: 16 * ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.25 * ffem / fem,
                                          color: const Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      // group7553EWC (0:290)
                                      width: double.infinity,
                                      height: 20 * fem,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            // rideticketBgL (0:291)
                                            'Ride ticket',
                                            style: SafeGoogleFont(
                                              'Saira',
                                              fontSize: 10 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 2 * ffem / fem,
                                              color: const Color(0xffffffff),
                                            ),
                                          ),
                                          Container(
                                            // autogroupurjwjC4 (B1LBiL97aLQiB9LjrDurJw)
                                            padding: EdgeInsets.fromLTRB(
                                                3 * fem,
                                                0 * fem,
                                                0 * fem,
                                                0 * fem),
                                            height: double.infinity,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  // ellipse3R4t (0:293)
                                                  margin: EdgeInsets.fromLTRB(
                                                      0 * fem,
                                                      0 * fem,
                                                      4 * fem,
                                                      0 * fem),
                                                  width: 5.49 * fem,
                                                  height: 5.49 * fem,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.7470855713 * fem),
                                                    color:
                                                        const Color(0xfffdcb5b),
                                                  ),
                                                ),
                                                Text(
                                                  // entryticket9Fn (0:292)
                                                  'Entry ticket',
                                                  style: SafeGoogleFont(
                                                    'Saira',
                                                    fontSize: 10 * ffem,
                                                    fontWeight: FontWeight.w400,
                                                    height: 2 * ffem / fem,
                                                    color:
                                                        const Color(0xffffffff),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                // frameHct (0:294)
                                width: 24 * fem,
                                height: 24 * fem,
                                child: Image.asset(
                                  'assets/page-1/images/frame-HiQ.png',
                                  width: 24 * fem,
                                  height: 24 * fem,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // group7557E2L (0:272)
                    width: double.infinity,
                    height: 58 * fem,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0x0caaaaaa)),
                      color: const Color(0xff201f1f),
                      borderRadius: BorderRadius.circular(6 * fem),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          // image9f6 (0:274)
                          width: 64.58 * fem,
                          height: 58 * fem,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6 * fem),
                              bottomLeft: Radius.circular(6 * fem),
                            ),
                            child: Image.asset(
                              'assets/page-1/images/image-ypU.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          // autogrouplozdGji (B1LApMdiVzWjwXV9nhLoZd)
                          padding: EdgeInsets.fromLTRB(
                              10 * fem, 7 * fem, 15 * fem, 7 * fem),
                          height: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // group7554ZD2 (0:276)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 106.93 * fem, 0 * fem),
                                width: 114.49 * fem,
                                height: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      // clubpranaHep (0:277)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 4 * fem),
                                      child: Text(
                                        'Club Prana',
                                        style: SafeGoogleFont(
                                          'Saira',
                                          fontSize: 16 * ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.25 * ffem / fem,
                                          color: const Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      // group7553QDe (0:278)
                                      width: double.infinity,
                                      height: 20 * fem,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            // rideticketMPn (0:279)
                                            'Ride ticket',
                                            style: SafeGoogleFont(
                                              'Saira',
                                              fontSize: 10 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 2 * ffem / fem,
                                              color: const Color(0xffffffff),
                                            ),
                                          ),
                                          Container(
                                            // autogroupbrxu6MN (B1LB4MEQB5sRctHxt7BrXu)
                                            padding: EdgeInsets.fromLTRB(
                                                3 * fem,
                                                0 * fem,
                                                0 * fem,
                                                0 * fem),
                                            height: double.infinity,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  // ellipse32Vv (0:281)
                                                  margin: EdgeInsets.fromLTRB(
                                                      0 * fem,
                                                      0 * fem,
                                                      4 * fem,
                                                      0 * fem),
                                                  width: 5.49 * fem,
                                                  height: 5.49 * fem,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.7470855713 * fem),
                                                    color:
                                                        const Color(0xfffdcb5b),
                                                  ),
                                                ),
                                                Text(
                                                  // entryticketkRv (0:280)
                                                  'Entry ticket',
                                                  style: SafeGoogleFont(
                                                    'Saira',
                                                    fontSize: 10 * ffem,
                                                    fontWeight: FontWeight.w400,
                                                    height: 2 * ffem / fem,
                                                    color:
                                                        const Color(0xffffffff),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                // framehMA (0:282)
                                width: 24 * fem,
                                height: 24 * fem,
                                child: Image.asset(
                                  'assets/page-1/images/frame-Wgx.png',
                                  width: 24 * fem,
                                  height: 24 * fem,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              // navbarCoi (1:120)
              width: double.infinity,
              height: 74 * fem,
              child: Stack(
                children: [
                  Positioned(
                    // group809yr (1:121)
                    left: 0 * fem,
                    top: 0 * fem,
                    child: Container(
                      width: 375 * fem,
                      height: 74 * fem,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            'assets/page-1/images/bg-nav-WAL.png',
                          ),
                        ),
                      ),
                      child: Align(
                        // bgnavsex (1:123)
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          width: 375 * fem,
                          height: 0.78 * fem,
                          child: Image.asset(
                            'assets/page-1/images/bg-nav-HXW.png',
                            width: 375 * fem,
                            height: 0.78 * fem,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    // group7681oYc (1:124)
                    left: 20 * fem,
                    top: 0 * fem,
                    child: SizedBox(
                      width: 335 * fem,
                      height: 61.39 * fem,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            // group76807pC (1:125)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 104.38 * fem, 0.38 * fem),
                            width: 39 * fem,
                            height: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // group782gG (1:126)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 3.5 * fem),
                                  width: 39 * fem,
                                  height: 12 * fem,
                                  child: Image.asset(
                                    'assets/page-1/images/group-78-xJL.png',
                                    width: 39 * fem,
                                    height: 12 * fem,
                                  ),
                                ),
                                Container(
                                  // group79Lgx (1:129)
                                  margin: EdgeInsets.fromLTRB(
                                      3 * fem, 0 * fem, 3 * fem, 0 * fem),
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // vuesaxbulkhome2UoA (1:130)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 0 * fem, 2.51 * fem),
                                        width: 24 * fem,
                                        height: 24 * fem,
                                        child: Image.asset(
                                          'assets/page-1/images/vuesax-bulk-home-2-qkk.png',
                                          width: 24 * fem,
                                          height: 24 * fem,
                                        ),
                                      ),
                                      Text(
                                        // homePQL (1:136)
                                        'HOME',
                                        textAlign: TextAlign.center,
                                        style: SafeGoogleFont(
                                          'Saira',
                                          fontSize: 12 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.575 * ffem / fem,
                                          color: const Color(0xfffdcb5b),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // group74v9N (1:137)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 115.62 * fem, 0.14 * fem),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // vuesaxlinearticketTQC (1:138)
                                  margin: EdgeInsets.fromLTRB(
                                      0.24 * fem, 0 * fem, 0 * fem, 3.25 * fem),
                                  width: 24 * fem,
                                  height: 24 * fem,
                                  child: Image.asset(
                                    'assets/page-1/images/vuesax-linear-ticket-FLc.png',
                                    width: 24 * fem,
                                    height: 24 * fem,
                                  ),
                                ),
                                Text(
                                  // ticketsMEg (1:139)
                                  'Tickets',
                                  style: SafeGoogleFont(
                                    'Saira',
                                    fontSize: 12 * ffem,
                                    fontWeight: FontWeight.w500,
                                    height: 1.575 * ffem / fem,
                                    color: const Color(0x5bffffff),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // group7679gnk (1:140)
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // vuesaxoutlineframeF5A (1:142)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 3.28 * fem),
                                  width: 24 * fem,
                                  height: 24 * fem,
                                  child: Image.asset(
                                    'assets/page-1/images/vuesax-outline-frame-qh2.png',
                                    width: 24 * fem,
                                    height: 24 * fem,
                                  ),
                                ),
                                Text(
                                  // profilexVN (1:141)
                                  'Profile',
                                  style: SafeGoogleFont(
                                    'Saira',
                                    fontSize: 12 * ffem,
                                    fontWeight: FontWeight.w500,
                                    height: 1.575 * ffem / fem,
                                    color: const Color(0x5bffffff),
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
          ],
        ),
      ),
    ));
  }
}
