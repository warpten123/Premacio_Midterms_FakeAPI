import 'package:fake_store/screens/test.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../models/api_response.dart';
import '../models/product.dart';
import '../services/api_service.dart';
import 'all_category.dart';
import 'cart_screen.dart';
import 'product_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  ApiService get apiservice => GetIt.instance<ApiService>();
  late APIResponse<List<Product>> _apiResponse;
  @override
  void initState() {
    getAllProducts();
    super.initState();
  }

  Future<APIResponse<List<Product>>> getAllProducts() async {
    return _apiResponse = await apiservice.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.view_list),
            onPressed: () => Navigator.push(
              context,

              MaterialPageRoute(builder: (_) => const AllCategoryScreen()),
              // MaterialPageRoute(builder: (_) => const test()),

            ),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                // builder: (_) => const CartScreen(),
                builder: (_) => const test(),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
            future: getAllProducts(),
            builder: (_, AsyncSnapshot<APIResponse<List<Product>>> snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }
              final products = snapshot.data!;
              return ListView.separated(
                separatorBuilder: (_, __) => const Divider(thickness: 1),
                itemCount: products.data!.length,
                itemBuilder: ((context, index) {
                  final product = snapshot.data!.data![index];
                  return ListTile(
                    title: Text(product.title),
                    leading: Image.network(
                      product.image,
                      height: 50,
                      width: 50,
                    ),
                    subtitle: Text(product.price.toString()),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          // builder: (_) => ProductDetailScreen(),
                          builder: (_) => test(),
                        ),
                      );
                    },
                  );
                }),
              );
            }),
      ),
    );
  }
}
