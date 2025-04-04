class SeatBooking {
  final String busId;
  final String travelDate;
  final List<int> bookedSeats;

  SeatBooking({
    required this.busId,
    required this.travelDate,
    required this.bookedSeats,
  });

  Map<String, dynamic> toJson() => {
        'busId': busId,
        'travelDate': travelDate,
        'bookedSeats': bookedSeats,
      };

  factory SeatBooking.fromJson(Map<String, dynamic> json) => SeatBooking(
        busId: json['busId'],
        travelDate: json['travelDate'],
        bookedSeats: List<int>.from(json['bookedSeats']),
      );
}
