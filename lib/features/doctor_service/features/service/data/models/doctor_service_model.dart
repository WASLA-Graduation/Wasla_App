import 'package:wasla/core/database/api/api_keys.dart';

class DoctorServiceModel {
  final int id;
  final String serviceNameAr;
  final String serviceNameEn;
  final String descriptionAr;
  final String descriptionEn;
  final double price;
  final List<ServiceDay> serviceDays;
  final List<ServiceDate> serviceDates;
  final List<TimeSlot> timeSlots;

  DoctorServiceModel({
    required this.id,
    required this.serviceNameAr,
    required this.serviceNameEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.price,
    required this.serviceDays,
    required this.serviceDates,
    required this.timeSlots,
  });

  factory DoctorServiceModel.fromJson(Map<String, dynamic> json) {
    return DoctorServiceModel(
      id: json[ApiKeys.id],
      serviceNameAr: json[ApiKeys.serviceNameArabic],
      serviceNameEn: json[ApiKeys.serviceNameEnglish],
      descriptionEn: json[ApiKeys.descriptionEnglish],
      descriptionAr: json[ApiKeys.descriptionArabic],
      price: (json[ApiKeys.price] as num).toDouble(),
      serviceDays: (json[ApiKeys.serviceDays] as List)
          .map((e) => ServiceDay.fromJson(e))
          .toList(),
      serviceDates: (json[ApiKeys.serviceDates] as List)
          .map((e) => ServiceDate.fromJson(e))
          .toList(),
      timeSlots: (json[ApiKeys.timeSlots] as List)
          .map((e) => TimeSlot.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.id: id,
      ApiKeys.serviceNameArabic: serviceNameAr,
      ApiKeys.serviceNameEnglish: serviceNameEn,
      ApiKeys.descriptionArabic: descriptionAr,
      ApiKeys.descriptionEnglish: descriptionEn,
      ApiKeys.price: price,
      ApiKeys.serviceDays: serviceDays.map((e) => e.toJson()).toList(),
      ApiKeys.serviceDates: serviceDates.map((e) => e.toJson()).toList(),
      ApiKeys.timeSlots: timeSlots.map((e) => e.toJson()).toList(),
    };
  }
}

class ServiceDay {
  final int id;
  final int dayOfWeek;

  ServiceDay({required this.id, required this.dayOfWeek});

  factory ServiceDay.fromJson(Map<String, dynamic> json) {
    return ServiceDay(id: json[ApiKeys.id], dayOfWeek: json[ApiKeys.dayOfWeek]);
  }

  Map<String, dynamic> toJson() {
    return {ApiKeys.dayOfWeek: dayOfWeek};
  }

  Map<String, dynamic> toJsonWithId() {
    return {ApiKeys.dayOfWeek: dayOfWeek, ApiKeys.id: id};
  }
}

class ServiceDate {
  final int id;
  final String date;

  ServiceDate({required this.id, required this.date});

  factory ServiceDate.fromJson(Map<String, dynamic> json) {
    return ServiceDate(id: json[ApiKeys.id], date: json[ApiKeys.date]);
  }

  Map<String, dynamic> toJson() {
    return {ApiKeys.date: date};
  }

  Map<String, dynamic> toJsonWithId() {
    return {ApiKeys.date: date, ApiKeys.id: id};
  }
}

class TimeSlot {
  final int id;
  final String start;
  final String end;

  TimeSlot({required this.id, required this.start, required this.end});

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      id: json[ApiKeys.id],
      start: json[ApiKeys.start],
      end: json[ApiKeys.end],
    );
  }

  Map<String, dynamic> toJson() {
    return {ApiKeys.start: start, ApiKeys.end: end};
  }

  Map<String, dynamic> toJsonWithId() {
    return {ApiKeys.start: start, ApiKeys.end: end, ApiKeys.id: id};
  }
}
