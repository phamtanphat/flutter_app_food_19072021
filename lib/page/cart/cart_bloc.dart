import 'dart:async';

import 'package:flutter_app_food/base/base_bloc.dart';
import 'package:flutter_app_food/base/base_event.dart';
import 'package:flutter_app_food/model/cart_model.dart';
import 'package:flutter_app_food/page/cart/cart_event.dart';
import 'package:flutter_app_food/repository/order_repository.dart';

class CartBloc extends BaseBloc{
  StreamController<CartModel> _cartController = StreamController();
  late OrderRepository _orderRepository;

  CartBloc();

  void updateOrderRepository(OrderRepository orderRepository){
    this._orderRepository = orderRepository;
  }

  Stream<CartModel> get streamCartModel => _cartController.stream;

  @override
  void dispose() {
    super.dispose();
    _cartController.close();
  }

  @override
  void dispatch(BaseEvent event) {
    switch(event.runtimeType){
      case CartEventGetList :
        handleGetListCart(event as CartEventGetList);
        break;
    }
  }

  void handleGetListCart(CartEventGetList event) async{
    loadingSink.add(true);
    try{
      CartModel cartModel = await _orderRepository.getListCart();
      _cartController.sink.add(cartModel);
    }catch (e){
      _cartController.sink.addError(e.toString());
    }finally{
      loadingSink.add(false);
    }
  }
}