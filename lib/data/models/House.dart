import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class House {
  int? id;
  int? userId;
  int? cityId;
  int? zoneId;
  String? description;
  String? imagePath;
  String? status;
  double? latitude;
  double? longitude;
  String? locationDetails;
  double? price;
  int? area;
  int? roomsCount;
  int? houseFloor;
  String? category;
  String? houseStatus;
  String? houseFurniture;
  String? houseDestinations;
  String? ownershipType;
  String? rentalDuration;
  bool? hasParking;
  bool? hasBalcony;
  bool? hasElevator;
  String? createdAt;
  String? updatedAt; 
  String? cityName;  
  String? zoneName; 
  String get fullImageUrl {
  if (imagePath == null || imagePath!.isEmpty) {
    return "";
  }

  if (imagePath!.startsWith("http")) {
    return imagePath!;
  }

  // تحويل المسار من storage/app/public → storage
  final fixedPath = imagePath!
      .replaceFirst("storage/app/public/", "storage/");

  return "https://5f86981a5274.ngrok-free.app/$fixedPath";
}
 

//   String get fullImageUrl {
//   if (imagePath == null || imagePath!.isEmpty) {
//     return ""; // لا يوجد صورة
//   }

//   // إذا الرابط كامل (من النت)
//   if (imagePath!.startsWith("http://") || imagePath!.startsWith("https://")) {
//     return imagePath!;
//   }

//   // إذا مجرد مسار من السيرفر
//   return "https://5f86981a5274.ngrok-free.app$imagePath";
// }


  House.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    cityId = json['city_id'];
    zoneId = json['zone_id'];
    cityName = json['city']?['ar_name'];
    zoneName = json['zone']?['ar_name'];

    description = json['description'];
    imagePath = json['image_path'];
    status = json['status'];

    latitude = (json['latitude'] as num?)?.toDouble();
    longitude = (json['longitude'] as num?)?.toDouble();

    locationDetails = json['location_details'];
    price = (json['price'] as num?)?.toDouble();

    area = json['area'];
    roomsCount = json['rooms_count'];
    houseFloor = json['house_floor'];

    category = json['category'];
    houseStatus = json['house_status'];
    houseFurniture = json['house_furniture'];
    houseDestinations = json['house_destinations'];
    ownershipType = json['ownership_type'];
    rentalDuration = json['rental_duration'];

    // تحويل 0/1 إلى bool
    hasParking = json['has_parking'] == 1;
    hasBalcony = json['has_balcony'] == 1;
    hasElevator = json['has_elevator'] == 1;

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
