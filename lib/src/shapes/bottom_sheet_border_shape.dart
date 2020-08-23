import 'package:flutter/material.dart';

/* 
    The shape of the top of the bottomSheet modal
   */
RoundedRectangleBorder getBottomSheetShape() {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(10.0),
      topRight: Radius.circular(10.0),
    ),
  );
}
