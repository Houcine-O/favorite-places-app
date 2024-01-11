import 'package:favorite_places_app/models/place_model.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation location;
  final bool isSelecting;

  const MapScreen({
    super.key,
    this.location = const PlaceLocation(latitude: 37.422, longitude: -122.084),
    this.isSelecting = true,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isSelecting
            ? 'Pick your location'
            : 'Your selected location'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: () {
                Navigator.of(context).pop(_pickedLocation);
              },
              icon: const Icon(
                Icons.save,
              ),
            ),
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
            onTap: !widget.isSelecting
                ? null
                : (position, latlng) {
                    setState(() {
                      _pickedLocation = latlng;
                    });
                  },
            initialZoom: 16,
            initialCenter:
                LatLng(widget.location.latitude, widget.location.longitude)),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          ),
          MarkerLayer(markers: [
            Marker(
                point: _pickedLocation == null
                    ? LatLng(
                        widget.location.latitude, widget.location.longitude)
                    : LatLng(
                        _pickedLocation!.latitude, _pickedLocation!.longitude),
                child: const Icon(
                  Icons.location_on,
                  size: 36,
                  color: Colors.red,
                ))
          ])
        ],
      ),
    );
  }
}
