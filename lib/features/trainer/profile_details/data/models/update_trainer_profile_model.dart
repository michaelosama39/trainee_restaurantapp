import 'dart:io';

import 'package:dio/dio.dart';

class UpdateTrainerProfileModel {
  int? id;
  int? specializationId;
  String? name;
  String? phoneNumber;
  String? idNumber;
  // int? hourPrice;

  UpdateTrainerProfileModel({
    required this.id,
    required this.specializationId,
    required this.name,
    required this.phoneNumber,
    required this.idNumber,
    // required this.hourPrice,
  });

  Future<Map<String, dynamic>> toJson() async {
    return {
      "id": id,
      "name": name,
      "phoneNumber": phoneNumber,
      "idNumber": idNumber,
      "specializationId": specializationId,
      // "hourPrice": hourPrice,
    };
  }
}
