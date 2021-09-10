import 'package:flutter_app_food/model/product_model.dart';

class CartModel {
  late int total;
  late List<ProductModel> items;

  CartModel({required this.total,required this.items});

  CartModel.fromJson(Map<String,dynamic> json){
    this.total = json['total'];
    this.items = (json['items'] as List).map((data) => ProductModel.fromJson(data)).toList();
  }
}