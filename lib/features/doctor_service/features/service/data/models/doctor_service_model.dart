import 'package:wasla/core/database/api/api_keys.dart';

class DoctorServiceModel {
  final int id;
  final String serviceNameArabic;
  final String descriptionArabic;
  final String serviceNameEnglish;
  final String descriptionEnglish;
  final double price;
  final List<ServiceDayModel> serviceDays;

  DoctorServiceModel({
    required this.id,
    required this.serviceNameArabic,
    required this.descriptionArabic,
    required this.serviceNameEnglish,
    required this.descriptionEnglish,
    required this.price,
    required this.serviceDays,
  });

  factory DoctorServiceModel.fromJson(Map<String, dynamic> json) {
    return DoctorServiceModel(
      id: json[ApiKeys.id],
      serviceNameArabic: json[ApiKeys.serviceNameArabic],
      descriptionArabic: json[ApiKeys.descriptionArabic],
      serviceNameEnglish: json[ApiKeys.serviceNameEnglish],
      descriptionEnglish: json[ApiKeys.descriptionEnglish],
      price: json[ApiKeys.price],
      serviceDays: (json[ApiKeys.serviceDays] as List)
          .map((e) => ServiceDayModel.fromJson(e))
          .toList(),
    );
  }
}

class ServiceDayModel {
  final int dayOfWeek;
  final List<TimeSlotModel> timeSlots;

  ServiceDayModel({required this.dayOfWeek, required this.timeSlots});

  factory ServiceDayModel.fromJson(Map<String, dynamic> json) {
    return ServiceDayModel(
      dayOfWeek: json[ApiKeys.dayOfWeek],
      timeSlots: (json[ApiKeys.timeSlots] as List)
          .map((e) => TimeSlotModel.fromJson(e))
          .toList(),
    );
  }
}

class TimeSlotModel {
  final int id;
  final String start;
  final String end;
  final bool isBooking;

  TimeSlotModel({
    required this.id,
    required this.start,
    required this.end,
    required this.isBooking,
  });

  factory TimeSlotModel.fromJson(Map<String, dynamic> json) {
    return TimeSlotModel(
      id: json[ApiKeys.id],
      start: json[ApiKeys.start],
      end: json[ApiKeys.end],
      isBooking: json[ApiKeys.isBooking],
    );
  }
}
