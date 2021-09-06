import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_app_food/model/product_model.dart';
import 'package:flutter_app_food/model/response_model.dart';
import 'package:flutter_app_food/request/product_request.dart';

class ProductRepository{

  late ProductRequest _request;

  ProductRepository();

  void updateProductRequest(ProductRequest request){
    this._request = request;
  }

  Future<List<ProductModel>> getListProducts() async{
    Completer<List<ProductModel>> completer = Completer();
    try{
      Response response = await _request.getListProduct();
      if (response.statusCode == 200){

        // var lst = response.data['data'] as List;
        // List<ProductModel> lstProduct = lst.map((json) => ProductModel.fromJson(json)).toList();
        // print(lstProduct.length.toString());

        ResponseModel<List<ProductModel>> responseModel = ResponseModel.fromJson(response.data, ProductModel.pareJsonModelToList);
        if (responseModel.code == 200){
          completer.complete(responseModel.data);
        }
      }
    } on DioError catch (dioError){
      completer.completeError(dioError.response?.data["message"]);
    }
    catch(e){
      completer.completeError(e.toString());
    }
    return completer.future;
  }
}