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
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    ),
    subtitle: Text(
      location.toUpperCase(),
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w300,
      ),
    ),
    //dense: true, //TODO: should we?
  );
}
