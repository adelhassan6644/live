// To parse this JSON data, do
//
//     final feedBacks = feedBacksFromJson(jsonString);

import 'dart:convert';

FeedBacks feedBacksFromJson(String str) => FeedBacks.fromJson(json.decode(str));

String feedBacksToJson(FeedBacks data) => json.encode(data.toJson());

class FeedBacks {
    String? status;
    String? message;
    List<Datum>? data;

    FeedBacks({
        this.status,
        this.message,
        this.data,
    });

    factory FeedBacks.fromJson(Map<String, dynamic> json) => FeedBacks(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    double? rating;
    String? comment;
    int? clientId;
    int? placeId;
    String? clientName;
    String? clientImage;
    String? placeName;

    Datum({
        this.rating,
        this.comment,
        this.clientId,
        this.placeId,
        this.clientName,
        this.clientImage,
        this.placeName,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        rating: json["rating"].toDouble(),
        comment: json["comment"],
        clientId: json["client_id"],
        placeId: json["place_id"],
        clientName: json["client_name"],
        clientImage: json["client_image"],
        placeName: json["place_name"],
    );

    Map<String, dynamic> toJson() => {
        "rating": rating,
        "comment": comment,
        "client_id": clientId,
        "place_id": placeId,
        "client_name": clientName,
        "client_image": clientImage,
        "place_name": placeName,
    };
}
