import 'dart:io';

import 'package:dio/dio.dart';

class CreateShopModel {
  final String arName;
  final String enName;
  final String arDescription;
  final String enDescription;
  final String arLogo;
  final String enLogo;
  final String arCover;
  final String enCover;
  final String commercialRegisterNumber;
  final String commercialRegisterDocument;
  final String managerName;
  final String facebookUrl;
  final String instagramUrl;
  final String twitterUrl;
  final String websiteUrl;
  final double latitude;
  final double longitude;


  CreateShopModel(
      {required this.arName,
      required this.enName,
      required this.arDescription,
      required this.enDescription,
      required this.arLogo,
      required this.enLogo,
      required this.arCover,
      required this.enCover,
      required this.commercialRegisterNumber,
      required this.commercialRegisterDocument,
      required this.managerName,
      required this.facebookUrl,
      required this.instagramUrl,
      required this.twitterUrl,
      required this.websiteUrl,
      required this.latitude,
      required this.longitude});

  Future<Map<String, dynamic>> toJson() async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['arName'] = arName;
    data['enName'] = enName;
    data['arDescription'] = arDescription;
    data['enDescription'] = enDescription;
    data['arLogo'] = arLogo;
    data['enLogo'] = enLogo;
    data['arCover'] = arCover;
    data['enCover'] = enCover;
    data['commercialRegisterNumber'] = commercialRegisterNumber;
    data['commercialRegisterDocument'] = commercialRegisterDocument;
    data['managerName'] = managerName;
    data['facebookUrl'] = facebookUrl;
    data['instagramUrl'] = instagramUrl;
    data['twitterUrl'] = twitterUrl;
    data['websiteUrl'] = websiteUrl;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
