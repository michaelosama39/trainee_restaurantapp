class DishModel {
  Result? result;
  Null? targetUrl;
  bool? success;
  Null? error;
  bool? unAuthorizedRequest;
  bool? bAbp;

  DishModel(
      {this.result,
        this.targetUrl,
        this.success,
        this.error,
        this.unAuthorizedRequest,
        this.bAbp});

  DishModel.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? Result.fromJson(json['result']) : null;
    targetUrl = json['targetUrl'];
    success = json['success'];
    error = json['error'];
    unAuthorizedRequest = json['unAuthorizedRequest'];
    bAbp = json['__abp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.toJson();
    }
    data['targetUrl'] = targetUrl;
    data['success'] = success;
    data['error'] = error;
    data['unAuthorizedRequest'] = unAuthorizedRequest;
    data['__abp'] = bAbp;
    return data;
  }
}

class Result {
  int? totalCount;
  List<Items>? items;

  Result({this.totalCount, this.items});

  Result.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalCount'] = totalCount;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? enComponents;
  String? arComponents;
  String? components;
  int? price;
  int? restaurantId;
  Restaurant? restaurant;
  int? categoryId;
  Restaurant? category;
  String? creationTime;
  List<String>? images;
  double? rate;
  int? orderCount;
  RatingDetails? ratingDetails;
  bool? isActive;
  String? arName;
  String? enName;
  String? name;
  int? id;

  Items(
      {this.enComponents,
        this.arComponents,
        this.components,
        this.price,
        this.restaurantId,
        this.restaurant,
        this.categoryId,
        this.category,
        this.creationTime,
        this.images,
        this.rate,
        this.orderCount,
        this.ratingDetails,
        this.isActive,
        this.arName,
        this.enName,
        this.name,
        this.id});

  Items.fromJson(Map<String, dynamic> json) {
    enComponents = json['enComponents'];
    arComponents = json['arComponents'];
    components = json['components'];
    price = json['price'];
    restaurantId = json['restaurantId'];
    restaurant = json['restaurant'] != null
        ? Restaurant.fromJson(json['restaurant'])
        : null;
    categoryId = json['categoryId'];
    category = json['category'] != null
        ? Restaurant.fromJson(json['category'])
        : null;
    creationTime = json['creationTime'];
    images = json['images'].cast<String>();
    rate = json['rate'];
    orderCount = json['orderCount'];
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['enComponents'] = enComponents;
    data['arComponents'] = arComponents;
    data['components'] = components;
    data['price'] = price;
    data['restaurantId'] = restaurantId;
    if (restaurant != null) {
      data['restaurant'] = restaurant!.toJson();
    }
    data['categoryId'] = categoryId;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['creationTime'] = creationTime;
    data['images'] = images;
    data['rate'] = rate;
    data['orderCount'] = orderCount;
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

class Restaurant {
  int? value;
  String? text;

  Restaurant({this.value, this.text});

  Restaurant.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['1'] = i1;
    data['2'] = i2;
    data['3'] = i3;
    data['4'] = i4;
    data['5'] = i5;
    return data;
  }
}
