class TraineeInProgressModel {
  int? courseId;
  Course? course;
  int? traineeId;
  Trainee? trainee;
  double? latitude;
  double? longitude;
  int? weight;
  int? length;
  int? completedHours;
  int? absenceCount;
  int? progress;
  bool? isFinished;
  List<Bmi>? bmi;

  TraineeInProgressModel(
      {this.courseId,
        this.course,
        this.traineeId,
        this.trainee,
        this.latitude,
        this.longitude,
        this.weight,
        this.length,
        this.completedHours,
        this.absenceCount,
        this.progress,
        this.isFinished,
        this.bmi});

  TraineeInProgressModel.fromJson(Map<String, dynamic> json) {
    courseId = json['courseId'];
    course =
    json['course'] != null ? new Course.fromJson(json['course']) : null;
    traineeId = json['traineeId'];
    trainee =
    json['trainee'] != null ? new Trainee.fromJson(json['trainee']) : null;
    latitude = json['latitude'];
    longitude = json['longitude'];
    weight = json['weight'];
    length = json['length'];
    completedHours = json['completedHours'];
    absenceCount = json['absenceCount'];
    progress = json['progress'];
    isFinished = json['isFinished'];
    if (json['bmi'] != null) {
      bmi = <Bmi>[];
      json['bmi'].forEach((v) {
        bmi!.add(new Bmi.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courseId'] = this.courseId;
    if (this.course != null) {
      data['course'] = this.course!.toJson();
    }
    data['traineeId'] = this.traineeId;
    if (this.trainee != null) {
      data['trainee'] = this.trainee!.toJson();
    }
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['weight'] = this.weight;
    data['length'] = this.length;
    data['completedHours'] = this.completedHours;
    data['absenceCount'] = this.absenceCount;
    data['progress'] = this.progress;
    data['isFinished'] = this.isFinished;
    if (this.bmi != null) {
      data['bmi'] = this.bmi!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Course {
  int? fee;
  String? imageUrl;
  int? trainingHoursCount;
  int? value;
  String? text;

  Course(
      {this.fee,
        this.imageUrl,
        this.trainingHoursCount,
        this.value,
        this.text});

  Course.fromJson(Map<String, dynamic> json) {
    fee = json['fee'];
    imageUrl = json['imageUrl'];
    trainingHoursCount = json['trainingHoursCount'];
    value = json['value'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fee'] = this.fee;
    data['imageUrl'] = this.imageUrl;
    data['trainingHoursCount'] = this.trainingHoursCount;
    data['value'] = this.value;
    data['text'] = this.text;
    return data;
  }
}

class Trainee {
  String? name;
  String? phoneNumber;
  Null? imageUrl;
  int? id;

  Trainee({this.name, this.phoneNumber, this.imageUrl, this.id});

  Trainee.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    imageUrl = json['imageUrl'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['imageUrl'] = this.imageUrl;
    data['id'] = this.id;
    return data;
  }
}

class Bmi {
  String? date;
  Null? bmi;

  Bmi({this.date, this.bmi});

  Bmi.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    bmi = json['bmi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['bmi'] = this.bmi;
    return data;
  }
}
