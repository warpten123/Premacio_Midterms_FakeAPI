import 'dart:convert';

import 'package:fake_store/models/single_product.dart';
import 'package:http/http.dart' as http;

import '../models/api_response.dart';
import '../models/cart.dart';
import '../models/cart_update.dart';
import '../models/login_model.dart';
import '../models/products.dart';

class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com';

  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    final response = await http.post(
        Uri.parse('https://fakestoreapi.com/auth/login'),
        body: requestModel.toJson());
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

  Future<APIResponse<List<Products>>> getProductsByCategory(
      String categoryName) {
    return http
        .get(Uri.parse(
            'https://fakestoreapi.com/products/category/$categoryName'))
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

  Future<Cart?> getCart(String id) {
    return http.get(Uri.parse('$baseUrl/carts/$id')).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return Cart.fromJson(jsonData);
      }
      return null;
    }).catchError((err) => print(err));
  }

  Future<APIResponse<bool>> deleteCart(String id) {
    return http
        .delete(
      Uri.parse('https://fakestoreapi.com/carts/$id'),
    )
        .then((data) {
      if (data.statusCode == 204) {
        print(data);
        return APIResponse<bool>(
          data: true,
        );
      }
      return APIResponse<bool>(error: true, errorMessage: "An error occured");
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: "An error occured"));
  }

  Future<APIResponse<bool>> updateCart(int cartId, int productId) {
    final cartUpdate = CartUpdate(
        id: productId,
        userId: cartId,
        date: DateTime.now(),
        products: [
          {'productId': productId, 'quantity': 3}
        ]);
    return http
        .put(Uri.parse('https://fakestoreapi.com/carts/$cartId'),
            body: json.encode(cartUpdate.toJson()))
        .then((data) {
      if (data.statusCode == 200) {
        return APIResponse<bool>(
          data: true,
        );
      }
      return APIResponse<bool>(error: true, errorMessage: "An error occured");
    }).catchError((err) => print(err));
  }
}///end service
