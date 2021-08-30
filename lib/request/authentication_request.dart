import 'package:flutter_app_food/api/dio_client.dart';

class AuthenticationRequest {
  late DioClient dioClient;

  AuthenticationRequest() {
    dioClient = DioClient.instance;
  }

  Future signUp(String fullName, String email, String phone, String password, String address) {
    return dioClient.dio.post("user/sign-up", data: {
      "fullName": fullName,
      "email": email,
      "phone": phone,
      "password": password,
      "address": address
    });
  }
}
