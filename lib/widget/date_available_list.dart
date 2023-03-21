import 'package:flutter/cupertino.dart';
import 'package:ulimo/widget/date_available_item.dart';

class DateAvailableList extends StatefulWidget {
  final double fem;
  final double ffem;
  final Function(int) onTap;

  const DateAvailableList(
      {Key? key, required this.fem, required this.ffem, required this.onTap})
      : super(key: key);

  @override
  State<DateAvailableList> createState() => _DateAvailableListState();
}

class _DateAvailableListState extends State<DateAvailableList> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: List.generate(10, (index) {
          return dateAvailableItem(
              fem: widget.fem,
              ffem: widget.ffem,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
                widget.onTap.call(index);
              },
              selectedIndex: _selectedIndex,
              index: index);
        }),
      ),
    );
  }
}
