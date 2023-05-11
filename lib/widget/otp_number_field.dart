import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ulimo/base/base_color.dart';

import '../base/utils.dart';

Widget otpNumberField(BuildContext context, TextEditingController controller,
    Color statusColor, FocusNode focusNode, Function() onChanged,
    {String code = '',
    isFirst = false,
    Function(String) onPasteCode = onPasteCodeDefault}) {
  focusNode.addListener(() {
    if (focusNode.hasFocus) {
      // TextField has focus
    }
  });

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
          onTapOutside: (pointerDown) {
            focusNode.unfocus();
          },
          onTap: () {
            controller.selection = TextSelection.fromPosition(
              TextPosition(offset: controller.text.length),
            );
          },
          focusNode: focusNode,
          onChanged: (String value) {
            if (value.isNotEmpty) {
              if (value.length == 1) {
                onChanged.call();
              } else if (value.length > 1) {
                if (value.length == 6) {
                  //paste detected
                  controller.text = value[0];
                  onPasteCode.call(value);
                  focusNode.unfocus();
                } else {
                  controller.value = TextEditingValue(
                    text: value.substring(value.length - 1),
                    selection: TextSelection.fromPosition(
                      const TextPosition(offset: 1),
                    ),
                  );
                  onChanged.call();
                }
              }
            } else {
              focusNode.previousFocus();
            }
          },
          // showCursor: false,
          style: SafeGoogleFont(
            'Gilroy',
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: const Color(0xffffffff),
          ),
          decoration: InputDecoration(
              hintText: '0',
              counterText: '',
              hintStyle: SafeGoogleFont('Gilroy',
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xffffffff).withOpacity(0.5)),
              filled: true,
              fillColor: Colors.transparent,
              focusColor: Colors.transparent,
              focusedBorder: InputBorder.none),
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

void onPasteCodeDefault(String code) {}
