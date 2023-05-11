class CourseModel {
  String? imageUrl;
  int? fee;
  String? creationTime;
  int? creatorUserId;
  String? createdBy;
  bool? hasDiscount;
  String? discountPercentage;
  int? trainerId;
  Trainer? trainer;
  int? categoryId;
  Category? category;
  int? trainingHoursCount;
  int? viewsCount;
  String? arDescription;
  String? enDescription;
  String? description;
  int? bookingRequestsCount;
  int? traineesCount;
  // List<Null>? traineesProgress;
  bool? isFinished;
  int? rate;
  RatingDetails? ratingDetails;
  bool? isActive;
  String? arName;
  String? enName;
  String? name;
  int? id;

  CourseModel(
      {this.imageUrl,
      this.fee,
      this.creationTime,
      this.creatorUserId,
      this.createdBy,
      this.hasDiscount,
      this.discountPercentage,
      this.trainerId,
      this.trainer,
      this.categoryId,
      this.category,
      this.trainingHoursCount,
      this.viewsCount,
      this.arDescription,
      this.enDescription,
      this.description,
      this.bookingRequestsCount,
      this.traineesCount,
      // this.traineesProgress,
      this.isFinished,
      this.rate,
      this.ratingDetails,
      this.isActive,
      this.arName,
      this.enName,
      this.name,
      this.id});

  CourseModel.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    fee = json['fee'];
    creationTime = json['creationTime'];
    creatorUserId = json['creatorUserId'];
    createdBy = json['createdBy'];
    hasDiscount = json['hasDiscount'];
    discountPercentage = json['discountPercentage'];
    trainerId = json['trainerId'];
    trainer =
        json['trainer'] != null ? Trainer.fromJson(json['trainer']) : null;
    categoryId = json['categoryId'];
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
    trainingHoursCount = json['trainingHoursCount'];
    viewsCount = json['viewsCount'];
    arDescription = json['arDescription'];
    enDescription = json['enDescription'];
    description = json['description'];
    bookingRequestsCount = json['bookingRequestsCount'];
    traineesCount = json['traineesCount'];
    // if (json['traineesProgress'] != null) {
    //   traineesProgress = <Null>[];
    //   json['traineesProgress'].forEach((v) {
    //     traineesProgress!.add(new Null.fromJson(v));
    //   });
    // }
    isFinished = json['isFinished'];
    rate = json['rate'];
    ratingDetails = json['ratingDetails'] != null
        ? RatingDetails.fromJson(json['ratingDetails'])
        : null;
    isActive = json['isActive'];
    arName = json['arName'];
    enName = json['enName'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['imageUrl'] = imageUrl;
    data['fee'] = fee;
    data['creationTime'] = creationTime;
    data['creatorUserId'] = creatorUserId;
    data['createdBy'] = createdBy;
    data['hasDiscount'] = hasDiscount;
    data['discountPercentage'] = discountPercentage;
    data['trainerId'] = trainerId;
    if (trainer != null) {
      data['trainer'] = trainer!.toJson();
    }
    data['categoryId'] = categoryId;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['trainingHoursCount'] = trainingHoursCount;
    data['viewsCount'] = viewsCount;
    data['arDescription'] = arDescription;
    data['enDescription'] = enDescription;
    data['description'] = description;
    data['bookingRequestsCount'] = bookingRequestsCount;
    data['traineesCount'] = traineesCount;
    // if (this.traineesProgress != null) {
    //   data['traineesProgress'] =
    //       this.traineesProgress!.map((v) => v.toJson()).toList();
    // }
    data['isFinished'] = isFinished;
    data['rate'] = rate;
    if (ratingDetails != null) {
      data['ratingDetails'] = ratingDetails!.toJson();
    }
    data['isActive'] = isActive;
    data['arName'] = arName;
    data['enName'] = enName;
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}

class Trainer {
  Null? imageUrl;
  int? value;
  String? text;

  Trainer({this.imageUrl, this.value, this.text});

  Trainer.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    value = json['value'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['imageUrl'] = imageUrl;
    data['value'] = value;
    data['text'] = text;
    return data;
  }
}

class Category {
  int? value;
  String? text;

  Category({this.value, this.text});

  Category.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['value'] = value;
    data['text'] = text;
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['1'] = i1;
    data['2'] = i2;
    data['3'] = i3;
    data['4'] = i4;
    data['5'] = i5;
    return data;
  }
}
