class LoginModel {
  final String username;
  final String? token;
  final String? email;
  final String password;
  final String? fcmToken;
  LoginModel({
    required this.fcmToken,
    required this.username,
    this.token,
    this.email,
    required this.password,
  });
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      fcmToken: json['fcm_token'],
      username: json['username'],
      token: json['token'],
      email: json['email'],
      password: json['password'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'fcm_token': fcmToken,
      'username': username,
      'token': token,
      'email': email,
      'password': password,
    };
  }
}
