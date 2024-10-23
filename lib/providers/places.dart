import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_places/models/place.dart';

class PlacesNotifier extends StateNotifier<List<Place>> {
  PlacesNotifier() : super(const []);

  void addPlace(Place place) {
    state = [...state, place];
  }
}

final placesProvider = StateNotifierProvider<PlacesNotifier, List<Place>>(
    (ref) => PlacesNotifier());
