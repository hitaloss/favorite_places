import 'package:favorite_places/providers/places.dart';
import 'package:flutter/material.dart';

import 'package:favorite_places/models/place.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewPlaceScreen extends ConsumerStatefulWidget {
  const NewPlaceScreen({super.key});

  @override
  ConsumerState<NewPlaceScreen> createState() => _NewPlaceScreenState();
}

class _NewPlaceScreenState extends ConsumerState<NewPlaceScreen> {
  final _titleValueController = TextEditingController();

  void snackBarNotification(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      action: SnackBarAction(
          label: "Dismiss",
          onPressed: () {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
          }),
    ));
  }

  void _addPlace() {
    if (_titleValueController.text.trim().isEmpty) {
      snackBarNotification("Please, make sure to insert a valid title");
      return;
    }
    ref
        .read(placesProvider.notifier)
        .addPlace(Place(title: _titleValueController.text));
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: [
          TextField(
            textCapitalization: TextCapitalization.sentences,
            controller: _titleValueController,
            decoration: const InputDecoration(label: Text("Title")),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 20),
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
