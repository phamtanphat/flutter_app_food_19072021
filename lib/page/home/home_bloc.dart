import 'dart:async';

import 'package:flutter_app_food/base/base_bloc.dart';
import 'package:flutter_app_food/base/base_event.dart';
import 'package:flutter_app_food/model/order_model.dart';
import 'package:flutter_app_food/model/product_model.dart';
import 'package:flutter_app_food/page/home/home_event.dart';
import 'package:flutter_app_food/repository/order_repository.dart';
import 'package:flutter_app_food/repository/product_repository.dart';

class HomeBloc extends BaseBloc{
  StreamController<List<ProductModel>> _listProductModelController = StreamController();
  StreamController<OrderModel> _orderModelController = StreamController();
  late ProductRepository _productRepository;
  late OrderRepository _orderRepository;

  HomeBloc();

  void updateProductRepository(ProductRepository productRepository){
    this._productRepository = productRepository;
  }

  void updateOrderRepository(OrderRepository orderRepository){
    this._orderRepository = _orderRepository;
  }


  Stream<List<ProductModel>> get listProductStream => _listProductModelController.stream;

  @override
  void dispatch(BaseEvent event) {
    switch(event.runtimeType){
      case HomeEventGetListProduct:
        handleGetListProducts(event as HomeEventGetListProduct);
        break;
    }
  }

  void handleGetListProducts(HomeEventGetListProduct event) async{
    loadingSink.add(true);
    try{
      OrderModel orderModel = await _orderRepository.getCountCart();
      _orderModelController.sink.add(orderModel);
      List<ProductModel> listProduct = await _productRepository.getListProducts();
      _listProductModelController.sink.add(listProduct);
    }catch (e){
      _listProductModelController.sink.addError(e.toString());
    }finally{
      loadingSink.add(false);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _listProductModelController.close();
    _orderModelController.close();
  }



}