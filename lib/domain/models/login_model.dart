import 'package:dmart/dmart.dart';

class LoginRequestModel {
  String shortname;
  String password;

  LoginRequestModel({required this.shortname, required this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shortname'] = shortname;
    data['password'] = password;
    return data;
  }
}

class LoginResponseModel extends BaseResponse {
  String? token;
  UserType? type;
  Displayname? displayname;
  Error? error;

  LoginResponseModel({this.token, required super.status, super.records});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    status = Status.values.byName(json['status']);
    if (status == Status.failed) {
      error = Error.fromJson(json['error']);
      return;
    }
    if (json['records'] != null && json['records']!.isNotEmpty) {
      records = [];
      Record record = Record.fromJson(json['records'][0]);
      records?.add(record);
      LoginAttributes? attribute = LoginAttributes.fromJson(record.attributes);
      token = attribute.accessToken;
      type = UserType.values.byName(attribute.type ?? 'web');
      displayname = attribute.displayname;
    }
  }
}

class LoginAttributes {
  String? accessToken;
  String? type;
  Displayname? displayname;

  LoginAttributes({this.accessToken, this.type, this.displayname});

  LoginAttributes.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    type = json['type'];
    displayname = json['displayname'] != null
        ? Displayname.fromJson(json['displayname'])
        : null;
  }
}
