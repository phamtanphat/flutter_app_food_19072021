import 'package:flutter_app_food/base/base_bloc.dart';
import 'package:flutter_app_food/base/base_event.dart';
import 'package:flutter_app_food/data/constants/key.dart';
import 'package:flutter_app_food/data/share_pre/share_preference.dart';
import 'package:flutter_app_food/model/response_model.dart';
import 'package:flutter_app_food/model/user_model.dart';
import 'package:flutter_app_food/page/sign_in/sign_in_event.dart';
import 'package:flutter_app_food/repository/authentication_repository.dart';

class SignInBloc extends BaseBloc{

  late AuthenticationRepository _repository;

  SignInBloc();

  void updateRepository(AuthenticationRepository authenticationRepository){
    this._repository = authenticationRepository;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void dispatch(BaseEvent event) {
    switch(event.runtimeType){
      case SignInEvent :
        handleSignIn(event as SignInEvent);
        break;
    }
  }

  void handleSignIn(SignInEvent event) {
    loadingSink.add(true);
    Future.delayed(Duration(seconds: 2) , () async{
      try{
        ResponseModel<UserModel> responseModel = await _repository.signIn(event.email, event.password);
        String? token = responseModel.data!.token;
        if(token != null){
          SPref.instance.set(ConstantKey.TOKEN, token);
        }
        progressSink.add(SignInSuccess());
      }catch(e){
        progressSink.add(SignInFail(message: e.toString()));
      }finally{
        loadingSink.add(false);
      }
    });
  }

}