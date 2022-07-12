import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/api_response.dart';
import '../models/login_model.dart';

class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com/auth/login';

  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    final response =
        await http.post(Uri.parse(baseUrl), body: requestModel.toJson());
    if (response.statusCode == 200) {
      print(response.statusCode);
      return LoginResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Invalid login");
    }
  }
}
