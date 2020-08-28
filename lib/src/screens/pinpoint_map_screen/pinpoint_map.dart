import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:pinpoint/src/models/internal_marker_model.dart';
import 'package:pinpoint/src/screens/pinpoint_cards_screen/pinpoint_cards_screen.dart';
import 'package:pinpoint/src/shapes/bottom_sheet_border_shape.dart';
import 'added_marker_modal.dart';
import '../../services/pinpoints_list_service.dart';
import 'package:provider/provider.dart';
import '../../models/pin_point_model.dart';
import '../card_detail_screen/card_detail_screen.dart';

class PinPointMapScreen extends StatefulWidget {
  @override
  _PinPointMapScreenState createState() => _PinPointMapScreenState();
}

/// This widget creates the map layout and define the map attributes
class _PinPointMapScreenState extends State<PinPointMapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;

  String _address = "";
  String title;
  Marker latest;
  double initZoom = 18;
  double currentZoom = 18;

  void _add(BuildContext context, pinPoint, marker) {
    Provider.of<PinPointsService>(context, listen: false).add(pinPoint, marker);
  }

  //Updates current title to not be null allowing marker placement
  void updateTitle(String newTitle) {
    print(newTitle);
    this.title = newTitle;
    print(this.title);
  }

  void _getCurrentZoom(CameraPosition position) async {
    currentZoom = position.zoom;
  }

  //Creates a set needed by Google Maps widget in order to render markers
  Set<Marker> _convertInternalMarkersToMarkers(BuildContext context) {
    List<InternalMarker> internalMarkers =
        Provider.of<PinPointsService>(context).markers;
    Set<Marker> markers = Set<Marker>();
    internalMarkers.forEach((mark) {
      int idToPinPoint = mark.pinPointId;
      markers.add(
        Marker(
          markerId: MarkerId(mark.id.toString()),
          position: LatLng(
            mark.latitude,
            mark.longitude,
          ),
          infoWindow: InfoWindow(
            title: mark.title,
            snippet: "Test",
          ),
          icon: BitmapDescriptor.defaultMarker,
          onTap: () => (_goFromMarkerToDetailed(context, idToPinPoint)),
        ),
      );
    });
    return markers;
  }

  void _goFromMarkerToDetailed(BuildContext context, int id) {
    PinPoint pinPoint = Provider.of<PinPointsService>(
      context,
      listen: false,
    ).fetchPinPoint(id);
    Image img = Provider.of<PinPointsService>(
      context,
      listen: false,
    ).getImage(id);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CardDetailScreen(
          pinPoint: pinPoint,
          img: img,
        ),
      ),
    );
  }

  //moves camera to where you click on map. Factors in current zoom levels.
  Future<void> moveCamera(LatLng coords) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: coords, zoom: currentZoom)));
  }

  ///Function that handles the tap event. I.e clicking to set a marker
  void _handleTap(LatLng point) async {
    await _findPlaceFromCoords(point);
    await moveCamera(point);
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
      _add(
          context,
          PinPoint(title: this.title, notes: "", img: "", location: _address),
          InternalMarker(
            latitude: point.latitude,
            longitude: point.longitude,
            title: this.title,
          ));
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
    Set<Marker> _markers = _convertInternalMarkersToMarkers(context);

    return Scaffold(

        ///Stack allows multiple widgets to be placed ontop of eachother. E.g stuff on the map.
        body: Stack(children: <Widget>[
      GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
            target: LatLng(59.837604, 17.634548), zoom: initZoom),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onCameraMove: _getCurrentZoom,
        onTap: _handleTap,
        markers: _markers,
      )
    ]));
  }
}
