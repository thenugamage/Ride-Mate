import 'package:flutter/material.dart';

class DriverManagementPage extends StatefulWidget {
  const DriverManagementPage({super.key});

  @override
  _DriverManagementPageState createState() => _DriverManagementPageState();
}

class _DriverManagementPageState extends State<DriverManagementPage> {
  List<Map<String, String>> drivers = [
    {"name": "Kasun Perera", "license": "AB1234567"},
    {"name": "Sajani Prathiba", "license": "XY9876543"},
    {"name": "Kavya Samaraweera", "license": "LM1122334"},
  ];

  TextEditingController searchController = TextEditingController();
  List<Map<String, String>> filteredDrivers = [];

  @override
  void initState() {
    super.initState();
    filteredDrivers = drivers;
  }

  void searchDrivers(String query) {
    setState(() {
      filteredDrivers = drivers.where((driver) {
        return driver["name"]!.toLowerCase().contains(query.toLowerCase()) ||
            driver["license"]!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

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
                    filteredDrivers = List.from(drivers);
                    searchDrivers(searchController.text);
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this driver?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(foregroundColor: Colors.grey),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  String name = drivers[index]["name"]!;
                  drivers.removeAt(index);
                  filteredDrivers = List.from(drivers);
                  searchDrivers(searchController.text);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Driver deleted successfully')),
                );
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
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
                  filteredDrivers = List.from(drivers);
                  searchDrivers(searchController.text);
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
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.black87),
            onPressed: _addDriver,
            tooltip: 'Add New Driver',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              onChanged: searchDrivers,
              decoration: InputDecoration(
                hintText: 'Search drivers...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
            ),
          ),
          Expanded(
            child: filteredDrivers.isEmpty
                ? Center(
                    child: Text(
                      'No drivers found',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredDrivers.length,
                    padding: EdgeInsets.all(16),
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 2,
                        margin: EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(16),
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey[100],
                            child: Icon(
                              Icons.person,
                              color: Colors.black87,
                            ),
                          ),
                          title: Text(
                            filteredDrivers[index]["name"]!,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "License: ${filteredDrivers[index]["license"]}",
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue[700]),
                                onPressed: () => _editDriver(index),
                                tooltip: 'Edit Driver',
                              ),
                              IconButton(
                                icon:
                                    Icon(Icons.delete, color: Colors.red[700]),
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
    );
  }
}
