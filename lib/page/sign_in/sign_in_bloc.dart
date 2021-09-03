import 'package:flutter_app_food/base/base_bloc.dart';
import 'package:flutter_app_food/base/base_event.dart';
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
  }

}