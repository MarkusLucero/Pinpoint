import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../screens/pinpoint_map_screen/alert_drag_marker_instructions.dart';

class MapModalSwitchList extends StatefulWidget {
  final Function getMarker;
  final int pinPointId;
  final MarkerId markerId;
  MapModalSwitchList(
      {@required this.pinPointId, this.markerId, this.getMarker});

  @override
  _MapModalSwitchListState createState() => _MapModalSwitchListState();
}

class _MapModalSwitchListState extends State<MapModalSwitchList> {
  bool _movable = false;

  bool getMovable() {
    return _movable;
  }

  void setDraggable(MarkerId markerId) {}

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      secondary: Icon(Icons.zoom_out_map),
      title: Text("Movable"),
      value: _movable,
      onChanged: (bool value) {
        setState(() {
          _movable = value;
        });
        if (_movable == true)
          showDialog(
              context: context,
              builder: (context) => AlertDragMarkerInstructions());
        else
          return false;
      },
    );
  }
}
