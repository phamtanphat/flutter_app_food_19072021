import 'dart:async';

import 'package:flutter_app_food/base/base_bloc.dart';
import 'package:flutter_app_food/base/base_event.dart';
import 'package:flutter_app_food/model/product_model.dart';
import 'package:flutter_app_food/page/home/home_event.dart';
import 'package:flutter_app_food/repository/product_repository.dart';

class HomeBloc extends BaseBloc{
  StreamController<List<ProductModel>> _listProductModelController = StreamController();
  late ProductRepository _productRepository;

  HomeBloc();

  void updateProductRepository(ProductRepository productRepository){
    this._productRepository = productRepository;
  }

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
  }

}