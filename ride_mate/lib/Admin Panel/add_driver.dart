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
      title: 'Driver Management',
      theme: ThemeData(
        primarySwatch: Colors.yellow, // Setting theme color to yellow
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DriverManagementPage(),
    );
  }
}

class DriverManagementPage extends StatefulWidget {
  @override
  _DriverManagementPageState createState() => _DriverManagementPageState();
}

class _DriverManagementPageState extends State<DriverManagementPage> {
  List<Map<String, String>> drivers = [
    {"name": "John Doe", "license": "AB1234567"},
    {"name": "Jane Smith", "license": "XY9876543"},
    {"name": "Michael Johnson", "license": "LM1122334"},
  ];

  // Function to add a new driver
  void _addDriver() {
    TextEditingController nameController = TextEditingController();
    TextEditingController licenseController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Driver'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Driver Name'),
              ),
              TextField(
                controller: licenseController,
                decoration: InputDecoration(labelText: 'License Number'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                String name = nameController.text.trim();
                String license = licenseController.text.trim();

                if (name.isEmpty || license.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill in all fields')),
                  );
                } else {
                  setState(() {
                    drivers.add({"name": name, "license": license});
                  });
                  Navigator.of(context).pop(); // Close dialog
                  _showDriverAddedConfirmation(name, license);
                }
              },
              child: Text('Add Driver'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Show confirmation pop-up after a driver is added
  void _showDriverAddedConfirmation(String name, String license) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Driver Added'),
          content: Text('Driver $name with license $license has been added.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Function to delete a driver
  void _deleteDriver(int index) {
    setState(() {
      drivers.removeAt(index);
    });
  }

  // Function to edit driver details
  void _editDriver(int index) {
    TextEditingController nameController = TextEditingController(
      text: drivers[index]["name"],
    );
    TextEditingController licenseController = TextEditingController(
      text: drivers[index]["license"],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Driver Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Driver Name'),
              ),
              TextField(
                controller: licenseController,
                decoration: InputDecoration(labelText: 'License Number'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  drivers[index] = {
                    "name": nameController.text.trim(),
                    "license": licenseController.text.trim(),
                  };
                });
                Navigator.of(context).pop();
                _showDriverUpdatedConfirmation(
                  drivers[index]["name"]!,
                  drivers[index]["license"]!,
                );
              },
              child: Text('Save Changes'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Show confirmation pop-up after driver details are updated
  void _showDriverUpdatedConfirmation(String name, String license) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Driver Updated'),
          content: Text('Driver $name with license $license has been updated.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Driver Management',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.yellow, // App bar color
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addDriver,
            tooltip: 'Add New Driver',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Title/Subtitle for Driver Management
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Manage and View All Drivers',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            // Driver List
            Expanded(
              child: ListView.builder(
                itemCount: drivers.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      leading: Icon(Icons.directions_bus, color: Colors.yellow),
                      title: Text(drivers[index]["name"]!),
                      subtitle: Text("License: ${drivers[index]["license"]}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _editDriver(index),
                            tooltip: 'Edit Driver',
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteDriver(index),
                            tooltip: 'Delete Driver',
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
    );
  }
}