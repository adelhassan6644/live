import 'package:live/main_models/places_model.dart';

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
  String? image;
  List<String>? images;

  String? description;
  String? title;
  String? phone;
  String? rate;

  String? terms;
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

  PlaceItem? placeDetails;
  String? url;

  OfferItem(
      {this.id,
      this.images,
      this.url,
      this.description,
      this.terms,
      this.title,
      this.phone,
      this.rate,
      this.price,
      this.discountPrice,
      this.discount,
      this.percentage,
      this.placeDetails,
      this.status,
      this.isPercentage,
      this.agentId,
      this.createdAt,
      this.image,
      this.updatedAt,
      this.expiredDate});

  OfferItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    if(json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images!.add(v['image']);
      });
    }



    url = json['url'];
    description = json['description'];
    title = json['title'];

    terms = json['terms'];
    phone = json['phone'];
    rate = json['rate'] != null ? (json['rate'].toString()) : null;
    price = json['price'];
    discountPrice = json['price_after_discount'] != null
        ? (json['price_after_discount'].toString())
        : null;
    percentage = json['discount_percentage'] != null
        ? (json['discount_percentage'].toString())
        : null;
    discount = json['discount_value'];
    isPercentage = json['type'] == 0 ? true : false;
    status = json['status'];

    placeDetails =
        json['place'] != null ? PlaceItem.fromJson(json['place']) : null;

    status = json['status'];
    agentId = json['agent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    expiredDate = json['expire_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    // data['image'] = image;
    data['description'] = description;
    data['title'] = title;
    data['phone'] = phone;
    data['status'] = status;
    data['type'] = isPercentage;
    data['agent_id'] = agentId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['expire_date'] = expiredDate;
    data['place'] = placeDetails?.toJson();
    return data;
  }
}
