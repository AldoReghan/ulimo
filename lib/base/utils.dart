import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

TextStyle SafeGoogleFont(
  String fontFamily, {
  TextStyle? textStyle,
  Color? color,
  Color? backgroundColor,
  double? fontSize,
  FontWeight? fontWeight,
  FontStyle? fontStyle,
  double? letterSpacing,
  double? wordSpacing,
  TextBaseline? textBaseline,
  double? height,
  Locale? locale,
  Paint? foreground,
  Paint? background,
  List<Shadow>? shadows,
  List<FontFeature>? fontFeatures,
  TextDecoration? decoration,
  Color? decorationColor,
  TextDecorationStyle? decorationStyle,
  double? decorationThickness,
}) {
  try {
    return GoogleFonts.getFont(
      fontFamily,
      textStyle: textStyle,
      color: color,
      backgroundColor: backgroundColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      locale: locale,
      foreground: foreground,
      background: background,
      shadows: shadows,
      fontFeatures: fontFeatures,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );
  } catch (ex) {
    return GoogleFonts.getFont(
      "Source Sans Pro",
      textStyle: textStyle,
      color: color,
      backgroundColor: backgroundColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      locale: locale,
      foreground: foreground,
      background: background,
      shadows: shadows,
      fontFeatures: fontFeatures,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );
  }
}



// Container(
// // info3HeQ (0:1161)
// margin: EdgeInsets.fromLTRB(
// 19.94 * fem, 0 * fem, 20.17 * fem, 42.82 * fem),
// width: double.infinity,
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Container(
// // wherewillyouliketogop8Y (0:1162)
// margin: EdgeInsets.fromLTRB(
// 0 * fem, 0 * fem, 0 * fem, 9 * fem),
// child: Text(
// 'When will you go?',
// style: SafeGoogleFont(
// 'Saira',
// fontSize: 16 * ffem,
// fontWeight: FontWeight.w500,
// height: 1.575 * ffem / fem,
// color: const Color(0xffffffff),
// ),
// ),
// ),
// SizedBox(
// // group7540L6t (0:1163)
// width: double.infinity,
// height: 46 * fem,
// child: Flexible(
// child: DottedBorder(
// borderType: BorderType.RRect,
// radius: const Radius.circular(6),
// color: const Color(0xFFFDCB5B),
// strokeWidth: 1,
// child: SizedBox(
// height: double.infinity,
// child: SizedBox(
// // group7535hLk (0:1167)
// width: double.infinity,
// height: double.infinity,
// child: Padding(
// padding:
// const EdgeInsets.symmetric(horizontal: 15),
// child: Row(
// crossAxisAlignment: CrossAxisAlignment.center,
// mainAxisAlignment:
// MainAxisAlignment.spaceBetween,
// children: [
// GestureDetector(
// onTap: () => _selectDate(context),
// child: Text(
// DateFormat('dd MMM yyyy').format(_date),
// style: SafeGoogleFont(
// 'Saira',
// fontSize: 14 * ffem,
// fontWeight: FontWeight.w500,
// height: 1.4285714286 * ffem / fem,
// color: const Color(0xfffdcb5b),
// ),
// ),
// ),
// Icon(
// Icons.keyboard_arrow_down,
// size: 20 * fem,
// color: Colors.white,
// ),
// ],
// ),
// ),
// ),
// ),
// ),
// ),
// ),
// ],
// ),
// ),