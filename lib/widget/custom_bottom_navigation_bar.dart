import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ulimo/base/base_color.dart';
import 'package:ulimo/base/utils.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final List<String> labels;
  final List<String> icons;
  final List<String> selectedIcons;
  final Function(int) onTap;

  CustomBottomNavigationBar({required this.icons,
    required this.onTap,
    required this.labels,
    required this.selectedIcons});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;




  Widget changeIconSelected(int index, String icons, String selectedIcon) {
    if (_selectedIndex == index) {
      return SvgPicture.asset(
          selectedIcon);
    } else {
      return SvgPicture.asset(
          icons);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.085,
      child: Container(
        height: double.infinity,
        decoration: const BoxDecoration(color: darkPrimary),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(widget.icons.length, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
                widget.onTap.call(index);
              },
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      changeIconSelected(index, widget.icons[index],
                          widget.selectedIcons[index]),
                      Text(
                        widget.labels[index],
                        style: SafeGoogleFont(
                          'Saira',
                          fontSize: 12,
                          color: _selectedIndex == index
                              ? yellowPrimary
                              : Colors.grey,
                        ),
                      )
                    ],
                  ),
                  if (_selectedIndex == index)
                    Positioned(
                        top: 0,
                        child: SvgPicture.asset(
                            'assets/icon/bottom_navigation_indicator.svg')),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
