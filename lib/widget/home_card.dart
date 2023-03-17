import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../base/base_color.dart';

Widget homeCard(
    {required String title,
    required String subtitle,
    required String imageAsset,
    required Function onTap}) {
  return Material(
    borderRadius: BorderRadius.circular(6),
    color: darkPrimary,
    child: InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: (){
        onTap.call();
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.transparent, borderRadius: BorderRadius.circular(6)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.asset(imageAsset),
                  )),
              const SizedBox(width: 10),
              Expanded(
                  flex: 8,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          subtitle,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.65), fontSize: 12),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(width: 10),
              const Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 16,
                  ))
            ],
          ),
        ),
      ),
    ),
  );
}
