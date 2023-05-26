import 'dart:io';

import 'package:dio/dio.dart';

class AddCourseModel {
  final String arName;
  final String enName;
  final String imageUrl;
  final num fee;
  final bool hasDiscount;
  final num discountPercentage;
  final int trainerId;
  final int categoryId;
  final int trainingHoursCount;
  final String arDescription;
  final String enDescription;

  AddCourseModel({
    required this.arName,
    required this.enName,
    required this.imageUrl,
    required this.fee,
    required this.hasDiscount,
    required this.discountPercentage,
    required this.trainerId,
    required this.categoryId,
    required this.trainingHoursCount,
    required this.arDescription,
    required this.enDescription,
  });

  Future<Map<String, dynamic>> toJson() async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['arName'] = arName;
    data['enName'] = enName;
    data['imageUrl'] = imageUrl;
    data['fee'] = fee;
    data['hasDiscount'] = hasDiscount;
    data['discountPercentage'] = discountPercentage;
    data['trainerId'] = trainerId;
    data['categoryId'] = categoryId;
    data['trainingHoursCount'] = trainingHoursCount;
    data['arDescription'] = arDescription;
    data['enDescription'] = enDescription;
    return data;
  }
}
