class BookingModel {
  final DateTime datetime;
  final String origin;
  final String destination;
  final double price;
  final String ticketNumbers;

  BookingModel({
    required this.datetime,
    required this.origin,
    required this.destination,
    required this.price,
    required this.ticketNumbers,
  });

  Map<String, dynamic> toJson() {
    return {
      'origin': origin,
      'destination': destination,
      'datetime': datetime.toIso8601String(),
      'price': price,
      'ticketNumbers': ticketNumbers,
    };
  }

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      origin: json['origin'],
      destination: json['destination'],
      datetime: DateTime.parse(json['datetime']),
      price: json['price'].toDouble(),
      ticketNumbers: json['ticketNumbers'],
    );
  }
}
