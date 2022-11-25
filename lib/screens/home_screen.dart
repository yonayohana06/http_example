import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_example/models/product_model.dart';
import 'package:http_example/screens/product_detail.dart';
import 'package:http_example/widgets/string_extension.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Product> _products = [];

  bool _loading = false;

  @override
  void initState() {
    _fetchProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products List'),
      ),
      body: Builder(
        builder: (context) {
          if (_loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (_products.isEmpty) {
            return const Center(
              child: Text('No Product'),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.only(
              top: 15,
              left: 10,
              right: 10,
              bottom: 60,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1 / 1.7,
              crossAxisCount: 2,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
            ),
            itemCount: _products.length,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              final product = _products[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ProductDetail(product: product);
                      },
                    ),
                  );
                },
                child: Card(
                  elevation: 2,
                  clipBehavior: Clip.antiAlias,
                  child: SizedBox(
                    width: 160.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 160,
                          width: 160,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                product.thumbnail,
                              ),
                              fit: BoxFit.cover,
                            ),
                            color: Colors.cyan[400],
                          ),
                          child: Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6.0),
                                margin: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Colors.red[800],
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                      12.0,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  "Discount ${product.discountPercentage}%",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 8.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6.0),
                              // Row(
                              //   crossAxisAlignment: CrossAxisAlignment.center,
                              //   children: [
                              //     const Text(
                              //       "Rating",
                              //       style: TextStyle(
                              //         fontSize: 10.0,
                              //       ),
                              //     ),
                              //     const SizedBox(width: 4.0),
                              //     const Icon(
                              //       Icons.circle,
                              //       size: 4.0,
                              //     ),
                              //     const SizedBox(width: 4.0),
                              //     Icon(
                              //       Icons.star,
                              //       color: Colors.orange[400],
                              //       size: 16.0,
                              //     ),
                              //     Text(
                              //       product.rating.toString(),
                              //       style: const TextStyle(
                              //         fontSize: 10.0,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              const SizedBox(height: 6.0),
                              Text(
                                product.brand,
                                style: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 10.0,
                                ),
                              ),
                              Text(
                                product.category.toCapitalized(),
                                style: const TextStyle(
                                  fontSize: 10.0,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                '\$ ${product.price.toString()}',
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _fetchProduct() async {
    _loading = true;
    await Future.delayed(const Duration(seconds: 1));
    final url = Uri.parse('https://dummyjson.com/products');
    final response = await http.get(url);
    final bodyString = response.body;
    final body = jsonDecode(bodyString);
    final productsList = body['products'] as List;
    final productClean = productsList
        .map<Product>((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList();
    _products.addAll(productClean);
    _loading = false;
    setState(() {});
  }
}
