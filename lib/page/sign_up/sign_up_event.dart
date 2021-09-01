import 'package:flutter_app_food/base/base_event.dart';

abstract class SignUpEventBase extends BaseEvent{

}

class SignUpEvent extends SignUpEventBase{
  final String fullName;
  final String email;
  final String phone;
  final String password;
  final String address;

  SignUpEvent({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
    required this.address,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SignUpSuccess extends SignUpEventBase{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SignUpFail extends SignUpEventBase{
  String message;

  SignUpFail({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}