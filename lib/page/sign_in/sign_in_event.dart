import 'package:flutter_app_food/base/base_event.dart';

abstract class SignInEventBase extends BaseEvent{

}

class SignInEvent extends SignInEventBase{
  final String email;
  final String password;

  SignInEvent({required this.email , required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SignInSuccess extends SignInEventBase{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SignInFail extends SignInEventBase{
  final String message;

  SignInFail({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}