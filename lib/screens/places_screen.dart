import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends ConsumerState<PlacesScreen> {
  @override
  Widget build(BuildContext context) {
    Widget content = const Column(
      children: [
        ListTile(
            title: Text(
          "Place 1",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ))
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Places"),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
      ),
      body: content,
    );
  }
}
