import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';

class PinPointMap extends StatefulWidget {
  //Override because the widget manages its own state
  @override
  //Builds the PinPointMapState widget.
  _PinPointMapState createState() => _PinPointMapState();
}

/// This widget creates the map layout and define the map attributes
class _PinPointMapState extends State<PinPointMap> {
  Completer<GoogleMapController> _controller = Completer();

  ///This set contains all markers placed on the map
  Set<Marker> _markers = Set<Marker>();

  String _address = "";

  ///Function that handles the tap event. I.e clicking to set a marker
  void _handleTap(LatLng point) async {
    await _findPlaceFromCoords(point);
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId(point.toString()),
          position: point,
          infoWindow: InfoWindow(title: _address, snippet: "Test"),
          icon: BitmapDescriptor.defaultMarker));
    });
  }

  ///Function that gets the coordinates of the marker and sets the address accordingly"
  Future<void> _findPlaceFromCoords(LatLng point) async {
    final coordinates = new Coordinates(point.latitude, point.longitude);
    print(coordinates);
    List<Address> address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    setState(() {
      _address = address.first.thoroughfare +
          " " +
          address.first.subThoroughfare +
          ", " +
          address.first.adminArea;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        ///Stack allows multiple widgets to be placed ontop of eachother. E.g stuff on the map.
        body: Stack(children: <Widget>[
      GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:
            CameraPosition(target: LatLng(59.837604, 17.634548), zoom: 18),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onTap: _handleTap,
        markers: _markers,
      )
    ]));
  }
}
