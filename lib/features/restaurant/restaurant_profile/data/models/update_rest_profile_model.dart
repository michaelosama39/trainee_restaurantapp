import 'dart:io';

import 'package:dio/dio.dart';

import 'restaurants_model.dart';

class UpdateRestProfileModel {
  int? id;
  String? arName;
  String? enName;
  String? arLogo;
  String? enLogo;
  String? arCover;
  String? enCover;
  String? commercialRegisterNumber;
  String? commercialRegisterDocument;
  // int? cityId;
  // String? street;
  String? buildingNumber;
  String? phoneNumber;
  String? facebookUrl;
  String? instagramUrl;
  String? twitterUrl;
  String? websiteUrl;

  UpdateRestProfileModel({
    required this.id,
    required this.arName,
    required this.enName,
    required this.arLogo,
    required this.enLogo,
    required this.arCover,
    required this.enCover,
    required this.commercialRegisterNumber,
    required this.commercialRegisterDocument,
    // required this.cityId,
    // required this.street,
    required this.buildingNumber,
    required this.phoneNumber,
    required this.facebookUrl,
    required this.instagramUrl,
    required this.twitterUrl,
    required this.websiteUrl,
  });

  Future<Map<String, dynamic>> toJson() async {
    return {
      "id": id,
      "arName": arName,
      "enName": enName,
      "arLogo": arLogo,
      "enLogo": enLogo,
      "arCover": arCover,
      "enCover": enCover,
      "commercialRegisterNumber": commercialRegisterNumber,
      "commercialRegisterDocument": commercialRegisterDocument ,
      // "cityId": cityId,
      // "street": street,
      "buildingNumber": buildingNumber,
      "phoneNumber": phoneNumber,
      "facebookUrl": facebookUrl,
      "instagramUrl": instagramUrl,
      "twitterUrl": twitterUrl,
      "websiteUrl": websiteUrl,
    };
  }
}
