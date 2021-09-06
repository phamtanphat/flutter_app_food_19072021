import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_app_food/model/order_model.dart';
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
}