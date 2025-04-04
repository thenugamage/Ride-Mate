import 'package:flutter/material.dart';

class ViewBusesScreen extends StatelessWidget {
  const ViewBusesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Buses'),
        backgroundColor: Colors.yellow,
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with actual bus count
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text('Bus ${index + 1}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Origin: Sample Origin ${index + 1}'),
                  Text('Destination: Sample Destination ${index + 1}'),
                  Text('Time: ${index + 1}:00 Hours'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
