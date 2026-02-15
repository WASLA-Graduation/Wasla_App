class GymPackageTypeModel {
  final String type;
  final int value;

  GymPackageTypeModel({required this.type, required this.value});
  static List<GymPackageTypeModel> get types => [
    GymPackageTypeModel(type: "package", value: 0),

    GymPackageTypeModel(type: "offer", value: 1),
  ];
}
