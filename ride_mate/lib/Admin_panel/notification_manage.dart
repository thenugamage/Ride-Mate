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
      title: 'Notifications Management',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NotificationsManagementPage(),
    );
  }
}

class NotificationsManagementPage extends StatefulWidget {
  @override
  _NotificationsManagementPageState createState() =>
      _NotificationsManagementPageState();
}

class _NotificationsManagementPageState
    extends State<NotificationsManagementPage> {
  List<Map<String, String>> notifications = [
    {
      "title": "Booking Confirmation",
      "message": "Your booking for Bus 123 has been confirmed.",
      "type": "Booking",
    },
    {
      "title": "Booking Reminder",
      "message": "Reminder: Your bus 456 departs in 30 minutes.",
      "type": "Reminder",
    },
    {
      "title": "Cancellation Notice",
      "message": "Your bus 789 has been cancelled due to weather conditions.",
      "type": "Cancellation",
    },
  ];

  String selectedType = "All";
  String searchQuery = "";

  void _addNotification() {
    TextEditingController titleController = TextEditingController();
    TextEditingController messageController = TextEditingController();
    TextEditingController typeController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Notification'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Notification Title'),
              ),
              TextField(
                controller: messageController,
                decoration: InputDecoration(labelText: 'Notification Message'),
              ),
              TextField(
                controller: typeController,
                decoration: InputDecoration(labelText: 'Notification Type'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  notifications.add({
                    "title": titleController.text,
                    "message": messageController.text,
                    "type": typeController.text,
                  });
                });
                Navigator.of(context).pop();
              },
              child: Text('Add Notification'),
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

  void _deleteNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
  }

  void _editNotification(int index) {
    TextEditingController titleController = TextEditingController(
      text: notifications[index]["title"],
    );
    TextEditingController messageController = TextEditingController(
      text: notifications[index]["message"],
    );
    TextEditingController typeController = TextEditingController(
      text: notifications[index]["type"],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Notification Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Notification Title'),
              ),
              TextField(
                controller: messageController,
                decoration: InputDecoration(labelText: 'Notification Message'),
              ),
              TextField(
                controller: typeController,
                decoration: InputDecoration(labelText: 'Notification Type'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  notifications[index] = {
                    "title": titleController.text,
                    "message": messageController.text,
                    "type": typeController.text,
                  };
                });
                Navigator.of(context).pop();
              },
              child: Text('Save Changes'),
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

  List<Map<String, String>> get filteredNotifications {
    return notifications.where((notification) {
      bool matchesSearchQuery =
          notification["title"]!.toLowerCase().contains(
            searchQuery.toLowerCase(),
          ) ||
          notification["message"]!.toLowerCase().contains(
            searchQuery.toLowerCase(),
          );
      bool matchesType =
          selectedType == "All" || notification["type"] == selectedType;
      return matchesSearchQuery && matchesType;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🌈 Background gradient
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
                  title: Text(
                    'Notifications Management',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: [
                    IconButton(
                      icon: Icon(Icons.add, color: Colors.black),
                      onPressed: _addNotification,
                      tooltip: 'Add New Notification',
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

                // 🔍 Search
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 10,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Search Notifications',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (query) {
                      setState(() {
                        searchQuery = query;
                      });
                    },
                  ),
                ),

                // 🔽 Filter Dropdown
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Text('Filter by Type: '),
                      SizedBox(width: 10),
                      DropdownButton<String>(
                        value: selectedType,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedType = newValue!;
                          });
                        },
                        items:
                            [
                              'All',
                              'Booking',
                              'Reminder',
                              'Cancellation',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10),

                // 📋 Notification List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredNotifications.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                        child: ListTile(
                          contentPadding: EdgeInsets.all(15),
                          leading: Icon(
                            Icons.notifications,
                            color: Colors.yellow,
                            size: 40,
                          ),
                          title: Text(
                            filteredNotifications[index]["title"]!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            filteredNotifications[index]["message"]!,
                            style: TextStyle(fontSize: 14),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _editNotification(index),
                                tooltip: 'Edit',
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteNotification(index),
                                tooltip: 'Delete',
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
