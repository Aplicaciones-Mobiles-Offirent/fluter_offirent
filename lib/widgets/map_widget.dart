

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidgets extends StatefulWidget {
  const MapWidgets({Key? key}) : super(key: key);

  @override
  _MapWidgetsState createState() => _MapWidgetsState();
}

class _MapWidgetsState extends State<MapWidgets> {

  final _initialCameraPosition = CameraPosition(
      target: LatLng(-0.2053476,-78.4894387),
        zoom: 15);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dirección"),
        backgroundColor: Colors.indigo,),
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
      ),
    );
  }
}
