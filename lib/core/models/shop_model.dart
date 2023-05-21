class ShopModel {
  String? arDescription;
  String? enDescription;
  String? description;
  String? arLogo;
  String? enLogo;
  String? logo;
  String? arCover;
  String? enCover;
  String? cover;
  int? cityId;
  City? city;
  String? street;
  String? buildingNumber;
  String? phoneNumber;
  Manager? manager;
  String? facebookUrl;
  String? instagramUrl;
  String? twitterUrl;
  String? websiteUrl;
  int? latitude;
  int? longitude;
  List<OpeningDays>? openingDays;
  double? rate;
  String? creationTime;
  Subscription? subscription;
  RatingDetails? ratingDetails;
  bool? isActive;
  String? arName;
  String? enName;
  String? name;
  int? id;

  ShopModel(
      {this.arDescription,
        this.enDescription,
        this.description,
        this.arLogo,
        this.enLogo,
        this.logo,
        this.arCover,
        this.enCover,
        this.cover,
        this.cityId,
        this.city,
        this.street,
        this.buildingNumber,
        this.phoneNumber,
        this.manager,
        this.facebookUrl,
        this.instagramUrl,
        this.twitterUrl,
        this.websiteUrl,
        this.latitude,
        this.longitude,
        this.openingDays,
        this.rate,
        this.creationTime,
        this.subscription,
        this.ratingDetails,
        this.isActive,
        this.arName,
        this.enName,
        this.name,
        this.id});

  ShopModel.fromJson(Map<String, dynamic> json) {
    arDescription = json['arDescription'];
    enDescription = json['enDescription'];
    description = json['description'];
    arLogo = json['arLogo'];
    enLogo = json['enLogo'];
    logo = json['logo'];
    arCover = json['arCover'];
    enCover = json['enCover'];
    cover = json['cover'];
    cityId = json['cityId'];
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    street = json['street'];
    buildingNumber = json['buildingNumber'];
    phoneNumber = json['phoneNumber'];
    manager =
    json['manager'] != null ? Manager.fromJson(json['manager']) : null;
    facebookUrl = json['facebookUrl'];
    instagramUrl = json['instagramUrl'];
    twitterUrl = json['twitterUrl'];
    websiteUrl = json['websiteUrl'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    if (json['openingDays'] != null) {
      openingDays = <OpeningDays>[];
      json['openingDays'].forEach((v) {
        openingDays!.add(OpeningDays.fromJson(v));
      });
    }
    rate = json['rate'];
    creationTime = json['creationTime'];
    subscription = json['subscription'] != null
        ? Subscription.fromJson(json['subscription'])
        : null;
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
    data['arDescription'] = arDescription;
    data['enDescription'] = enDescription;
    data['description'] = description;
    data['arLogo'] = arLogo;
    data['enLogo'] = enLogo;
    data['logo'] = logo;
    data['arCover'] = arCover;
    data['enCover'] = enCover;
    data['cover'] = cover;
    data['cityId'] = cityId;
    if (city != null) {
      data['city'] = city!.toJson();
    }
    data['street'] = street;
    data['buildingNumber'] = buildingNumber;
    data['phoneNumber'] = phoneNumber;
    if (manager != null) {
      data['manager'] = manager!.toJson();
    }
    data['facebookUrl'] = facebookUrl;
    data['instagramUrl'] = instagramUrl;
    data['twitterUrl'] = twitterUrl;
    data['websiteUrl'] = websiteUrl;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    if (openingDays != null) {
      data['openingDays'] = openingDays!.map((v) => v.toJson()).toList();
    }
    data['rate'] = rate;
    data['creationTime'] = creationTime;
    if (subscription != null) {
      data['subscription'] = subscription!.toJson();
    }
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

class City {
  int? value;
  String? text;

  City({this.value, this.text});

  City.fromJson(Map<String, dynamic> json) {
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

class Manager {
  int? id;
  String? name;
  String? phoneNumber;

  Manager({this.id, this.name, this.phoneNumber});

  Manager.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}

class OpeningDays {
  int? day;
  String? from;
  String? to;

  OpeningDays({this.day, this.from, this.to});

  OpeningDays.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['from'] = from;
    data['to'] = to;
    return data;
  }
}

class Subscription {
  int? subscriptionId;
  int? userId;
  City? user;
  String? creationTime;
  bool? isExpired;
  String? name;
  double? fee;
  int? duration;
  int? remainingDays;
  int? remainingRequests;
  int? remainingItems;
  int? id;

  Subscription(
      {this.subscriptionId,
        this.userId,
        this.user,
        this.creationTime,
        this.isExpired,
        this.name,
        this.fee,
        this.duration,
        this.remainingDays,
        this.remainingRequests,
        this.remainingItems,
        this.id});

  Subscription.fromJson(Map<String, dynamic> json) {
    subscriptionId = json['subscriptionId'];
    userId = json['userId'];
    user = json['user'] != null ? City.fromJson(json['user']) : null;
    creationTime = json['creationTime'];
    isExpired = json['isExpired'];
    name = json['name'];
    fee = json['fee'];
    duration = json['duration'];
    remainingDays = json['remainingDays'];
    remainingRequests = json['remainingRequests'];
    remainingItems = json['remainingItems'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subscriptionId'] = subscriptionId;
    data['userId'] = userId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['creationTime'] = creationTime;
    data['isExpired'] = isExpired;
    data['name'] = name;
    data['fee'] = fee;
    data['duration'] = duration;
    data['remainingDays'] = remainingDays;
    data['remainingRequests'] = remainingRequests;
    data['remainingItems'] = remainingItems;
    data['id'] = id;
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
