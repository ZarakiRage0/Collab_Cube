import 'package:collab_cube/reservation_building.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

var center = LatLng(49.18172602337092, -0.3470258165673014);
LatLng london = LatLng(51.5, -0.09);
LatLng paris = LatLng(48.8566, 2.3522);
LatLng dublin = LatLng(53.3498, -6.2603);

final markers = <Marker>[
  Marker(
    width: 80,
    height: 80,
    point: center,
    builder: (ctx) => GestureDetector(
      onTap: () {
        Navigator.push(
            ctx,
            MaterialPageRoute(
              builder: (context) => ReservationDescriptionPageWidget(),
            ));
      },
      child: const Icon(Icons.home_filled, color: Color.fromARGB(255,56,81,84),),
    ),
  ),
];

class MapPageWidget extends StatefulWidget {
  const MapPageWidget({Key? key}) : super(key: key);

  @override
  State<MapPageWidget> createState() => _MapPageWidgetState();
}

class _MapPageWidgetState extends State<MapPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterMap(
          options: MapOptions(
            center: center,
            zoom: 16.0,
            maxZoom: 19.0,
            interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag | InteractiveFlag.doubleTapZoom,
          ),
          nonRotatedChildren: [
            AttributionWidget.defaultWidget(
              source: 'OpenStreetMap contributors',
              onSourceTapped: null,
            ),
          ],
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            MarkerLayer(markers: markers),
          ],
        ),
      ),
    );
  }
}
