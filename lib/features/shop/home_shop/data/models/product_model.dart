class ProductModel {
  Result? result;
  Null? targetUrl;
  bool? success;
  Null? error;
  bool? unAuthorizedRequest;
  bool? bAbp;

  ProductModel(
      {this.result,
        this.targetUrl,
        this.success,
        this.error,
        this.unAuthorizedRequest,
        this.bAbp});

  ProductModel.fromJson(Map<String, dynamic> json) {
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
  int? shopId;
  Shop? shop;
  int? categoryId;
  Shop? category;
  String? creationTime;
  List<String>? images;
  double? rate;
  int? orderCount;
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
        this.shopId,
        this.shop,
        this.categoryId,
        this.category,
        this.creationTime,
        this.images,
        this.rate,
        this.orderCount,
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
    shopId = json['shopId'];
    shop = json['shop'] != null ? Shop.fromJson(json['shop']) : null;
    categoryId = json['categoryId'];
    category =
    json['category'] != null ? Shop.fromJson(json['category']) : null;
    creationTime = json['creationTime'];
    images = json['images'].cast<String>();
    rate = json['rate'];
    orderCount = json['orderCount'];
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
    data['shopId'] = shopId;
    if (shop != null) {
      data['shop'] = shop!.toJson();
    }
    data['categoryId'] = categoryId;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['creationTime'] = creationTime;
    data['images'] = images;
    data['rate'] = rate;
    data['orderCount'] = orderCount;
    data['isActive'] = isActive;
    data['arName'] = arName;
    data['enName'] = enName;
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}

class Shop {
  int? value;
  String? text;

  Shop({this.value, this.text});

  Shop.fromJson(Map<String, dynamic> json) {
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
