import 'package:trainee_restaurantapp/core/models/trainee_model.dart';

class NewTraineeModel {
  int? traineeId;
  TraineeModel? trainee;
  Course? course;
  double? progress;

  NewTraineeModel({this.traineeId, this.trainee, this.course, this.progress});

  NewTraineeModel.fromJson(Map<String, dynamic> json) {
    traineeId = json['traineeId'];
    trainee =
    json['trainee'] != null ? TraineeModel.fromJson(json['trainee']) : null;
    course =
    json['course'] != null ? Course.fromJson(json['course']) : null;
    progress = json['progress'];
  }

}


class Course {
  int? value;
  String? text;

  Course({this.value, this.text});

  Course.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = this.value;
    data['text'] = this.text;
    return data;
  }
}
