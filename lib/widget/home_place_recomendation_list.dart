import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../base/base_color.dart';

Widget recomendationListLayout(BuildContext context) {
  return Material(
    borderRadius: BorderRadius.circular(10),
    color: darkPrimary,
    child: InkWell(
      onTap: () {
        //do something
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: Colors.transparent,
        height: double.infinity,
        width: MediaQuery.of(context).size.width / 2.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 15 / 16,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: Image.network(
                  "https://store-images.s-microsoft.com/image/"
                  "apps.47288.14188059920471079.8845931d-"
                  "936f-4c5b-848c-e9700ef87a6b.92da2b6e-01a3-"
                  "4806-8575-6f6278ecd71b?q=90&w=480&h=270",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 9),
            const Padding(
              padding: EdgeInsets.only(left: 8.0, right: 8.0),
              child: Flexible(
                child: Text(
                  "HYDE PARK CAFE",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                children: [
                  SvgPicture.asset("assets/icon/location.svg"),
                  const SizedBox(
                    width: 4,
                  ),
                  const Flexible(
                    child: Text(
                      maxLines: 3,
                      "Address is hereAddress is hereAddress is hereAddress is hereAddress is here",
                      style: TextStyle(color: Color(0xFF3586FF), fontSize: 10),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
