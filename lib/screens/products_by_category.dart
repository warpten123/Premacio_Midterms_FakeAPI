import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../models/api_response.dart';

import '../models/products.dart';
import '../services/api_service.dart';
import 'product_detail.dart';

class ProductsByCategoryScreen extends StatefulWidget {
  final String categoryName;

  const ProductsByCategoryScreen({Key? key, required this.categoryName})
      : super(key: key);

  @override
  State<ProductsByCategoryScreen> createState() =>
      _ProductsByCategoryScreenState();
}

class _ProductsByCategoryScreenState extends State<ProductsByCategoryScreen> {
  ApiService get apiservice => GetIt.instance<ApiService>();
  late APIResponse<List<Products>> _apiResponse;
  @override
  void initState() {
    getProductsByCategory(widget.categoryName);
    super.initState();
  }

  Future<APIResponse<List<Products>>> getProductsByCategory(
      String catName) async {
    return _apiResponse = await apiservice.getProductsByCategory(catName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder(
        future: getProductsByCategory(widget.categoryName),
        builder: (BuildContext context,
            AsyncSnapshot<APIResponse<List<Products>>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final products = snapshot.data!;

          return ListView.separated(
            separatorBuilder: (_, __) => const Divider(thickness: 1),
            itemCount: products.data!.length,
            itemBuilder: ((context, index) {
              return ListTile(
                title: Text(products.data![index].title),
                leading: Image.network(
                  products.data![index].image,
                  height: 50,
                  width: 50,
                ),
                subtitle: Text('\$${products.data![index].price}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ProductDetailScreen(id: products.data![index].id),
                    ),
                  );
                },
              );
            }),
          );
        },
      ),
    );
  }
}
