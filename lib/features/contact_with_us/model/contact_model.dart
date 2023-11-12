class ContactModel {
  int? id;
  String? email;
  String? twitter;
  String? website;
  String? whatsapp;
  String? phone;

  ContactModel({
    this.id,
    this.email,
    this.twitter,
    this.website,
    this.whatsapp,
    this.phone,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
        id: json["id"],
        email: json["email"],
        twitter: json["twitter"],
        website: json["website"],
        whatsapp: json["whatsapp"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "twitter": twitter,
        "website": website,
        "whatsapp": whatsapp,
        "phone": phone,
      };
}
