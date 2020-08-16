import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PinPointMap extends StatefulWidget {
  //Override because the widget manages its own state
  @override
  //Builds the PinPointMapState widget.
  _PinPointMapState createState() => _PinPointMapState();
}

/// This widget creates the map layout and define the map attributes
class _PinPointMapState extends State<PinPointMap> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition:
          CameraPosition(target: LatLng(59.837604, 17.634548), zoom: 18),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    ));
  }
}
