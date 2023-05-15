import '../../../../../core/models/subscription_model.dart';

class RestaurantsModel {
  String? arDescription;
  String? enDescription;
  String? description;
  String? arLogo;
  String? enLogo;
  String? logo;
  String? arCover;
  String? enCover;
  String? cover;
  String? commercialRegisterNumber;
  String? commercialRegisterDocument;
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
  String? latitude;
  String? longitude;
  List<OpeningDays>? openingDays;
  double? rate;
  String? creationTime;
  SubscriptionModel? subscription;
  RatingDetails? ratingDetails;
  bool? isActive;
  String? arName;
  String? enName;
  String? name;
  int? id;

  RestaurantsModel(
      {this.arDescription,
        this.enDescription,
        this.description,
        this.arLogo,
        this.enLogo,
        this.logo,
        this.arCover,
        this.enCover,
        this.cover,
        this.commercialRegisterNumber,
        this.commercialRegisterDocument,
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

  RestaurantsModel.fromJson(Map<String, dynamic> json) {
    arDescription = json['arDescription'];
    enDescription = json['enDescription'];
    description = json['description'];
    arLogo = json['arLogo'];
    enLogo = json['enLogo'];
    logo = json['logo'];
    arCover = json['arCover'];
    enCover = json['enCover'];
    cover = json['cover'];
    commercialRegisterNumber = json['commercialRegisterNumber'];
    commercialRegisterDocument = json['commercialRegisterDocument'];
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
        ? SubscriptionModel.fromJson(json['subscription'])
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
    data['commercialRegisterNumber'] = commercialRegisterNumber;
    data['commercialRegisterDocument'] = commercialRegisterDocument;
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
    data['subscription'] = subscription;
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
