import 'dart:async';

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

  Future<ResponseModel<UserModel>> signUp(String fullName,String email,String phone,String password,String address) async{
    Completer<ResponseModel<UserModel>> completer = Completer<ResponseModel<UserModel>>();
    try{
      Response response = await authenticationRequest.signUp(fullName, email, phone, password, address);
      if (response.statusCode == 200){
        ResponseModel<UserModel> data = ResponseModel.fromJson(response.data, UserModel.fromJsonModel);
        completer.complete(data);
      }
    } on DioError catch (dioError){
      completer.completeError(dioError.response?.data["message"]);
    }
    catch(e){
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  Future<ResponseModel<UserModel>> signIn(String email,String password) async{
    Completer<ResponseModel<UserModel>> completer = Completer<ResponseModel<UserModel>>();
    try{
      Response response = await authenticationRequest.signIn(email,password);
      if (response.statusCode == 200){
        ResponseModel<UserModel> data = ResponseModel.fromJson(response.data, UserModel.fromJsonModel);
        completer.complete(data);
      }
    } on DioError catch (dioError){
      completer.completeError(dioError.response?.data["message"]);
    }
    catch(e){
      completer.completeError(e.toString());
    }
    return completer.future;
  }
}


