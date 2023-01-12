import 'building.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Reservation {
  late int idReservation;
  late String dateStart;
  late String dateEnd;
  late int place;
  late Enterprise enterprise;
  late Building building;

  Reservation(
      {required this.idReservation,
        required this.dateStart,
        required this.dateEnd,
        required this.place,
        required this.enterprise,
        required this.building});

  Reservation.fromJson(Map<String, dynamic> json) {
    idReservation = json['idReservation'];
    dateStart = json['dateStart'];
    dateEnd = json['dateEnd'];
    place = json['place'];
    enterprise = (json['enterprise'] != null
        ? new Enterprise.fromJson(json['enterprise'])
        : null)!;
    building = (json['building'] != null
        ? new Building.fromJson(json['building'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idReservation'] = this.idReservation;
    data['dateStart'] = this.dateStart;
    data['dateEnd'] = this.dateEnd;
    data['place'] = this.place;
    if (this.enterprise != null) {
      data['enterprise'] = this.enterprise.toJson();
    }
    if (this.building != null) {
      data['building'] = this.building.toJson();
    }
    return data;
  }
}

class Enterprise {
  late int idEnterprise;
  late String name;

  Enterprise({required this.idEnterprise, required this.name});

  Enterprise.fromJson(Map<String, dynamic> json) {
    idEnterprise = json['idEnterprise'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idEnterprise'] = this.idEnterprise;
    data['name'] = this.name;
    return data;
  }
}

Future<List<Reservation>?> getReservations() async {
  String url = "https://intensif02.ensicaen.fr/api/reservation";
  Uri uri = Uri.parse(url);
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    List<Reservation> reservations = [];
    for (var jsonBuilding in jsonResponse) {
      reservations.add(Reservation.fromJson(jsonBuilding));
    }
    return reservations;
  } else {
    print('Request failed with status: ${response.statusCode}');
    return null;
  }
}


