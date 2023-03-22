import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ulimo/base/base_background_scaffold.dart';
import 'package:ulimo/base/base_color.dart';
import 'package:ulimo/pages/profile/edit_profile_page.dart';
import 'package:ulimo/pages/profile/notification_page.dart';

import '../../base/utils.dart';
import '../../widget/profile_menu.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize text controllers with default values here, if needed.
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return defaultBackgroundScaffold(
        scaffold: Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 50),
              Container(
                // group7560aeL (0:603)
                margin: EdgeInsets.fromLTRB(
                    20.4 * fem, 0 * fem, 0 * fem, 0.1 * fem),
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
                      'My Profile',
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
              Expanded(
                child: Container(
                  // autogroupeqgtgYx (B1LFznqT5Bc34g7UgKEQgT)
                  padding: EdgeInsets.fromLTRB(
                      19.6 * fem, 36 * fem, 20 * fem, 30.21 * fem),
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // cardwtC (0:493)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0.4 * fem, 46 * fem),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // group7586TLk (0:494)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 4 * fem),
                                width: double.infinity,
                                height: 95 * fem,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      // group7585BnY (0:495)
                                      left: 0 * fem,
                                      top: 0 * fem,
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(0 * fem,
                                            94.55 * fem, 0 * fem, 0 * fem),
                                        width: 335 * fem,
                                        height: 95 * fem,
                                        decoration: BoxDecoration(
                                          color: const Color(0xa52b2b2b),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(6 * fem),
                                            topRight: Radius.circular(6 * fem),
                                          ),
                                        ),
                                        child: Align(
                                          // rectangle3sfN (0:497)
                                          alignment: Alignment.bottomCenter,
                                          child: SizedBox(
                                              width: 335 * fem,
                                              height: 0.44 * fem),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      // group7584CBr (0:498)
                                      left: 5.1176757812 * fem,
                                      top: 4.7908935547 * fem,
                                      child: SizedBox(
                                        width: 228.23 * fem,
                                        height: 85.42 * fem,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // rectangle2iR6 (0:499)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  10 * fem,
                                                  0 * fem),
                                              width: 84.23 * fem,
                                              height: 85.42 * fem,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        6 * fem),
                                                color: const Color(0xff6e6e6e),
                                              ),
                                              child: Image.network(
                                                  "https://cdn3d.iconscout.com/"
                                                  "3d/premium/thumb/male-"
                                                  "customer-call-service-"
                                                  "portrait-6760890-"
                                                  "5600697.png?f=webp"),
                                            ),
                                            Container(
                                              // group7578oBe (0:500)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  2.21 * fem,
                                                  0 * fem,
                                                  2.21 * fem),
                                              width: 134 * fem,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        2 * fem),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    // group75767y2 (0:501)
                                                    margin: EdgeInsets.fromLTRB(
                                                        0 * fem,
                                                        0 * fem,
                                                        0 * fem,
                                                        10 * fem),
                                                    width: double.infinity,
                                                    height: 47 * fem,
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          // danielbdaltonT1J (0:502)
                                                          left: 0 * fem,
                                                          top: 0 * fem,
                                                          child: Align(
                                                            child: SizedBox(
                                                              width: 134 * fem,
                                                              height: 29 * fem,
                                                              child: Text(
                                                                'Daniel B. Dalton',
                                                                style:
                                                                    SafeGoogleFont(
                                                                  'Saira',
                                                                  fontSize:
                                                                      18 * ffem,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  height:
                                                                      1.575 *
                                                                          ffem /
                                                                          fem,
                                                                  color: const Color(
                                                                      0xffffffff),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          // Y2k (0:503)
                                                          left: 0 * fem,
                                                          top: 28 * fem,
                                                          child: Align(
                                                            child: SizedBox(
                                                              width: 114 * fem,
                                                              height: 19 * fem,
                                                              child: Text(
                                                                '+1 (045) 0000 0025',
                                                                style:
                                                                    SafeGoogleFont(
                                                                  'Saira',
                                                                  fontSize:
                                                                      12 * ffem,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  height:
                                                                      1.575 *
                                                                          ffem /
                                                                          fem,
                                                                  color: const Color(
                                                                      0xa5aaaaaa),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      //do something when edit profile clicked
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const EditProfilePage()));
                                                    },
                                                    child: Container(
                                                      width: 68.46 * fem,
                                                      height: 24 * fem,
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                            0x0cfdcb5b),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    2 * fem),
                                                      ),
                                                      child: DottedBorder(
                                                        color: yellowPrimary,
                                                        borderType:
                                                            BorderType.RRect,
                                                        radius: const Radius
                                                            .circular(6),
                                                        child: Center(
                                                          child: Text(
                                                            'Edit profile',
                                                            style:
                                                                SafeGoogleFont(
                                                              'Saira',
                                                              fontSize:
                                                                  10 * ffem,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              height: 1.575 *
                                                                  ffem /
                                                                  fem,
                                                              color: const Color(
                                                                  0xfffdcb5b),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
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
                              SizedBox(
                                // group75835gt (0:507)
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        // rectangle4SXS (0:508)
                                        width: 335 * fem,
                                        height: 0.44 * fem),
                                    Container(
                                      // group7582BE8 (0:509)
                                      padding: EdgeInsets.fromLTRB(143.5 * fem,
                                          7.62 * fem, 143.5 * fem, 7.62 * fem),
                                      width: double.infinity,
                                      height: 53.24 * fem,
                                      decoration: BoxDecoration(
                                        color: const Color(0xa52b2b2b),
                                        borderRadius: BorderRadius.only(
                                          bottomRight:
                                              Radius.circular(65 * fem),
                                          bottomLeft: Radius.circular(65 * fem),
                                        ),
                                      ),
                                      child: SizedBox(
                                        // group7580Hnx (0:512)
                                        width: double.infinity,
                                        height: double.infinity,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              // drp (0:513)
                                              left: 18.5 * fem,
                                              top: 0 * fem,
                                              child: Align(
                                                child: SizedBox(
                                                  width: 11 * fem,
                                                  height: 26 * fem,
                                                  child: Text(
                                                    '0',
                                                    style: SafeGoogleFont(
                                                      'Saira',
                                                      fontSize: 16 * ffem,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height:
                                                          1.575 * ffem / fem,
                                                      color: const Color(
                                                          0xffffffff),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              // ticketsKje (0:514)
                                              left: 0 * fem,
                                              top: 19 * fem,
                                              child: Align(
                                                child: SizedBox(
                                                  width: 48 * fem,
                                                  height: 19 * fem,
                                                  child: Text(
                                                    'TICKETS',
                                                    style: SafeGoogleFont(
                                                      'Saira',
                                                      fontSize: 12 * ffem,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height:
                                                          1.575 * ffem / fem,
                                                      color: const Color(
                                                          0xffaaaaaa),
                                                    ),
                                                  ),
                                                ),
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
                        Container(
                          // menuBWx (0:515)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 14 * fem),
                          child: Text(
                            'Menu',
                            style: SafeGoogleFont(
                              'Saira',
                              fontSize: 18 * ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.575 * ffem / fem,
                              color: const Color(0xffffffff),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const NotificationPage()));
                          },
                          child: Container(
                            // info179i (0:516)
                            margin: EdgeInsets.fromLTRB(
                                0.4 * fem, 0 * fem, 0 * fem, 20 * fem),
                            padding: EdgeInsets.fromLTRB(
                                11.4 * fem, 12.08 * fem, 10.6 * fem, 12.08 * fem),
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
                              // group7596yBv (0:518)
                              width: double.infinity,
                              height: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // autogroupm88bKma (B1LGnSC4aek8Cv8GaVM88b)
                                    padding: EdgeInsets.fromLTRB(0 * fem,
                                        0.92 * fem, 134.45 * fem, 0.92 * fem),
                                    height: double.infinity,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                            // frameEde (0:526)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 8 * fem, 0 * fem),
                                            width: 24 * fem,
                                            height: 24 * fem,
                                            child: SvgPicture.asset(
                                                "assets/icon/profile_notification.svg")),
                                        Text(
                                          // notifications9kc (0:519)
                                          'Notifications',
                                          style: SafeGoogleFont(
                                            'Saira',
                                            fontSize: 14 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.4285714286 * ffem / fem,
                                            color: const Color(0xffaaaaaa),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // group7588UXz (0:520)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 10 * fem, 0 * fem),
                                    width: 29.55 * fem,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xa5aaaaaa)),
                                      color: const Color(0x0cd4af34),
                                      borderRadius:
                                          BorderRadius.circular(7 * fem),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '0',
                                        style: SafeGoogleFont(
                                          'Saira',
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w600,
                                          height: 1.4285714286 * ffem / fem,
                                          color: const Color(0xa5aaaaaa),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.keyboard_arrow_right,
                                    size: 24,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        profileMenu(
                            context: context,
                            title: 'Setting',
                            iconAsset: "assets/icon/profile_setting.svg",
                            onTap: () {
                              // do something
                            }),
                        profileMenu(
                            context: context,
                            title: 'Instagram',
                            iconAsset: "assets/icon/profile_instagram.svg",
                            onTap: () {
                              // do something
                            }),
                        profileMenu(
                            context: context,
                            title: 'Invite a friend',
                            iconAsset: "assets/icon/profile_invite.svg",
                            onTap: () {
                              // do something
                            }),
                        profileMenu(
                            context: context,
                            title: 'More info',
                            iconAsset: "assets/icon/profile_info.svg",
                            onTap: () {
                              // do something
                            }),
                        Container(
                          // logoutbutton8tg (0:559)
                          margin: EdgeInsets.fromLTRB(
                              0.4 * fem, 0 * fem, 0 * fem, 0 * fem),
                          width: double.infinity,
                          height: 50 * fem,
                          decoration: BoxDecoration(
                            color: const Color(0xff3586ff),
                            borderRadius: BorderRadius.circular(5 * fem),
                          ),
                          child: Center(
                            child: Text(
                              'Log Out',
                              style: SafeGoogleFont(
                                'Saira',
                                fontSize: 20 * ffem,
                                fontWeight: FontWeight.w500,
                                height: 1.575 * ffem / fem,
                                color: const Color(0xffffffff),
                              ),
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
      ),
    ));
  }
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: const Text('Profile'),
//     ),
//     body: Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const CircleAvatar(
//             radius: 50,
//             child: Icon(
//               Icons.person,
//               size: 50,
//             ),
//           ),
//           const SizedBox(height: 16),
//           TextField(
//             controller: _nameController,
//             decoration: const InputDecoration(
//               labelText: 'Name',
//               hintText: 'Enter your name',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           const SizedBox(height: 16),
//           TextField(
//             controller: _phoneNumberController,
//             keyboardType: TextInputType.phone,
//             decoration: const InputDecoration(
//               labelText: 'Phone Number',
//               hintText: 'Enter your phone number',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           const SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: () {
//               // Perform save operation here, e.g. update user profile data
//               // with new values from text controllers.
//               print('Name: ${_nameController.text}');
//               print('Phone number: ${_phoneNumberController.text}');
//             },
//             child: const Text('Save'),
//           ),
//         ],
//       ),
//     ),
//   );
// }
}