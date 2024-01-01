import 'package:favorite_places_app/screens/place_details_screen.dart';
import 'package:flutter/material.dart';

import 'package:favorite_places_app/models/place_model.dart';

class PlaceItem extends StatelessWidget {
  const PlaceItem({
    super.key,
    required this.place,
  });

  final Place place;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(place.title),
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PlaceDetailsScreen(
                place: place,
              ))),
    );
  }
}
