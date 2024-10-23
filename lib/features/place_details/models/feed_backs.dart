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
    List<String>? images;
     List<Reply>? replies;

    Datum({
        this.rating,
        this.comment,
        this.clientId,
        this.placeId,
        this.clientName,
        this.clientImage,
        this.placeName,
        this.images,
        this.replies,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        rating: json["rating"].toDouble(),
        comment: json["comment"],
        clientId: json["client_id"],
        placeId: json["place_id"],
        clientName: json["client_name"],
        clientImage: json["client_image"],
        placeName: json["place_name"],
        replies: json["replies"] == null ? [] : List<Reply>.from(json["replies"]!.map((x) => Reply.fromJson(x))),

        images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) =>(x["image"]))),
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
class Reply {
    final String? comment;
    final String? agentImage;
    final String? agentName;
    final DateTime? createdAt;

    Reply({
        this.comment,
        this.agentImage,
        this.agentName,
        this.createdAt,
    });

    factory Reply.fromJson(Map<String, dynamic> json) => Reply(
        comment: json["comment"],
        agentImage: json["agent_image"],
        agentName: json["agent_name"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "comment": comment,
        "agent_image": agentImage,
        "agent_name": agentName,
        "created_at": createdAt?.toIso8601String(),
    };
}

