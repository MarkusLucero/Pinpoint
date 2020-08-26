import 'package:flutter/material.dart';

Widget cardListTileWidget(Image img, String title, String location) {
  return ListTile(
    leading: Hero(
      tag: title + location, // FIXME: Shit tag?
      child: CircleAvatar(
        backgroundColor: Colors.amber[100],
        backgroundImage: img != null
            ? img.image
            : AssetImage("assets/images/picNotFound.png"),
      ),
    ),
    title: Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    subtitle: Text(location.toUpperCase()),
    dense: true,
  );
}
