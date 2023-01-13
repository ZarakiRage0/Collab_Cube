import 'package:collab_cube/reservation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReservationListPage extends StatefulWidget {
  final List<Reservation> reservations;

  ReservationListPage({required this.reservations});

  @override
  _ReservationListPageState createState() => _ReservationListPageState();
}

class _ReservationListPageState extends State<ReservationListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des réservations"),
        backgroundColor: Color(0xFF8EAFA1),
      ),
      body: ListView.builder(
        itemCount: widget.reservations.length,
        itemBuilder: (context, index) {
          Reservation reservation = widget.reservations[index];
          return ListTile(
            title: Text("@ ${reservation.building.adress}"),
            subtitle: Text("Début: ${reformatDate(reservation.dateStart)} \nFin: ${reformatDate(reservation.dateStart)}"),
            trailing: Text("Places: ${reservation.place}"),
          );
        },
      ),
    );
  }
}

String reformatDate(String date) {
  DateTime parsedDate = DateTime.parse(date);
  return DateFormat('dd/MM/yyyy HH:mm').format(parsedDate);
}
