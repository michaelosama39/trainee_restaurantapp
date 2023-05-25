import 'dart:io';

import 'package:dio/dio.dart';

class UpdateTrainerProfileModel {
  int? id;
  File? imageUrl;
  String? name;
  File? cvUrl;
  String? phoneNumber;
  double? latitude;
  double? longitude;
  String? idNumber;
  double? hourPrice;
  int? specializationId;

  UpdateTrainerProfileModel({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.cvUrl,
    required this.phoneNumber,
    required this.latitude,
    required this.longitude,
    required this.idNumber,
    required this.hourPrice,
    required this.specializationId,
  });

  Future<Map<String, dynamic>> toJson() async {
    return {
      "specializationId": specializationId,
      "imageUrl": imageUrl == await MultipartFile.fromFile(imageUrl!.path,
          filename: imageUrl!.path.split('/').last),
      "name": name,
      "cvUrl": cvUrl == await MultipartFile.fromFile(cvUrl!.path,
          filename: cvUrl!.path.split('/').last),
      "phoneNumber": phoneNumber,
      "countryCode": 966,
      "latitude": latitude,
      "longitude": longitude,
      "idNumber": idNumber,
      "hourPrice": hourPrice,
      "id": id,
    };
  }
}
