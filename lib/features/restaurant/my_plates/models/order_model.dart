class OrderModel {
  String? number;
  int? traineeId;
  Trainee? trainee;
  int? restaurantId;
  Restaurant? restaurant;
  Null? shopId;
  Null? shop;
  int? status;
  String? creationTime;
  int? paymentMethod;
  Null? transactionId;
  int? paidAmount;
  int? price;
  List<Item>? items;
  bool? isWithDelivery;
  int? id;

  OrderModel(
      {this.number,
        this.traineeId,
        this.trainee,
        this.restaurantId,
        this.restaurant,
        this.shopId,
        this.shop,
        this.status,
        this.creationTime,
        this.paymentMethod,
        this.transactionId,
        this.paidAmount,
        this.price,
        this.items,
        this.isWithDelivery,
        this.id});

  OrderModel.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    traineeId = json['traineeId'];
    trainee =
    json['trainee'] != null ? Trainee.fromJson(json['trainee']) : null;
    restaurantId = json['restaurantId'];
    restaurant = json['restaurant'] != null
        ? Restaurant.fromJson(json['restaurant'])
        : null;
    shopId = json['shopId'];
    shop = json['shop'];
    status = json['status'];
    creationTime = json['creationTime'];
    paymentMethod = json['paymentMethod'];
    transactionId = json['transactionId'];
    paidAmount = json['paidAmount'];
    price = json['price'];
    if (json['items'] != null) {
      items = <Item>[];
      json['items'].forEach((v) {
        items!.add(Item.fromJson(v));
      });
    }
    isWithDelivery = json['isWithDelivery'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['traineeId'] = traineeId;
    if (trainee != null) {
      data['trainee'] = trainee!.toJson();
    }
    data['restaurantId'] = restaurantId;
    if (restaurant != null) {
      data['restaurant'] = restaurant!.toJson();
    }
    data['shopId'] = shopId;
    data['shop'] = shop;
    data['status'] = status;
    data['creationTime'] = creationTime;
    data['paymentMethod'] = paymentMethod;
    data['transactionId'] = transactionId;
    data['paidAmount'] = paidAmount;
    data['price'] = price;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['isWithDelivery'] = isWithDelivery;
    data['id'] = id;
    return data;
  }
}

class Trainee {
  String? name;
  String? phoneNumber;
  String? imageUrl;
  int? id;

  Trainee({this.name, this.phoneNumber, this.imageUrl, this.id});

  Trainee.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    imageUrl = json['imageUrl'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['imageUrl'] = imageUrl;
    data['id'] = id;
    return data;
  }
}

class Restaurant {
  String? logo;
  int? value;
  String? text;

  Restaurant({this.logo, this.value, this.text});

  Restaurant.fromJson(Map<String, dynamic> json) {
    logo = json['logo'];
    value = json['value'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['logo'] = logo;
    data['value'] = value;
    data['text'] = text;
    return data;
  }
}

class Item {
  int? orderId;
  int? dishId;
  Dish? dish;
  int? productId;
  int? price;
  int? quantity;
  String? product;
  String? creationTime;
  int? id;

  Item(
      {this.orderId,
        this.dishId,
        this.dish,
        this.productId,
        this.price,
        this.quantity,
        this.product,
        this.creationTime,
        this.id});

  Item.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    dishId = json['dishId'];
    dish = json['dish'] != null ? Dish.fromJson(json['dish']) : null;
    productId = json['productId'];
    price = json['price'];
    quantity = json['quantity'];
    product = json['product'];
    creationTime = json['creationTime'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderId'] = orderId;
    data['dishId'] = dishId;
    if (dish != null) {
      data['dish'] = dish!.toJson();
    }
    data['productId'] = productId;
    data['price'] = price;
    data['quantity'] = quantity;
    data['product'] = product;
    data['creationTime'] = creationTime;
    data['id'] = id;
    return data;
  }
}

class Dish {
  String? imageUrl;
  int? value;
  String? text;

  Dish({this.imageUrl, this.value, this.text});

  Dish.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    value = json['value'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageUrl'] = imageUrl;
    data['value'] = value;
    data['text'] = text;
    return data;
  }
}
