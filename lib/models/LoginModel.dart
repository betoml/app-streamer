class LoginResponseModel {
  final String? token;
  final String? message;

  LoginResponseModel({
    this.token,
    this.message,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json["token"] ?? "",
      message: json["error"] != null ? json["message"] : "",
    );
  }
}

class LoginRequestModel {
  String? email;
  String? password;

  LoginRequestModel({
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email?.trim(),
      'password': password?.trim(),
    };

    return map;
  }
}

class TestLoginModel {
  String? message;

  TestLoginModel({
    this.message,
  });
}
