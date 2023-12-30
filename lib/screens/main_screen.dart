import 'package:favorite_places_app/screens/new_place_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const NewPlaceScreen()));
            },
            icon: const Icon(Icons.add),
          )
        ],
        title: const Text("Your places"),
      ),
      body: const Center(
          child: Text(
        "No places added yet",
        style: TextStyle(color: Colors.white60),
      )),
    );
  }
}
