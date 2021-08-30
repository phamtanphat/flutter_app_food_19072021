import 'package:dio/dio.dart';
import 'package:flutter_app_food/model/response_model.dart';
import 'package:flutter_app_food/model/user_model.dart';
import 'package:flutter_app_food/request/authentication_request.dart';

class AuthenticationRepository {
  late AuthenticationRequest authenticationRequest;

  AuthenticationRepository();

  void updateAuthenticationRequest(AuthenticationRequest authenticationRequest){
    this.authenticationRequest = authenticationRequest;
  }

  // Future

  Future signUp(String fullName,String email,String phone,String password,String address) async{
    try{
      Response response = await authenticationRequest.signUp(fullName, email, phone, password, address);
      if (response.statusCode == 200){
        ResponseModel<UserModel> data = ResponseModel.fromJson(response.data, UserModel.fromJsonModel);
        print(data.data.toString());
      }else{
        print("Loi");
      }
    }catch(e){
      print(e.toString());
    }
  }
}

