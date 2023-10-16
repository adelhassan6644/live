class OffersModel {
  String? message;
  List<OfferItem>? data;

  OffersModel({this.message, this.data});

  OffersModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(OfferItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OfferItem {
  int? id;
  int? placeId;
  String? image;
  String? description;
  String? title;
  String? phone;
  String? name;
  String? logo;
  String? rate;

  String? price;
  String? discountPrice;
  String? percentage;
  String? discount;
  int? status;
  bool? isPercentage;
  int? agentId;
  String? createdAt;
  String? updatedAt;
  String? expiredDate;

  ///Location
  String? address;
  String? location;
  double? lat;
  double? long;

  ///Social Media
  String? twitter;
  String? whatsapp;
  String? snapChat;
  String? instagram;
  String? tiktok;
  String? facebook;
  String? url;

  OfferItem(
      {this.id,
      this.placeId,
      this.image,
      this.url,
      this.description,
      this.title,
      this.logo,
      this.name,
      this.phone,
      this.rate,
      this.price,
      this.discountPrice,
      this.discount,
      this.percentage,
      this.address,
      this.location,
      this.lat,
      this.long,
      this.status,
      this.isPercentage,
      this.twitter,
      this.whatsapp,
      this.instagram,
      this.tiktok,
      this.snapChat,
      this.facebook,
      this.agentId,
      this.createdAt,
      this.updatedAt,
      this.expiredDate});

  OfferItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    url = json['url'];
    description = json['description'];
    title = json['title'];

    placeId = json['place_id'];
    name = json['name'];
    logo = json['logo'];
    phone = json['phone'];
    rate = json['rate'] != null ? (json['rate'].toString()) : null;
    price = json['price'];
    discountPrice = json['price_after_discount'] != null
        ? (json['price_after_discount'].toString())
        : null;
    percentage = json['percentage'];
    discount = json['discount'];
    isPercentage = json['type'] == 0 ? true : false;
    status = json['status'];

    address = json['address'];
    location = json['location'];
    lat = json['lat'] != null ? double.parse(json['lat'].toString()) : null;
    long = json['long'] != null ? double.parse(json['long'].toString()) : null;

    twitter = json['twitter'];
    whatsapp = json['whatsapp'];
    instagram = json['instagram'];
    tiktok = json['tiktok'];
    snapChat = json['snapchat'];
    facebook = json['facebook'];

    status = json['status'];
    agentId = json['agent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    expiredDate = json['expire_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['description'] = description;
    data['title'] = title;
    data['phone'] = phone;
    data['status'] = status;
    data['type'] = isPercentage;
    data['agent_id'] = agentId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['expire_date'] = expiredDate;
    return data;
  }
}
