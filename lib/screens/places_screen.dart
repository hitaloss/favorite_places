import 'package:favorite_places/models/place_model.dart';
import 'package:favorite_places/providers/places_provider.dart';
import 'package:favorite_places/screens/new_place_screen.dart';
import 'package:favorite_places/screens/place_details_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  void addItem(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const NewPlaceScreen()));
  }

  @override
  Widget build(BuildContext context, ref) {
    List<Place> placesList = ref.watch(placesProvider);

    Widget content = const Center(
        child: Text(
      "No places added yet",
      style: TextStyle(color: Colors.white),
    ));

    if (placesList.isNotEmpty) {
      content = ListView.builder(
        itemCount: placesList.length,
        itemBuilder: (context, index) {
          return ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => PlaceDetailsScreen(
                          title: placesList[index].title,
                        )));
              },
              title: Text(
                placesList[index].title,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ));
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Places"),
        actions: [
          IconButton(
              onPressed: () {
                addItem(context);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: content,
    );
  }
}
