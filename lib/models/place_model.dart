import 'dart:io';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceLocation {
  final double latitude;
  final double longitude;

  const PlaceLocation({required this.latitude, required this.longitude});
}

class Place {
  final String id;
  final String address;
  final String title;
  final File image;
  final PlaceLocation location;

  Place(
      {required this.title,
      required this.image,
      required this.location,
      required this.address})
      : id = uuid.v4();
}
