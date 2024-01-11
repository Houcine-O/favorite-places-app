import 'package:favorite_places_app/screens/place_details_screen.dart';
import 'package:flutter/material.dart';

import 'package:favorite_places_app/models/place_model.dart';

class PlaceItem extends StatefulWidget {
  const PlaceItem({
    super.key,
    required this.place,
  });

  final Place place;

  @override
  State<PlaceItem> createState() => _PlaceItemState();
}

class _PlaceItemState extends State<PlaceItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
          radius: 26, backgroundImage: FileImage(widget.place.image)),
      title: Text(widget.place.title),
      subtitle: Text(
        widget.place.address,
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PlaceDetailsScreen(
                place: widget.place,
              ))),
    );
  }
}
