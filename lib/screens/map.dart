import 'package:favorite_places/providers/location.dart';
import 'package:flutter/material.dart';

import 'package:favorite_places/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen(
      {super.key,
      this.location = const PlaceLocation(
          latitude: 37.422, longitude: -122.084, address: ""),
      this.isSelecting = true});

  final PlaceLocation location;
  final bool isSelecting;

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  LatLng? _pickedLocation;

  void onSave() {
    if (_pickedLocation != null) {
      ref.read(locationProvider.notifier).saveLocation(_pickedLocation!);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isSelecting ? "Pick your Location" : "Your Location"),
        actions: [
          if (widget.isSelecting)
            IconButton(onPressed: onSave, icon: const Icon(Icons.save))
        ],
      ),
      body: GoogleMap(
        onTap: (pos) {
          !widget.isSelecting
              ? null
              : setState(() {
                  _pickedLocation = pos;
                });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.location.latitude, widget.location.longitude),
          zoom: 16,
        ),
        markers: (_pickedLocation == null && widget.isSelecting)
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('m1'),
                  position: _pickedLocation ??
                      LatLng(
                          widget.location.latitude, widget.location.longitude),
                )
              },
      ),
    );
  }
}
