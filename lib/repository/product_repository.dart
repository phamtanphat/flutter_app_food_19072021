import 'package:flutter_app_food/request/product_request.dart';

class ProductRepository{

  late ProductRequest _request;

  ProductRepository();

  void updateProductRequest(ProductRequest request){
    this._request = request;
  }

  Future getListProducts(){
    
  }
}