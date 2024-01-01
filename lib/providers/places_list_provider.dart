import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_places_app/models/place_model.dart';

class FavoritePlacesNotifier extends StateNotifier<List<Place>> {
  FavoritePlacesNotifier() : super(const []);

  void addFavPlaces(Place place) {
    state = [place, ...state];
  }
}

final favoritePlacesProvider =
    StateNotifierProvider<FavoritePlacesNotifier, List<Place>>((ref) {
  return FavoritePlacesNotifier();
});
