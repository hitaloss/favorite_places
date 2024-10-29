import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/providers/places.dart';
import 'package:favorite_places/models/place.dart';

class NewPlaceScreen extends ConsumerStatefulWidget {
  const NewPlaceScreen({super.key});

  @override
  ConsumerState<NewPlaceScreen> createState() => _NewPlaceScreenState();
}

class _NewPlaceScreenState extends ConsumerState<NewPlaceScreen> {
  final _titleValueController = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

  void snackBarNotification(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  void _addPlace() {
    if (_titleValueController.text.isEmpty ||
        _selectedImage == null ||
        _selectedLocation == null) {
      snackBarNotification("Please, make sure to complete all fields required");
      return;
    }
    ref.read(placesProvider.notifier).addPlace(Place(
        title: _titleValueController.text,
        image: _selectedImage!,
        location: _selectedLocation!));
    snackBarNotification("Place added");
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
    _titleValueController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add new Place")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          TextField(
            textCapitalization: TextCapitalization.sentences,
            controller: _titleValueController,
            decoration: const InputDecoration(label: Text("Title")),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 10),
          ImageInput(
            onPickImage: (image) {
              _selectedImage = image;
            },
          ),
          const SizedBox(height: 16),
          LocationInput(onPickLocation: (PlaceLocation location) {
            _selectedLocation = location;
          }),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _addPlace,
            icon: const Icon(Icons.add),
            label: const Text("Add Place"),
          )
        ]),
      ),
    );
  }
}
