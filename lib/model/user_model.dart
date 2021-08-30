
class UserModel {
  String? userId;
  String? fullName;
  String? email;
  String? phone;
  String? address;
  String? token;

  UserModel({
    this.userId,
    this.fullName,
    this.email,
    this.address,
    this.phone,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
        userId: json['userId'],
        fullName: json['fullName'],
        email: json['email'],
        phone: json['phone'],
        address: json['address'],
        token: json['token']
    );
  }

  @override
  String toString() {
    return 'UserModel{userId: $userId, fullName: $fullName, email: $email, phone: $phone, address: $address, token: $token}';
  }

  static UserModel fromJsonModel(Map<String, dynamic> json) => UserModel.fromJson(json);


}