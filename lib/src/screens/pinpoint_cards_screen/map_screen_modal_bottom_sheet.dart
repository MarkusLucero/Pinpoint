import 'package:flutter/material.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinpoint/src/screens/pinpoint_cards_screen/alert_removal_dialog.dart';
import '../../models/pin_point_model.dart';
import '../../shapes/bottom_sheet_border_shape.dart';
import '../card_detail_screen/card_detail_screen.dart';
import './edit_modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../../services/pinpoints_list_service.dart';
import '../pinpoint_map_screen/pinpoint_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Needs marker that we target,
void mapScreenModalBottomSheet(Marker mark, context) {
  showModalBottomSheet(
      context: context,
      shape: getBottomSheetShape(),
      builder: (context) => SafeArea(
            child: Column(
              children: [
                ListTile(
                  onTap: () => null,
                  leading: Icon(Icons.delete_forever),
                  title: Text("Delete"),
                ),
                ListTile(onTap: () => null, leading: Icon(Icons.zoom_out_map))
              ],
            ),
          ));
}
