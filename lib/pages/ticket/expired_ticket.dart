import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ulimo/widget/ticket_active_item.dart';
import 'package:ulimo/widget/ticket_expired_item.dart';
import 'package:ulimo/widget/ticket_pending_item.dart';

class ExpiredTicket extends StatefulWidget {
  final double fem;
  final double ffem;
  final List expiredData;

  const ExpiredTicket({Key? key, required this.fem, required this.ffem, required this.expiredData})
      : super(key: key);

  @override
  State<ExpiredTicket> createState() => _ExpiredTicketState();
}

class _ExpiredTicketState extends State<ExpiredTicket> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: widget.expiredData.length,
            itemBuilder: (context, index) {
              return ticketExpiredItem(
                  fem: widget.fem,
                  ffem: widget.ffem,
                  address: widget.expiredData[index]['address'],
                  date: widget.expiredData[index]['date'],
                  time: widget.expiredData[index]['time'],
                  status: widget.expiredData[index]['status'],
                  rideName: widget.expiredData[index]['name']);
            });
  }
}
