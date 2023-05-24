import 'package:trainee_restaurantapp/core/models/specialization_model.dart';
import 'package:trainee_restaurantapp/core/models/subscription_model.dart';

class TrainerModel {
  int? specializationId;
  SpecializationModel? specialization;
  String? name;
  String? cvUrl;
  String? imageUrl;
  double? latitude;
  double? longitude;
  String? phoneNumber;
  String? countryCode;
  int? coursesCount;
  double? rate;
  int? status;
  bool? isVerified;
  bool? isActive;
  SubscriptionModel? subscription;
  Null? neighbourhood;
  List<Null>? experienceFiles;
  Null? hourPrice;
  RatingDetails? ratingDetails;
  int? id;

  TrainerModel(
      {this.specializationId,
        this.specialization,
        this.name,
        this.cvUrl,
        this.imageUrl,
        this.latitude,
        this.longitude,
        this.phoneNumber,
        this.countryCode,
        this.coursesCount,
        this.rate,
        this.status,
        this.isVerified,
        this.isActive,
        this.subscription,
        this.neighbourhood,
        this.experienceFiles,
        this.hourPrice,
        this.ratingDetails,
        this.id});

  TrainerModel.fromJson(Map<String, dynamic> json) {
    specializationId = json['specializationId'];
    specialization = json['specialization'] != null
        ? SpecializationModel.fromJson(json['specialization'])
        : null;
    name = json['name'];
    cvUrl = json['cvUrl'];
    imageUrl = json['imageUrl'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    phoneNumber = json['phoneNumber'];
    countryCode = json['countryCode'];
    coursesCount = json['coursesCount'];
    rate = json['rate'];
    status = json['status'];
    isVerified = json['isVerified'];
    isActive = json['isActive'];
    subscription = json['subscription'] != null
        ? SubscriptionModel.fromJson(json['subscription'])
        : null;
    neighbourhood = json['neighbourhood'];
    // if (json['experienceFiles'] != null) {
    //   experienceFiles = <String>[];
    //   json['experienceFiles'].forEach((v) {
    //     experienceFiles!.add(v);
    //   });
    // }

    hourPrice = json['hourPrice'];
    ratingDetails = json['ratingDetails'] != null
        ? RatingDetails.fromJson(json['ratingDetails'])
        : null;
    id = json['id'];
  }

}


class RatingDetails {
  int? i1;
  int? i2;
  int? i3;
  int? i4;
  int? i5;

  RatingDetails({this.i1, this.i2, this.i3, this.i4, this.i5});

  RatingDetails.fromJson(Map<String, dynamic> json) {
    i1 = json['1'];
    i2 = json['2'];
    i3 = json['3'];
    i4 = json['4'];
    i5 = json['5'];
  }

}
