import 'package:flutter_app_food/request/authentication_request.dart';

class AuthenticationRepository {
  late AuthenticationRequest authenticationRequest;

  AuthenticationRepository();

  void updateAuthenticationRequest(AuthenticationRequest authenticationRequest){
    this.authenticationRequest = authenticationRequest;
  }

  // Future
}

