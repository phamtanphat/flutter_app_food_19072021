import 'package:flutter_app_food/api/dio_client.dart';

class OrderRequest{

  Future getCountCart(){
    return DioClient.instance.dio.get("order/count/shopping-cart");
  }

  Future addCart(String foodId){
    return DioClient.instance.dio.post("order/add-to-cart" , data: {
      "foodId" : foodId
    });
  }
}