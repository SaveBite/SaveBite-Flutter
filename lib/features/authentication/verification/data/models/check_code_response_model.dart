
import '../../domain/entity/check_code_response_entity.dart';

class CheckCodeResponseModel extends CheckCodeResponseEntity {
  CheckCodeResponseModel(
      {required super.name,
      required super.email,
      required super.type,
      required super.is_verified,
      required super.token});

  factory CheckCodeResponseModel.fromJson(Map<String, dynamic> json) {
    return CheckCodeResponseModel(
      name: json["name"],
      email: json["email"],
      type: json["type"],
      is_verified: json["is_verified"],
      token: json["token"],
    );
  }


  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "type": type,
    "is_verified": is_verified,
    "token": token,
  };
}
