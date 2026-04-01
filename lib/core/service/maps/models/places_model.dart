class PlaceModel {
   String name;
   String country;
   double lat;
   double lng;

  PlaceModel({
    required this.name,
    required this.country,
    required this.lat,
    required this.lng,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    final properties = json['properties'];
    final coordinates = json['geometry']['coordinates'];
    return PlaceModel(
      name: properties['name'] ?? '',
      country: properties['country'] ?? '',
      lat: coordinates[1],
      lng: coordinates[0],
    );
  }
}

