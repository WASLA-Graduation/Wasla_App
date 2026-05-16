class TripModel {
  final String residentName;
  final String residentId;
  final String residentPhone;
  final String residentImage;
  final String pickUpPlace;
  final String dropOffPlace;
  final double pickUpLatitude;
  final double pickUpLongitude;
  final DateTime pickUpTime;
  final DateTime dropOffTime;
  final double price;
  final double distance;
  final double duration;

  TripModel({
    required this.residentId,
    required this.residentName,
    required this.residentPhone,
    required this.residentImage,
    required this.pickUpPlace,
    required this.dropOffPlace,
    required this.pickUpLatitude,
    required this.pickUpLongitude,
    required this.pickUpTime,
    required this.dropOffTime,
    required this.price,
    required this.distance,
    required this.duration,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      residentName: json['residentName'] ?? '',
      residentPhone: json['residentPhone'] ?? "",
      residentImage: json['residentImage'] ?? "",
      pickUpPlace: json['pickUpPlace'] ?? '',
      dropOffPlace: json['dropOffPlace'] ?? '',
      pickUpLatitude: (json['pickUpLatitude'] as num).toDouble(),
      pickUpLongitude: (json['pickUpLongitude'] as num).toDouble(),
      pickUpTime: DateTime.parse(json['pickUpTime']),
      dropOffTime: DateTime.parse(json['dropOffTime']),
      price: (json['price'] as num).toDouble(),
      distance: (json['distance'] as num).toDouble(),
      duration: (json['duration'] as num).toDouble(),
      residentId: json['residentId'],
    );
  }
}
