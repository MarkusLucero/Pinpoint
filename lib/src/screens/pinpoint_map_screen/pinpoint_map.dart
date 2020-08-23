import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:pinpoint/src/shapes/bottom_sheet_border_shape.dart';
import 'added_marker_modal.dart';
import '../../services/pinpoints_list_service.dart';
import 'package:provider/provider.dart';
import '../../models/pin_point_model.dart';

class PinPointMapScreen extends StatefulWidget {
  @override
  _PinPointMapScreenState createState() => _PinPointMapScreenState();
}

/// This widget creates the map layout and define the map attributes
class _PinPointMapScreenState extends State<PinPointMapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  String _address = "";
  String title;
  Marker latest;

  void addToPinPointList(BuildContext context, pinPoint) {
    Provider.of<PinPointsService>(context, listen: false).addPinPoint(pinPoint);
  }

  //adds a marker to the list if user taps AND enters a title
  void addToMarkerList(BuildContext context, pinPoint) {
    Provider.of<PinPointsService>(context, listen: false).addMarker(pinPoint);
  }

  void updateTitle(String newTitle) {
    print(newTitle);
    this.title = newTitle;
    print(this.title);
  }

  ///Function that handles the tap event. I.e clicking to set a marker
  void _handleTap(LatLng point) async {
    await _findPlaceFromCoords(point);
    await showModalBottomSheet(
      context: context,
      shape: getBottomSheetShape(),
      builder: (context) => AddedMarkerModal(
        title: this.title,
        updateTitleCallback: updateTitle,
      ),
      isScrollControlled: true,
    );
    if (this.title != null) {
      setState(() {
        //Assembles a marker and adds it to the Markerlist stored in services
        addToMarkerList(
            context,
            Marker(
                markerId: MarkerId(UniqueKey().toString()),
                position: point,
                infoWindow: InfoWindow(title: _address, snippet: "Test"),
                icon: BitmapDescriptor.defaultMarker));
      });
      addToPinPointList(context,
          PinPoint(title: title, notes: "", imgUrl: null, location: _address));
    }
    title = null;
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
    Set<Marker> _markers =
        Provider.of<PinPointsService>(context).markers.toSet();
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
