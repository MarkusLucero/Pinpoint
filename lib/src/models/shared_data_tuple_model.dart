import 'package:pinpoint/src/models/internal_marker_model.dart';
import 'package:pinpoint/src/models/pin_point_model.dart';

/* used as return type for 2 values */
class SharedDataTuple {
  PinPoint pinPoint;
  InternalMarker marker;

  SharedDataTuple(this.pinPoint, this.marker);
}
