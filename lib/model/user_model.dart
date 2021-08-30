class UserModel{
  String? userId;
  String? fullName;
  String? email;
  String? address;
  String? token;

  UserModel({
    this.userId,
    this.fullName,
    this.email,
    this.address,
    this.token,
  });

  @override
  String toString() {
    return 'UserModel{userId: $userId, fullName: $fullName, email: $email, address: $address, token: $token}';
  }
}