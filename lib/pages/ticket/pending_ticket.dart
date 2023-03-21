import 'package:flutter/cupertino.dart';
import 'package:ulimo/widget/ticket_active_item.dart';
import 'package:ulimo/widget/ticket_pending_item.dart';

class PendingTicket extends StatefulWidget {
  final double fem;
  final double ffem;

  const PendingTicket({Key? key, required this.fem, required this.ffem})
      : super(key: key);

  @override
  State<PendingTicket> createState() => _PendingTicketState();
}

class _PendingTicketState extends State<PendingTicket> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, index) {
          return ticketPendingItem(fem: widget.fem, ffem: widget.ffem);
        });
  }
}
