class CategoriesModel {
  Result? result;
  String? targetUrl;
  bool? success;
  String? error;
  bool? unAuthorizedRequest;
  bool? bAbp;

  CategoriesModel(
      {this.result,
        this.targetUrl,
        this.success,
        this.error,
        this.unAuthorizedRequest,
        this.bAbp});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
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
  String? imageUrl;
  String? iconUrl;
  int? type;
  bool? isActive;
  String? arName;
  String? enName;
  String? name;
  int? id;

  Items(
      {this.imageUrl,
        this.iconUrl,
        this.type,
        this.isActive,
        this.arName,
        this.enName,
        this.name,
        this.id});

  Items.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    iconUrl = json['iconUrl'];
    type = json['type'];
    isActive = json['isActive'];
    arName = json['arName'];
    enName = json['enName'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageUrl'] = imageUrl;
    data['iconUrl'] = iconUrl;
    data['type'] = type;
    data['isActive'] = isActive;
    data['arName'] = arName;
    data['enName'] = enName;
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}
