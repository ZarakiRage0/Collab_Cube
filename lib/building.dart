import 'package:http/http.dart' as http;
import 'dart:convert';

class Building {
  late final int idBuilding;
  late final String adress;
  late final String postalCode;
  late final String city;
  late final String latitude;
  late final String longitude;
  late final int maxPlace;

  Building(
      {required this.idBuilding,
        required this.adress,
        required this.postalCode,
        required this.city,
        required this.latitude,
        required this.longitude,
        required this.maxPlace});

  Building.fromJson(Map<String, dynamic> json) {
    idBuilding = json['idBuilding'];
    adress = json['adress'];
    postalCode = json['postalCode'];
    city = json['city'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    maxPlace = json['maxPlace'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idBuilding'] = this.idBuilding;
    data['adress'] = this.adress;
    data['postalCode'] = this.postalCode;
    data['city'] = this.city;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['maxPlace'] = this.maxPlace;
    return data;
  }

  @override
  String toString() {
    return 'Building{'
        '\tidBuilding: $idBuilding,'
        '\tadress: $adress,'
        '\tpostalCode: $postalCode,'
        '\tcity: $city,'
        '\tlatitude: $latitude,'
        '\tlongitude: $longitude,'
        '\tmaxPlace: $maxPlace}';
  }
}






Future<List<Building>?> getBuildings() async {
  String url = "https://intensif02.ensicaen.fr/api/building";
  Uri uri = Uri.parse(url);
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    List<Building> buildings = [];
    for (var jsonBuilding in jsonResponse) {
      buildings.add(Building.fromJson(jsonBuilding));
    }
    for(Building b in buildings){
      print(b);
    }
    return buildings;
  } else {
    print('Request failed with status: ${response.statusCode}');
    return null;
  }
}
