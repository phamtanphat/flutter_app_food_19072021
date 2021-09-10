import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_app_food/model/cart_model.dart';
import 'package:flutter_app_food/model/order_model.dart';
import 'package:flutter_app_food/model/product_model.dart';
import 'package:flutter_app_food/request/order_request.dart';

class OrderRepository{
  late OrderRequest _orderRequest;

  OrderRepository();

  void updateOrderRequest(OrderRequest orderRequest){
    this._orderRequest = orderRequest;
  }


  Future<OrderModel> getCountCart() async{
    Completer<OrderModel> completer = Completer();
    try{
      Response response = await _orderRequest.getCountCart();
      if (response.statusCode == 200){
        OrderModel orderModel = OrderModel.fromJson(response.data['data']);
        completer.complete(orderModel);
      }
    }on DioError catch (dioError){
      completer.completeError(dioError.response?.data["message"]);
    } catch(e){
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  Future<OrderModel> addProductToCart(String foodId) async{
    Completer<OrderModel> completer = Completer();
    try{
      Response response = await _orderRequest.addCart(foodId);
      if (response.statusCode == 200){
        OrderModel orderModel = OrderModel.fromJson(response.data['data']);
        completer.complete(orderModel);
      }
    }on DioError catch (dioError){
      completer.completeError(dioError.response?.data["message"]);
    } catch(e){
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  Future<CartModel> getListCart() async{
    Completer<CartModel> completer = Completer();
    try{
      Response response = await _orderRequest.getListCart();
      if (response.statusCode == 200){
        CartModel cartModel = CartModel.fromJson(response.data['data']);
        completer.complete(cartModel);
      }
    }on DioError catch (dioError){
      completer.completeError(dioError.response?.data["message"]);
    } catch(e){
      completer.completeError(e.toString());
    }
    return completer.future;
  }
}