import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ulimo/base/base_background_scaffold.dart';
import 'package:ulimo/widget/my_ticket_button.dart';

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
            MyTicketButton(
                fem: fem,
                ffem: ffem,
                labels: const ["Active", "Pending", "Expired"],
                count: const [0, 1, 0],
                onTap: (index) {})
          ],
        ),
      )),
    ));
  }
}
