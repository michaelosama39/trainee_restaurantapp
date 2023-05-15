class TraineeModel {
  String? name;
  String? phoneNumber;
  String? imageUrl;
  int? id;

  TraineeModel({this.name, this.phoneNumber, this.imageUrl, this.id});

  TraineeModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    imageUrl = json['imageUrl'];
    id = json['id'];
  }

}