import 'dart:io';

import 'package:favorite_places_app/providers/places_list_provider.dart';
import 'package:favorite_places_app/widgets/image_input.dart';
import 'package:favorite_places_app/widgets/location_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:favorite_places_app/models/place_model.dart';
import 'package:geocoding/geocoding.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  String _address = '';
  PlaceLocation? _selectedLocation;
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  File? _pickedImage;
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final favPlaces = ref.watch(favoritePlacesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new place"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1) {
                    return 'please enter a title for the place';
                  }
                  return null;
                },
                onSaved: (value) => _title = value!,
              ),
              const SizedBox(
                height: 10,
              ),
              ImageInput(onPickImage: (image) {
                _pickedImage = image;
              }),
              const SizedBox(
                height: 10,
              ),
              LocationInput(
                onSelectLocation: (latlng) {
                  _selectedLocation = latlng;
                  placemarkFromCoordinates(latlng.latitude, latlng.longitude)
                      .then(
                    (placemarks) {
                      var output = 'No results found.';
                      if (placemarks.isNotEmpty) {
                        output = placemarks[0].street.toString() +
                            ', ' +
                            placemarks[0].administrativeArea.toString() +
                            ', ' +
                            placemarks[0].country.toString();
                      }
                      _address = output;
                    },
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (_pickedImage == null || _selectedLocation == null)
                      return;

                    Place newPlace = Place(
                      title: _title,
                      address: _address,
                      location: _selectedLocation!,
                      image: _pickedImage!,
                    );
                    ref
                        .read(favoritePlacesProvider.notifier)
                        .addFavPlaces(newPlace);

                    Navigator.of(context).pop();
                  }
                },
                icon: const Icon(Icons.add),
                label: const Text('Add place'),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
