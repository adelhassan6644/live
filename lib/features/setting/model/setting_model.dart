class SettingModel {
  String? message;
  Data? data;

  SettingModel({this.message, this.data});

  SettingModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? terms;
  String? name;
  String? email;
  String? twitter;
  String? website;
  String? instagram;
  String? facebook;
  String? tiktok;
  String? youtube;
  String? snapchat;

  String? homeTwitter;
  String? homeWebsite;
  String? homeWatsApp;
  String? homeInstagram;
  String? homeFacebook;
  String? homeTiktok;
  String? homeYoutube;
  String? homeSnapchat;
  String? image;
  String? phone;
  String? aboutUs;
  String? downloads;
  String? visits;
  String? subscribers;
  String? buildings;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.terms,
      this.name,
      this.email,
      this.twitter,
      this.website,
      this.instagram,
      this.youtube,
      this.facebook,
      this.tiktok,
      this.snapchat,
      this.image,
      this.phone,
      this.aboutUs,
        this.homeTwitter,
        this.homeWatsApp,
        this.homeWebsite,
        this.homeInstagram,
        this.homeFacebook,
        this. homeTiktok,
        this.homeYoutube,
        this. homeSnapchat,
        this. downloads,
        this. visits,
        this. subscribers,
        this. buildings,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    terms = json['terms'];
    email = json['email'];
    twitter = json['twitter'];
    website = json['website'];
    instagram = json['instagram'];
    facebook = json['facebook'];
    tiktok = json['tiktok'];
    snapchat = json['snapchat'];
   homeTwitter=json['show_on_home_twitter'];
    homeWebsite=json['show_on_home_website'];
   homeInstagram=json['show_on_home_instagram'];
    homeFacebook=json['show_on_home_facebook'];
   homeTiktok=json['show_on_home_tiktok'];
    homeYoutube=json['show_on_home_youtube'];
    homeWatsApp=json['show_on_home_whatsapp'];
     homeSnapchat==json['show_on_home_snapchat'];
    image = json['image'];
    phone = json['phone'];
    aboutUs = json['aboutUs'];
    youtube = json['youtube'];
    downloads = json['downloads'].toString();
    visits = json['visits'].toString();
    subscribers = json['subscribers'].toString();
    buildings = json['buildings'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['terms'] = terms;
    data['name'] = this.name;
    data['email'] = this.email;
    data['twitter'] = this.twitter;
    data['website'] = this.website;
    data['instagram'] = this.instagram;
    data['facebook'] = this.facebook;
    data['tiktok'] = this.tiktok;
    data['image'] = this.image;
    data['phone'] = this.phone;
    data['aboutUs'] = this.aboutUs;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
