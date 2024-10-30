import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationNotifier extends StateNotifier<LatLng> {
  LocationNotifier() : super(const LatLng(0, 0));

  void saveLocation(LatLng location) {
    state = location;
  }
}

final locationProvider = StateNotifierProvider<LocationNotifier, LatLng>(
    (ref) => LocationNotifier());
