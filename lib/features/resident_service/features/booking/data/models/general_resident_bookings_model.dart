class GeneralResidentBookingsModel {
  final int baseBookingId;
  final String baseName;
  final String baseServiceName;
  final String baseStatus;
  final String baseImage;
  final String? baseDate;
  final String? baseDuration;

  GeneralResidentBookingsModel({
    required this.baseBookingId,
    required this.baseName,
    required this.baseServiceName,
    required this.baseStatus,
    required this.baseImage,
    required this.baseDate,
    required this.baseDuration,
  });
}
