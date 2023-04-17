import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ulimo/base/base_color.dart';

import '../base/utils.dart';

Widget otpNumberField(BuildContext context, TextEditingController controller, Color statusColor ,
    FocusNode focusNode, Function() onChanged) {
  return Flexible(
    child: DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(6),
      color: statusColor,
      strokeWidth: 1,
      child: Center(
        child: TextField(
          textAlign: TextAlign.center,
          controller: controller,
          keyboardType: TextInputType.number,
          focusNode: focusNode,
          onChanged: (String value) {
            if (value.length == 1) {
              onChanged.call();
            }
          },
          showCursor: false,
          style: SafeGoogleFont(
            'Gilroy',
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: const Color(0xffffffff),
          ),
          decoration: InputDecoration(
            hintText: '0',
            hintStyle: SafeGoogleFont('Gilroy',
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: const Color(0xffffffff).withOpacity(0.5)),
              filled: true,
              fillColor: Colors.transparent,
              focusColor: Colors.transparent,
              focusedBorder: InputBorder.none
          ),
        ),
        // child: Text(
        //   '2',
        //   style: SafeGoogleFont(
        //     'Gilroy',
        //     fontSize: 26,
        //     fontWeight: FontWeight.w800,
        //     color: const Color(0xffffffff),
        //   ),
        // ),
      ),
    ),
  );
}
