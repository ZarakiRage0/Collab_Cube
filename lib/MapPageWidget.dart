import 'package:collab_cube/reservation.dart';
import 'package:collab_cube/reservation_building.dart';
import 'package:collab_cube/reservationsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';

import 'building.dart';

var center = LatLng(49.1852581566487, -0.36683536661280586);

class MapPageWidget extends StatefulWidget {
  final List<Marker> markers;
  final List<Building> buildings;
  const MapPageWidget({Key? key, required this.markers, required this.buildings}) : super(key: key);

  @override
  State<MapPageWidget> createState() => _MapPageWidgetState();
}

class _MapPageWidgetState extends State<MapPageWidget> {
  @override
  Widget build(BuildContext context) {
    final PopupController _popupLayerController = PopupController();

    return Scaffold(
      body: Center(
        child: FlutterMap(
          options: MapOptions(
            center: center,
            zoom: 12.0,
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
              urlTemplate: 'https://openstreetmap.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png',
              userAgentPackageName: 'com.example.app',
            ),
            //MarkerLayer(markers: widget.markers),
            PopupMarkerLayerWidget(
              options: PopupMarkerLayerOptions(
                  popupController: _popupLayerController,
                  markers: widget.markers,
                  markerRotateAlignment: PopupMarkerLayerOptions.rotationAlignmentFor(AnchorAlign.top),
                  popupBuilder: (BuildContext context, Marker marker) => Container(
                        constraints: BoxConstraints(
                          maxHeight: 120,
                        ),
                        padding: EdgeInsets.all(10),
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("${widget.buildings[widget.markers.indexOf(marker)].adress}"),
                            Text(
                                "${widget.buildings[widget.markers.indexOf(marker)].postalCode}, ${widget.buildings[widget.markers.indexOf(marker)].city}"),
                            Text("Places disponibles: ${widget.buildings[widget.markers.indexOf(marker)].maxPlace}"),
                            ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF8EAFA1)),
                                ),
                                onPressed: () async {
                                  var reservations = await getReservations();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ReservationListPage(reservations: reservations!),
                                      ));
                                },
                                child: Text("Réserver")),
                          ],
                        ),
                      )),
            ),
          ],
        ),
      ),
    );
  }
}

List<Marker> prepareBuildingMarkers(List<Building> buildings) {
  return buildings.map((building) {
    return Marker(
      width: 80,
      height: 80,
      point: LatLng(double.parse(building.latitude), double.parse(building.longitude)),
      builder: (ctx) => Image.asset("assets/images/marker-icon.png"),
    );
  }).toList();
}
