import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ulimo/base/base_color.dart';

import '../base/utils.dart';

class MyTicketButton extends StatefulWidget {
  final List<String> labels;
  final List<int> count;
  final Function(int) onTap;
  final double fem;
  final double ffem;
  final int selectedIndex;

  const MyTicketButton({Key? key,
    required this.fem,
    required this.ffem,
    required this.labels,
    required this.count,
    required this.selectedIndex,
    required this.onTap,
  })
      : super(key: key);

  @override
  State<MyTicketButton> createState() => _MyTicketButtonState();
}

class _MyTicketButtonState extends State<MyTicketButton> {

  @override
  Widget build(BuildContext context) {
    return Container(
      // categoriesCF2 (0:710)
      margin: EdgeInsets.fromLTRB(
          0 * widget.fem, 0 * widget.fem, 0 * widget.fem, 24 * widget.fem),
      width: double.infinity,
      height: 40 * widget.fem,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(widget.labels.length, (index) {
            return TextButton(
              onPressed: () {
                widget.onTap.call(index);
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              child: Container(
                width: 105.27 * widget.fem,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: widget.selectedIndex == index
                      ? yellowPrimary
                      : const Color(0xff2c2b2b),
                  borderRadius: BorderRadius.circular(6 * widget.fem),
                ),
                child: SizedBox(
                  width: 84 * widget.fem,
                  height: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: DottedBorder(
                          borderType: BorderType.Circle,
                          color: widget.selectedIndex == index
                              ? Colors.black
                              : const Color(0xa5aaaaaa),
                          child: SizedBox(
                            // group7563Qfr (0:728)
                            width: 28 * widget.fem,
                            height: double.infinity,
                            child: Center(
                              child: Text(
                                widget.count[index].toString(),
                                textAlign: TextAlign.center,
                                style: SafeGoogleFont(
                                  'Saira',
                                  fontSize: 14 * widget.ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.575 * widget.ffem / widget.fem,
                                  color: widget.selectedIndex == index
                                      ? Colors.black
                                      : const Color(0xa5aaaaaa),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0 * widget.fem,
                            1 * widget.fem, 0 * widget.fem, 0 * widget.fem),
                        child: Text(
                          widget.labels[index],
                          style: SafeGoogleFont(
                            'Saira',
                            fontSize: 14 * widget.ffem,
                            fontWeight: FontWeight.w500,
                            height: 1.575 * widget.ffem / widget.fem,
                            color: widget.selectedIndex == index
                                ? Colors.black
                                : const Color(0xa5aaaaaa),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          })),
    );
  }
}
