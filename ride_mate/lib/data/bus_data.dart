import '../models/bus_model.dart';

final List<Bus> sampleBusData = [
  Bus(
    id: '1',
    origin: 'Colombo',
    destination: 'Kandy',
    departureTime: DateTime(2025, 4, 20, 6, 30), // 6:30 AM
    arrivalTime: DateTime(2025, 4, 20, 9, 30), // 9:30 AM
    date: DateTime(2025, 4, 20),
  ),
  Bus(
    id: '2',
    origin: 'Galle',
    destination: 'Colombo',
    departureTime: DateTime(2025, 4, 20, 7, 0), // 7:00 AM
    arrivalTime: DateTime(2025, 4, 20, 9, 45), // 9:45 AM
    date: DateTime(2025, 4, 20),
  ),
  Bus(
    id: '3',
    origin: 'Kandy',
    destination: 'Matara',
    departureTime: DateTime(2025, 4, 20, 8, 15), // 8:15 AM
    arrivalTime: DateTime(2025, 4, 20, 12, 30), // 12:30 PM
    date: DateTime(2025, 4, 20),
  ),
  Bus(
    id: '4',
    origin: 'Negombo',
    destination: 'Galle',
    departureTime: DateTime(2025, 4, 20, 9, 0), // 9:00 AM
    arrivalTime: DateTime(2025, 4, 20, 12, 0), // 12:00 PM
    date: DateTime(2025, 4, 20),
  ),
  Bus(
    id: '5',
    origin: 'Matara',
    destination: 'Colombo',
    departureTime: DateTime(2025, 4, 20, 5, 30), // 5:30 AM
    arrivalTime: DateTime(2025, 4, 20, 9, 15), // 9:15 AM
    date: DateTime(2025, 4, 20),
  ),
  Bus(
    id: '6',
    origin: 'Colombo',
    destination: 'Jaffna',
    departureTime: DateTime(2025, 4, 20, 6, 0), // 6:00 AM
    arrivalTime: DateTime(2025, 4, 20, 14, 30), // 2:30 PM
    date: DateTime(2025, 4, 20),
  ),
  Bus(
    id: '7',
    origin: 'Anuradhapura',
    destination: 'Colombo',
    departureTime: DateTime(2025, 4, 20, 7, 30), // 7:30 AM
    arrivalTime: DateTime(2025, 4, 20, 13, 0), // 1:00 PM
    date: DateTime(2025, 4, 20),
  ),
  Bus(
    id: '8',
    origin: 'Badulla',
    destination: 'Kandy',
    departureTime: DateTime(2025, 4, 20, 8, 0), // 8:00 AM
    arrivalTime: DateTime(2025, 4, 20, 12, 45), // 12:45 PM
    date: DateTime(2025, 4, 20),
  ),
];
