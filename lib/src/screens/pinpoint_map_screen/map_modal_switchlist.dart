import 'package:flutter/material.dart';
import '../../screens/pinpoint_map_screen/alert_drag_marker_instructions.dart';

class MapModalSwitchList extends StatefulWidget {
  final Function getMarker;
  final int markerId;
  MapModalSwitchList({@required this.markerId, this.getMarker});

  @override
  _MapModalSwitchListState createState() => _MapModalSwitchListState();
}

class _MapModalSwitchListState extends State<MapModalSwitchList> {
  bool _movable = false;

  bool getMovable() {
    return _movable;
  }

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
