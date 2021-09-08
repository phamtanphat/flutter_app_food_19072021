import 'package:flutter_app_food/base/base_event.dart';
import 'package:flutter_app_food/model/order_model.dart';

abstract class HomeEventBase extends BaseEvent{

}
class HomeEventOrderCount extends HomeEventBase{
  @override
  List<Object?> get props => [];
}

class HomeEventGetListProduct extends HomeEventBase{

  @override
  List<Object?> get props => [];

}

class HomeEventAddCart extends HomeEventBase{
  final String foodId;

  HomeEventAddCart({required this.foodId});

  @override
  List<Object?> get props => [];

}

class HomeEventGetOrderSuccess extends HomeEventBase{

  HomeEventGetOrderSuccess();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomeEventGetOrderNotInit extends HomeEventBase{
  final String message;

  HomeEventGetOrderNotInit({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

