class SubscriptionModel {
  double? fee;
  String? colorCode;
  int? duration;
  String? creationTime;
  int? target;
  int? priceFrom;
  int? priceTo;
  int? requestsCount;
  int? itemsCount;
  // List<UsedSubscriptions>? usedSubscriptions;
  bool? isActive;
  String? arName;
  String? enName;
  String? name;
  int? id;

  SubscriptionModel(
      {this.fee,
        this.colorCode,
        this.duration,
        this.creationTime,
        this.target,
        this.priceFrom,
        this.priceTo,
        this.requestsCount,
        this.itemsCount,
        // this.usedSubscriptions,
        this.isActive,
        this.arName,
        this.enName,
        this.name,
        this.id});

  SubscriptionModel.fromJson(Map<String, dynamic> json) {
    fee = json['fee'];
    colorCode = json['colorCode'];
    duration = json['duration'];
    creationTime = json['creationTime'];
    target = json['target'];
    priceFrom = json['priceFrom'];
    priceTo = json['priceTo'];
    requestsCount = json['requestsCount'];
    itemsCount = json['itemsCount'];
    // if (json['usedSubscriptions'] != null) {
    //   usedSubscriptions = <UsedSubscriptions>[];
    //   json['usedSubscriptions'].forEach((v) {
    //     usedSubscriptions!.add(new UsedSubscriptions.fromJson(v));
    //   });
    // }
    isActive = json['isActive'];
    arName = json['arName'];
    enName = json['enName'];
    name = json['name'];
    id = json['id'];
  }


}

// class UsedSubscriptions {
//   int? subscriptionId;
//   int? userId;
//   User? user;
//   String? creationTime;
//   bool? isExpired;
//   String? name;
//   int? fee;
//   int? duration;
//   int? remainingDays;
//   int? remainingRequests;
//   int? remainingItems;
//   int? id;
//
//   UsedSubscriptions(
//       {this.subscriptionId,
//         this.userId,
//         this.user,
//         this.creationTime,
//         this.isExpired,
//         this.name,
//         this.fee,
//         this.duration,
//         this.remainingDays,
//         this.remainingRequests,
//         this.remainingItems,
//         this.id});
//
//   UsedSubscriptions.fromJson(Map<String, dynamic> json) {
//     subscriptionId = json['subscriptionId'];
//     userId = json['userId'];
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//     creationTime = json['creationTime'];
//     isExpired = json['isExpired'];
//     name = json['name'];
//     fee = json['fee'];
//     duration = json['duration'];
//     remainingDays = json['remainingDays'];
//     remainingRequests = json['remainingRequests'];
//     remainingItems = json['remainingItems'];
//     id = json['id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['subscriptionId'] = this.subscriptionId;
//     data['userId'] = this.userId;
//     if (this.user != null) {
//       data['user'] = this.user!.toJson();
//     }
//     data['creationTime'] = this.creationTime;
//     data['isExpired'] = this.isExpired;
//     data['name'] = this.name;
//     data['fee'] = this.fee;
//     data['duration'] = this.duration;
//     data['remainingDays'] = this.remainingDays;
//     data['remainingRequests'] = this.remainingRequests;
//     data['remainingItems'] = this.remainingItems;
//     data['id'] = this.id;
//     return data;
//   }
// }
//
// class User {
//   int? value;
//   String? text;
//
//   User({this.value, this.text});
//
//   User.fromJson(Map<String, dynamic> json) {
//     value = json['value'];
//     text = json['text'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['value'] = this.value;
//     data['text'] = this.text;
//     return data;
//   }
// }
