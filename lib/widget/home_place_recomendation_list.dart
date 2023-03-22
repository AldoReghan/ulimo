import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../base/base_color.dart';

Widget recomendationListLayout(BuildContext context,
    {required String name,
    required String address,
    required String imageUrl,
    required Function() onTap}) {
  return Material(
    borderRadius: BorderRadius.circular(10),
    color: darkPrimary,
    child: InkWell(
      onTap: () {
        //do something
        onTap.call();
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: Colors.transparent,
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
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 9),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(
                  name,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/icon/location.svg"),
                      const SizedBox(
                        width: 4,
                      ),
                      Flexible(
                        child: Text(
                          maxLines: 3,
                          address,
                          style: const TextStyle(
                              color: Color(0xFF3586FF), fontSize: 10),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
