import 'package:collab_cube/formPage.dart';
import 'package:collab_cube/reservation.dart';
import 'package:collab_cube/reservationsPage.dart';

import 'building.dart';
import 'flutter_flow/src/flutter_flow/flutter_flow_icon_button.dart';
import 'flutter_flow/src/flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/src/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:collab_cube/MapPageWidget.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFD7DCDF),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Image.asset(
                  'assets/images/office.png',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.5,
                  fit: BoxFit.contain,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    'Plan Cubes\nCollaboratifs',
                    style: FlutterFlowTheme.of(context).title1.override(
                          fontFamily: 'Poppins',
                          color: Color(0xFF41535B),
                        ),
                  ),
                ],
              ),
              Align(
                alignment: AlignmentDirectional(0, 0.75),
                child: FFButtonWidget(
                  onPressed: () async {
                    print('Button pressed ...');

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AvailableBuildingsPage(),
                        ));
                  },
                  text: 'Réserver',
                  options: FFButtonOptions(
                    width: 130,
                    height: 40,
                    color: Color(0xFF8EAFA1),
                    textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Poppins',
                          color: Color(0xFFEEF0EF),
                        ),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: 8.0,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 0.95),
                child: FFButtonWidget(
                  onPressed: () async {
                    print('Button pressed ...');

                    var reservations = await getReservations();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ReservationListPage(reservations: reservations!),
                        ));
                  },
                  text: 'Voir les réservations',
                  options: FFButtonOptions(
                    width: 175,
                    height: 40,
                    color: Color(0xFF8EAFA1),
                    textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Poppins',
                          color: Color(0xFFEEF0EF),
                        ),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: 8.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
