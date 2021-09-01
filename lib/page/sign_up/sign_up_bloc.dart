import 'dart:async';

import 'package:flutter_app_food/base/base_bloc.dart';
import 'package:flutter_app_food/base/base_event.dart';
import 'package:flutter_app_food/model/response_model.dart';
import 'package:flutter_app_food/model/user_model.dart';
import 'package:flutter_app_food/page/sign_up/sign_up_event.dart';
import 'package:flutter_app_food/repository/authentication_repository.dart';

class SignUpBloc extends BaseBloc {
  late AuthenticationRepository _authenRepo;


  SignUpBloc();

  void updateAuthenticationRepository(
      AuthenticationRepository authenticationRepository) {
    this._authenRepo = authenticationRepository;
  }

  @override
  void dispatch(BaseEvent event) {
    switch (event.runtimeType) {
      case SignUpEvent:
        handleSignUp(event as SignUpEvent);
        break;
    }
  }

  void handleSignUp(SignUpEvent event)  {
    loadingSink.add(true);
    Future.delayed(Duration(seconds: 2) , () async{
      try {
        ResponseModel<UserModel> responseModel = await _authenRepo.signUp(
            event.fullName,
            event.email,
            event.phone,
            event.password,
            event.address);
        UserModel userModel = responseModel.data!;
        print(userModel.toString());
        loadingSink.add(false);
      } catch (e) {
        print(e);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

  }
}
