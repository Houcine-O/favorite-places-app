import 'package:flutter/material.dart';

class NewPlaceScreen extends StatelessWidget {
  const NewPlaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new place"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          child: Column(children: [
            TextFormField(
              decoration: const InputDecoration(
                label: Text('Title'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Add place'),
            )
          ]),
        ),
      ),
    );
  }
}
