class ProfileModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  DateTime? createdAt;

  ProfileModel(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.image,
      this.createdAt});

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["id"],
        name: json["first_name"],
        phone: json["phone"],
        email: json["email"],
        image: json["image"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": name,
        "email": email,
        "phone": phone,
        "image": image,
        "created_at": createdAt?.toIso8601String(),
      };
}
