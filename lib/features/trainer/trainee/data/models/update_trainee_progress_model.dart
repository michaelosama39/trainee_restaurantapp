import 'dart:io';

import 'package:dio/dio.dart';

class UpdateTraineeProgressModel {

  final int traineeId;
  final int courseId;
  final int completedHours;
  final int fatPercentage;
  final int weight;
  final int absenceCount;


  UpdateTraineeProgressModel(
      {required this.traineeId,
      required this.courseId,
      required this.completedHours,
      required this.fatPercentage,
      required this.weight,
      required this.absenceCount});

  Map<String, dynamic> toJson()  {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['traineeId'] = traineeId;
    data['courseId'] = courseId;
    data['completedHours'] = completedHours;
    data['fatPercentage'] = fatPercentage;
    data['weight'] = weight;
    data['absenceCount'] = absenceCount;
    return data;
  }
}
