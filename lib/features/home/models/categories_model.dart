class CategoriesModel {
  String? message;
  List<CategoryItem>? data;

  CategoriesModel({this.message, this.data});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(CategoryItem.fromJson(v));
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

class CategoryItem {
  int? id;
  String? image;
  String? title;
  String? color;
  String? textColor;
  String? description;
  String? createdAt;
  String? updatedAt;
  List<SubCategory>? subCategory;

  CategoryItem(
      {this.id,
      this.image,
      this.title,
      this.description,
      this.color,
      this.textColor,
      this.createdAt,
        this.subCategory,
      this.updatedAt});

  CategoryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    color = json['color'];
    textColor = json['text_color'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    subCategory= json["sub_category"] == null ? [] : List<SubCategory>.from(json["sub_category"]!.map((x) => SubCategory.fromJson(x)));

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['title'] = title;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
class SubCategory {
  int? id;
  String? title;
  int? categoryId;
  String? color;
  String? textColor;
  String? description;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  SubCategory({
    this.id,
    this.title,
    this.categoryId,
    this.color,
    this.textColor,
    this.description,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    id: json["id"],
    title: json["title"],
    categoryId: json["category_id"],
    color: json["color"],
    textColor: json["text_color"],
    description: json["description"],
    image: json["image"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "category_id": categoryId,
    "color": color,
    "text_color": textColor,
    "description": description,
    "image": image,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

