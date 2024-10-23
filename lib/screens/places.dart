import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/places.dart';
import 'package:favorite_places/screens/new_place.dart';
import 'package:favorite_places/screens/place_details.dart';
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

    Widget content = Center(
        child: Text(
      "No places added yet",
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.onBackground),
    ));

    if (placesList.isNotEmpty) {
      content = ListView.builder(
        itemCount: placesList.length,
        itemBuilder: (context, index) {
          return ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => PlaceDetailsScreen(
                          place: placesList[index],
                        )));
              },
              title: Text(
                placesList[index].title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
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
