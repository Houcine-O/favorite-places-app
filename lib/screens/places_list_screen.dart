import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_places_app/widgets/place_item.dart';
import 'package:favorite_places_app/providers/places_list_provider.dart';
import 'package:favorite_places_app/screens/add_place_screen.dart';

class PlacesListScreen extends ConsumerStatefulWidget {
  const PlacesListScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _PlacesListScreenState();
  }
}

class _PlacesListScreenState extends ConsumerState<PlacesListScreen> {
  late Future<void> _placesFuture;
  @override
  void initState() {
    _placesFuture = ref.read(favoritePlacesProvider.notifier).loadPlaces();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final favPlaces = ref.watch(favoritePlacesProvider);

    Widget content = favPlaces.isEmpty
        ? Center(
            child: Text(
            "No places added yet",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ))
        : ListView.builder(
            itemCount: favPlaces.length,
            itemBuilder: (context, index) {
              return PlaceItem(place: favPlaces[index]);
            });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your places"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AddPlaceScreen()));
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: FutureBuilder(
          future: _placesFuture,
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : content,
        ),
      ),
    );
  }
}
