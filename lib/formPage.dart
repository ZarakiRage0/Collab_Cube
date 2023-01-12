
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
                  decoration: InputDecoration(labelText: "City"),
                  validator: (value) {
                    if (value != null && value!.isEmpty) {
                      return "Please enter a city";
                    }
                    return null;
                  },
                ),
              ),
              Container(

                child: DateTimeField(
                  controller: _dateStartController,
                  decoration: InputDecoration(labelText: "Start date"),
                  format: DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"),
                  validator: (value) {
                    if (value == null) {
                      return "Please enter a start date";
                    }
                    return null;
                  },
                  onShowPicker: (BuildContext context, DateTime? currentValue) {
                    return showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100));
                  },
                ),
              ),
              Container(
                child: DateTimeField(
                  controller: _dateEndController,
                  decoration: InputDecoration(labelText: "End date"),
                  format: DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"),
                  validator: (value) {
                    if (value == null) {
                      return "Please enter an end date";
                    }
                    return null;
                  },
                  onShowPicker: (BuildContext context, DateTime? currentValue) {
                    return showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100));
                  },
                ),
              ),
              Container(
                child: TextFormField(
                  controller: _needPlaceController,
                  decoration: InputDecoration(labelText: "Needed Places"),
                  validator: (value) {
                    if (value != null && value!.isEmpty) {
                      return "Please enter the needed places";
                    }
                    return null;
                  },
                ),
              ),
              Container(

                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF8EAFA1)),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Map<String, dynamic> jsonData = {
                        "city": _cityController.text,
                        "dateStart": _dateStartController.text,
                        "dateEnd": _dateEndController.text,
                        "needPlace": int.parse(_needPlaceController.text)
                      };
                      var buildings = await putJSON(jsonData);
                      var markers = prepareBuildingMarkers(buildings!);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapPageWidget(
                                markers: markers, buildings: buildings),
                          ));
                    }
                  },
                  child: Text("Get Available Buildings"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
