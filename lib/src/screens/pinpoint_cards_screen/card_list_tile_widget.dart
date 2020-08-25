import 'package:flutter/material.dart';

Widget cardListTileWidget(String imgUrl, String title, String location) {
  print("in list tile:  $imgUrl, $title, $location");
  return ListTile(
    leading: Hero(
      tag: imgUrl + title + location, // FIXME: Shit tag?
      child: CircleAvatar(
        backgroundColor: Colors.amber[100],
        backgroundImage: NetworkImage(
          imgUrl,
        ),
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
