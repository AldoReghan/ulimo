import 'package:flutter/cupertino.dart';
import 'package:ulimo/widget/ticket_active_item.dart';
import 'package:ulimo/widget/ticket_pending_item.dart';

class ActiveTicket extends StatefulWidget {
  final double fem;
  final double ffem;

  const ActiveTicket({Key? key, required this.fem, required this.ffem})
      : super(key: key);

  @override
  State<ActiveTicket> createState() => _ActiveTicketState();
}

class _ActiveTicketState extends State<ActiveTicket> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, index) {
          return ticketActiveItem(fem: widget.fem, ffem: widget.ffem);
        });
  }
}
