class ReviewsModel {
    final String? status;
    final String? message;
    final List<ReviewItem>? data;

    ReviewsModel({
        this.status,
        this.message,
        this.data,
    });

    factory ReviewsModel.fromJson(Map<String, dynamic> json) => ReviewsModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<ReviewItem>.from(json["data"]!.map((x) => ReviewItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class ReviewItem {
    final int? rating;
    final String? comment;
    final int? clientId;
    final int? placeId;
    final String? clientName;
    final dynamic clientImage;
    final String? placeName;

    ReviewItem({
        this.rating,
        this.comment,
        this.clientId,
        this.placeId,
        this.clientName,
        this.clientImage,
        this.placeName,
    });

    factory ReviewItem.fromJson(Map<String, dynamic> json) => ReviewItem(
        rating: json["rating"],
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
