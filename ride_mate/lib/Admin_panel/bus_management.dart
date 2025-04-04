import 'package:flutter/material.dart';
import 'package:ride_mate/models/bus_model.dart';
import '../data/bus_data.dart';

class BusManagementScreen extends StatefulWidget {
  const BusManagementScreen({super.key});

  @override
  State<BusManagementScreen> createState() => _BusManagementScreenState();
}

class _BusManagementScreenState extends State<BusManagementScreen> {
  final _formKey = GlobalKey<FormState>();
  final _originController = TextEditingController();
  final _destinationController = TextEditingController();
  final _timeController = TextEditingController();
  final Set<int> _deletedBusIds = {};
  final List<Bus> _temporaryBuses = [];
  int _tempBusId = 1000; // Starting ID for temporary buses

  @override
  Widget build(BuildContext context) {
    // Combine and filter buses
    final allBuses = [...sampleBusData, ..._temporaryBuses]
        .where((bus) => !_deletedBusIds.contains(int.parse(bus.id)))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Management'),
        backgroundColor: Colors.yellow,
      ),
      body: Column(
        children: [
          // Add Bus Form Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _originController,
                    decoration: const InputDecoration(
                      labelText: 'Origin',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Please enter origin' : null,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _destinationController,
                    decoration: const InputDecoration(
                      labelText: 'Destination',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Please enter destination'
                        : null,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _timeController,
                    decoration: const InputDecoration(
                      labelText: 'Travel Time',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Please enter travel time'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _temporaryBuses.add(Bus(
                            id: _tempBusId.toString(),
                            origin: _originController.text,
                            destination: _destinationController.text,
                            departureTime: DateTime.now(),
                            arrivalTime: DateTime.now().add(
                              Duration(
                                  minutes:
                                      int.tryParse(_timeController.text) ?? 0),
                            ),
                            date: DateTime.now(),
                          ));
                          _tempBusId++;
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Bus added successfully')),
                        );
                        _formKey.currentState!.reset();
                        _originController.clear();
                        _destinationController.clear();
                        _timeController.clear();
                      }
                    },
                    child: const Text('Add Bus'),
                  ),
                ],
              ),
            ),
          ),

          // Updated Bus List Section
          Expanded(
            child: ListView.builder(
              itemCount: allBuses.length,
              itemBuilder: (context, index) {
                final bus = allBuses[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: ListTile(
                    title: Text('Bus ${bus.id}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Origin: ${bus.origin}'),
                        Text('Destination: ${bus.destination}'),
                        Text(
                            'Departure: ${bus.departureTime.toString().substring(11, 16)}'),
                        Text(
                            'Arrival: ${bus.arrivalTime.toString().substring(11, 16)}'),
                        Text('Date: ${bus.date.toString().substring(0, 10)}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _deletedBusIds.add(int.parse(bus.id));
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Bus removed')),
                        );
                      },
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

  @override
  void dispose() {
    _originController.dispose();
    _destinationController.dispose();
    _timeController.dispose();
    super.dispose();
  }
}
