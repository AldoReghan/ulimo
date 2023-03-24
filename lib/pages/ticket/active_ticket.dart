import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ulimo/widget/ticket_active_item.dart';
import 'package:ulimo/widget/ticket_pending_item.dart';

class ActiveTicket extends StatefulWidget {
  final double fem;
  final double ffem;
  final List activeTicketData;

  const ActiveTicket({Key? key, required this.fem, required this.ffem, required this.activeTicketData})
      : super(key: key);

  @override
  State<ActiveTicket> createState() => _ActiveTicketState();
}

class _ActiveTicketState extends State<ActiveTicket> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: widget.activeTicketData.length,
            itemBuilder: (context, index) {
              return ticketActiveItem(
                fem: widget.fem,
                ffem: widget.ffem,
                address: widget.activeTicketData[index]['address'],
                date: widget.activeTicketData[index]['date'],
                time: widget.activeTicketData[index]['time'],
                status: widget.activeTicketData[index]['status'],
                rideName: widget.activeTicketData[index]['name'],
              );
            });
  }
}
