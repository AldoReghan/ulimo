import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ulimo/widget/ticket_active_item.dart';
import 'package:ulimo/widget/ticket_pending_item.dart';

class PendingTicket extends StatefulWidget {
  final double fem;
  final double ffem;
  final List pendingData;

  const PendingTicket({Key? key, required this.fem, required this.ffem, required this.pendingData})
      : super(key: key);

  @override
  State<PendingTicket> createState() => _PendingTicketState();
}

class _PendingTicketState extends State<PendingTicket> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: widget.pendingData.length,
            itemBuilder: (context, index) {
              return ticketPendingItem(
                  fem: widget.fem,
                  ffem: widget.ffem,
                  address: widget.pendingData[index]['address'],
                  date: widget.pendingData[index]['date'],
                  time: widget.pendingData[index]['time'],
                  status: widget.pendingData[index]['status'],
                  price: widget.pendingData[index]['price'],
                  onTap: () {});
            });
    ;
  }
}
