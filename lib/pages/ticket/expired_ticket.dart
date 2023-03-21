import 'package:flutter/cupertino.dart';
import 'package:ulimo/widget/ticket_active_item.dart';
import 'package:ulimo/widget/ticket_expired_item.dart';
import 'package:ulimo/widget/ticket_pending_item.dart';

class ExpiredTicket extends StatefulWidget {
  final double fem;
  final double ffem;

  const ExpiredTicket({Key? key, required this.fem, required this.ffem})
      : super(key: key);

  @override
  State<ExpiredTicket> createState() => _ExpiredTicketState();
}

class _ExpiredTicketState extends State<ExpiredTicket> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, index) {
          return ticketExpiredItem(fem: widget.fem, ffem: widget.ffem);
        });
  }
}
