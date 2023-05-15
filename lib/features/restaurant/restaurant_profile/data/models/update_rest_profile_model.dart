import 'dart:io';

import 'package:dio/dio.dart';

import 'restaurants_model.dart';

class UpdateRestProfileModel {
  int? id;
  String? arName;
  String? enName;
  File? arLogo;
  File? enLogo;
  File? arCover;
  File? enCover;
  String? commercialRegisterNumber;
  File? commercialRegisterDocument;
  int? cityId;
  String? street;
  int? buildingNumber;
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
    required this.cityId,
    required this.street,
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
      "arLogo": arLogo == null
          ? null
          : await MultipartFile.fromFile(arLogo!.path,
              filename: arLogo == null ? null : arLogo!.path.split('/').last),
      "enLogo": enLogo == null
          ? null
          : await MultipartFile.fromFile(enLogo!.path,
              filename: enLogo!.path.split('/').last),
      "arCover": arCover == null
          ? null
          : await MultipartFile.fromFile(arCover!.path,
              filename: arCover!.path.split('/').last),
      "enCover": enCover == null
          ? null
          : await MultipartFile.fromFile(enCover!.path,
              filename: enCover!.path.split('/').last),
      "commercialRegisterNumber": commercialRegisterNumber,
      "commercialRegisterDocument": commercialRegisterDocument == null
          ? null
          : await MultipartFile.fromFile(commercialRegisterDocument!.path,
              filename: commercialRegisterDocument!.path.split('/').last),
      "cityId": cityId,
      "street": street,
      "buildingNumber": buildingNumber,
      "phoneNumber": phoneNumber,
      "facebookUrl": facebookUrl,
      "instagramUrl": instagramUrl,
      "twitterUrl": twitterUrl,
      "websiteUrl": websiteUrl,
    };
  }
}
