import 'package:dmart_android_flutter/domain/models/base/displayname.dart';
import 'package:dmart_android_flutter/domain/models/base/error.dart';

class CreateUserRequestModel {
  late CreateUserAttributes attributes;

  CreateUserRequestModel({
    required this.attributes,
  });

  Map<String, dynamic> toJson() => {
        'shortname': "auto",
        'subpath': "users",
        'resource_type': "user",
        'attributes': attributes.toJson(),
      };
}

class CreateUserAttributes {
  late String invitation;
  late Displayname displayname;
  late String email;
  late String? profilePicUrl;
  late String msisdn;
  late String password;

  CreateUserAttributes({
    required this.invitation,
    required this.displayname,
    required this.email,
    this.profilePicUrl,
    required this.msisdn,
    required this.password,
  });

  factory CreateUserAttributes.fromJson(Map<String, dynamic> json) =>
      CreateUserAttributes(
        invitation: json['invitation'],
        displayname: Displayname.fromJson(json['displayname']),
        email: json['email'],
        profilePicUrl: json['profile_pic_url'],
        msisdn: json['msisdn'],
        password: json['password'],
      );

  Map<String, dynamic> toJson() => {
        'invitation': invitation,
        'displayname': displayname.toJson(),
        'email': email,
        'profile_pic_url': profilePicUrl,
        'msisdn': msisdn,
        'password': password,
    'is_active': true,
      };
}

class CreateUserResponseModel {
  late String status;
  ErrorModel? error;

  CreateUserResponseModel({
    required this.status,
    this.error,
  });

  factory CreateUserResponseModel.fromJson(Map<String, dynamic> json) =>
      CreateUserResponseModel(
        status: json['status'],
        error:
            json['error'] != null ? ErrorModel.fromJson(json['error']) : null,
      );
}
