import 'package:flutter/cupertino.dart';

import '../../home/widgets/home_banners.dart';
import '../../home/widgets/home_categories.dart';
import '../../home/widgets/home_news.dart';
import '../../home/widgets/home_offers.dart';
import '../../home/widgets/home_places.dart';
import '../../home/widgets/home_search.dart';
import '../../home/widgets/homestatistics.dart';

class ContactModel {
  int? id;
  String? email;
  String? twitter;
  String? website;
  String? whatsapp;
  String? phone;
  List<Widget> sections;
  String? downloads;
  String? visits;
  String? subscribers;
  String? buildings;
  String? homeTitle;
  String? homeSlugen;

  ContactModel({
    this.id,
    this.email,
    this.twitter,
    this.website,
    this.whatsapp,
    this.phone,
    this. downloads,
    this. visits,
    this. subscribers,
    this. buildings,
    this. homeSlugen,
    this. homeTitle,
    required this.sections,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
        id: json["id"],
        email: json["email"],
        twitter: json["twitter"],
        website: json["website"],
        whatsapp: json["whatsapp"],
        phone: json["phone"],
    homeTitle: json["home_title"],
    homeSlugen: json["home_slogan"],
    sections: _getSections(json['sections'] as List<dynamic>),
      downloads :json['downloads'].toString(),
      visits : json['visits'].toString(),
  subscribers : json['subscribers'].toString(),
  buildings :json['buildings'].toString(),


  );
  static List<Widget> _getSections(List<dynamic> sectionsJson) {
    return sectionsJson.map((section) {
      switch (section) {

          case 'HomePlaces()':
          return HomePlaces();
        case 'HomeCategories()':
          return HomeCategories();
        case 'HomeNews()':
          return HomeNews();
        case 'HomeOffers()':
          return HomeOffers();
        case 'HomeBanner()':
          return HomeBanner();
          case 'HomeStatistics()':
          return HomeStatistics();
        default:
          return Container(); // Return a default widget if the type is unknown
      }
    }).toList();
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "twitter": twitter,
        "website": website,
        "whatsapp": whatsapp,
        "phone": phone,
      };
}
