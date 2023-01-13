import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

import 'MapPageWidget.dart';
import 'building.dart';
import 'package:flutter/material.dart';

class AvailableBuildingsPage extends StatefulWidget {
  @override
  _AvailableBuildingsPageState createState() => _AvailableBuildingsPageState();
}

class _AvailableBuildingsPageState extends State<AvailableBuildingsPage> {
  final _formKey = GlobalKey<FormState>();
  final _cityController = TextEditingController();
  final _dateStartController = TextEditingController();
  final _dateEndController = TextEditingController();
  final _needPlaceController = TextEditingController();

  _AvailableBuildingsPageState() {
    _cityController.text = "Caen";
    _needPlaceController.text = "4";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Réserver"),
        backgroundColor: Color(0xFF8EAFA1),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                child: TextFormField(
                  controller: _cityController,
                  decoration: InputDecoration(labelText: "Ville"),
                  validator: (value) {
                    if (value != null && value!.isEmpty) {
                      return "Veuillez sélectionner une ville";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                child: DateTimeField(
                  controller: _dateStartController,
                  decoration: InputDecoration(labelText: "Date d'arrivée"),
                  format: DateFormat("dd/MM/yyyy"),
                  validator: (value) {
                    if (value == null) {
                      return "Veuillez sélectionner une date";
                    }
                    return null;
                  },
                  onShowPicker: (BuildContext context, DateTime? currentValue) {
                    return showDatePicker(
                        context: context, firstDate: DateTime(1900), initialDate: currentValue ?? DateTime.now(), lastDate: DateTime(2100));
                  },
                ),
              ),
              Container(
                child: DateTimeField(
                  controller: _dateEndController,
                  decoration: InputDecoration(labelText: "Date de départ"),
                  format: DateFormat("dd/MM/yyyy"),
                  validator: (value) {
                    if (value == null) {
                      return "Veuillez sélectionner une date";
                    }
                    return null;
                  },
                  onShowPicker: (BuildContext context, DateTime? currentValue) {
                    return showDatePicker(
                        context: context, firstDate: DateTime(1900), initialDate: currentValue ?? DateTime.now(), lastDate: DateTime(2100));
                  },
                ),
              ),
              Container(
                child: TextFormField(
                  controller: _needPlaceController,
                  decoration: InputDecoration(labelText: "Nombre de personnes"),
                  validator: (value) {
                    if (value != null && value!.isEmpty) {
                      return "Veuillez sélectionner le nombre de personnes";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF8EAFA1)),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var start = DateFormat("dd/MM/yyyy").parse(_dateStartController.text);
                      var end = DateFormat("dd/MM/yyyy").parse(_dateEndController.text);
                      var apiFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");

                      Map<String, dynamic> jsonData = {
                        "city": _cityController.text,
                        "dateStart": apiFormat.format(start),
                        "dateEnd": apiFormat.format(end),
                        "needPlace": int.parse(_needPlaceController.text)
                      };
                      var buildings = await putJSON(jsonData);
                      var markers = prepareBuildingMarkers(buildings!);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapPageWidget(markers: markers, buildings: buildings),
                          ));
                    }
                  },
                  child: Text("Afficher les bâtiments"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
