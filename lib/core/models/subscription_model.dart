class SubscriptionModel {
  int? subscriptionId;
  String? creationTime;
  bool? isExpired;
  String? name;
  double? fee;
  int? duration;
  int? remainingDays;
  int? remainingRequests;
  int? remainingItems;
  int? id;

  SubscriptionModel(
      {this.subscriptionId,
        this.creationTime,
        this.isExpired,
        this.name,
        this.fee,
        this.duration,
        this.remainingDays,
        this.remainingRequests,
        this.remainingItems,
        this.id});

  SubscriptionModel.fromJson(Map<String, dynamic> json) {
    subscriptionId = json['subscriptionId'];
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

}

