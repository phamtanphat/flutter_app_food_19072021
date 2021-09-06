import 'package:flutter_app_food/api/dio_client.dart';

class ProductRequest{

  //end point
  Future getListProduct(){
    return DioClient.instance.dio.get("food/list/0/10");
  }
}