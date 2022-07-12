import 'dart:convert';

import 'package:fake_store/models/single_product.dart';
import 'package:http/http.dart' as http;

import '../models/api_response.dart';
import '../models/login_model.dart';
import '../models/products.dart';

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

  Future<APIResponse<List<Products>>> getAllProducts() {
    return http
        .get(Uri.parse('https://fakestoreapi.com/products'))
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = jsonDecode(data.body);
        final products = <Products>[];
        for (var item in jsonData) {
          products.add(Products.fromJson(item));
        }
        print(products);
        return APIResponse<List<Products>>(
          data: products,
        );
      }
      return APIResponse<List<Products>>(
          error: true, errorMessage: "An error occured");
    }).catchError((_) => APIResponse<List<Products>>(
            error: true, errorMessage: "An error occured"));
  }

  Future<APIResponse<List<String>>> getAllCategories() {
    return http
        .get(Uri.parse('https://fakestoreapi.com/products/categories'))
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = jsonDecode(data.body);
        final categories = <String>[];
        for (var item in jsonData) {
          categories.add(item);
        }
        print("from cat $categories");
        return APIResponse<List<String>>(
          data: categories,
        );
      }
      return APIResponse<List<String>>(
          error: true, errorMessage: "An error occured");
    }).catchError((_) => APIResponse<List<String>>(
            error: true, errorMessage: "An error occured"));
  }

  Future<APIResponse<Product>> getProduct(int id) {
    return http.get(Uri.parse('https://fakestoreapi.com/products/$id')).then(
        (data) {
      if (data.statusCode == 200) {
        final jsonData = jsonDecode(data.body);

        return APIResponse<Product>(
          data: Product.fromJson(jsonData),
        );
      }
      return APIResponse<Product>(
          error: true, errorMessage: "An error occured");
    }).catchError((_) =>
        APIResponse<Product>(error: true, errorMessage: "An error occured"));
  }
}
