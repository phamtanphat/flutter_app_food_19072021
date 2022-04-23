import 'dart:async';

import 'package:flutter_app_food/base/base_bloc.dart';
import 'package:flutter_app_food/base/base_event.dart';
import 'package:flutter_app_food/page/demo/demo_event.dart';
import 'package:flutter_app_food/repository/order_repository.dart';
import 'package:flutter_app_food/repository/product_repository.dart';

class DemoBloc extends BaseBloc {
  StreamController<String> _textController = StreamController();

  Stream<String> get textData => _textController.stream;

  StreamController<String> _textController2 = StreamController();

  Stream<String> get textData2 => _textController2.stream;

  late ProductRepository _productRepository;
  late OrderRepository _orderRepository;

  void updateProductRepository(ProductRepository productRepository) {
    this._productRepository = productRepository;
  }

  void updateOrderRepository(OrderRepository orderRepository) {
    this._orderRepository = orderRepository;
  }

  @override
  void dispatch(BaseEvent event) {
    switch (event.runtimeType) {
      case FetchOrderEvent:
        print("Call APi1");
        callApi1();
        break;
      case FetchOrderEvent2:
        print("Call APi2");
        callApi2();
        break;
    }
  }

  void callApi1() async {
    loadingSink.add(true);
    try {
      var data = await Future.delayed(Duration(seconds: 7), () => "Success");
      _textController.sink.add(data);
    } catch (e) {}
  }

  @override
  void dispose() {
    super.dispose();
    _textController.close();
    _textController2.close();
  }

  void callApi2() async {
    loadingSink.add(true);
    try {
      var data = await Future.delayed(Duration(seconds: 5), () => "Hello");
      _textController2.sink.add(data);
    } catch (e) {}
  }
}
