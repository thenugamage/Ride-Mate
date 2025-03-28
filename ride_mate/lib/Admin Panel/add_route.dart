import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bus & Route Management',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BusRouteManagementPage(),
    );
  }
}

class BusRouteManagementPage extends StatefulWidget {
  @override
  _BusRouteManagementPageState createState() => _BusRouteManagementPageState();
}

class _BusRouteManagementPageState extends State<BusRouteManagementPage> {
  List<Map<String, String>> buses = [
    {"busNumber": "123", "route": "City Center to Airport", "capacity": "40"},
    {
      "busNumber": "456",
      "route": "Central Station to Downtown",
      "capacity": "50",
    },
    {"busNumber": "789", "route": "Suburb to Main Station", "capacity": "30"},
  ];

  
  void _addBus() {
    TextEditingController busNumberController = TextEditingController();
    TextEditingController routeController = TextEditingController();
    TextEditingController capacityController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Bus'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: busNumberController,
                decoration: InputDecoration(labelText: 'Bus Number'),
              ),
              TextField(
                controller: routeController,
                decoration: InputDecoration(labelText: 'Route'),
              ),
              TextField(
                controller: capacityController,
                decoration: InputDecoration(labelText: 'Seating Capacity'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (busNumberController.text.isNotEmpty &&
                    routeController.text.isNotEmpty &&
                    capacityController.text.isNotEmpty) {
                  setState(() {
                    buses.add({
                      "busNumber": busNumberController.text,
                      "route": routeController.text,
                      "capacity": capacityController.text,
                    });
                  });
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill all fields')),
                  );
                }
              },
              child: Text('Add'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _deleteBus(int index) {
    setState(() {
      buses.removeAt(index);
    });
  }

  void _editBus(int index) {
    TextEditingController busNumberController = TextEditingController(
      text: buses[index]["busNumber"],
    );
    TextEditingController routeController = TextEditingController(
      text: buses[index]["route"],
    );
    TextEditingController capacityController = TextEditingController(
      text: buses[index]["capacity"],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Bus Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: busNumberController,
                decoration: InputDecoration(labelText: 'Bus Number'),
              ),
              TextField(
                controller: routeController,
                decoration: InputDecoration(labelText: 'Route'),
              ),
              TextField(
                controller: capacityController,
                decoration: InputDecoration(labelText: 'Seating Capacity'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  buses[index] = {
                    "busNumber": busNumberController.text,
                    "route": routeController.text,
                    "capacity": capacityController.text,
                  };
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
         
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Color.fromARGB(255, 205, 174, 0)],
              ),
            ),
          ),

          
          SafeArea(
            child: Column(
              children: [
                // 🧢 Gradient AppBar
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  centerTitle: true,
                  title: Text(
                    'Bus & Route Management',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.add, color: Colors.black),
                      onPressed: _addBus,
                      tooltip: 'Add New Bus',
                    ),
                  ],
                  flexibleSpace: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          Color.fromARGB(255, 205, 174, 0),
                        ],
                      ),
                    ),
                  ),
                ),

                // 🏷 Title
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Manage and View All Buses',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: buses.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(15),
                          leading: Icon(
                            Icons.directions_bus,
                            color: Colors.yellow,
                            size: 40,
                          ),
                          title: Text(
                            buses[index]["busNumber"]!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            "Route: ${buses[index]["route"]}\nCapacity: ${buses[index]["capacity"]} seats",
                            style: TextStyle(fontSize: 14),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _editBus(index),
                                tooltip: 'Edit Bus',
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteBus(index),
                                tooltip: 'Delete Bus',
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}