import 'package:trainee_restaurantapp/core/models/trainee_model.dart';
import 'package:trainee_restaurantapp/core/models/trainer_model.dart';

class ReviewModel {
  int? rate;
  String? comment;
  String? creationTime;
  TraineeModel? reviewer;
  int? id;

  ReviewModel(
      {this.rate,
        this.comment,
        this.creationTime,
        this.reviewer,
        this.id});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    rate = json['rate'];
    comment = json['comment'];
    creationTime = json['creationTime'];
    reviewer = json['reviewer'] != null
        ? TraineeModel.fromJson(json['reviewer'])
        : null;
    id = json['id'];
  }

}


