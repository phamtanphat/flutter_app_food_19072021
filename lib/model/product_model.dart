import 'image_model.dart';

class ProductModel{
  String? foodId;
  String? foodName;
  List<ImageModel>? images;
  String? description;
  int? price;
  String? cateId;
  String? cateName;
  String? createdAt;
  String? updatedAt;
  int? quantity;

  ProductModel(
      {this.foodId,
        this.foodName,
        this.images,
        this.description,
        this.price,
        this.cateId,
        this.cateName,
        this.createdAt,
        this.updatedAt,
        this.quantity});
  ProductModel.fromJson(Map<String ,dynamic> json){
    foodId = json['foodId'];
    foodName = json['foodName'];
    if (json['images'] != null) {
      images = (json['images'] as List).map((image) => ImageModel.fromJson(image)).toList();
    }
    description = json['description'];
    price = json['price'];
    cateId = json['cateId'];
    cateName = json['cateName'];
    quantity = json['quantity'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }


  static List<ProductModel> pareJsonModelToList(List lst){
    List<ProductModel> data = lst.map((json) => ProductModel.fromJson(json)).toList();
    return data;
  }
  static ProductModel fromJsonModel(Map<String, dynamic> json) => ProductModel.fromJson(json);

}