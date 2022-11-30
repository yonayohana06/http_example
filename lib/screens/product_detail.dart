import 'package:flutter/material.dart';
import 'package:http_example/models/product_model.dart';
import 'package:http_example/widgets/rating_product.dart';
import 'package:http_example/widgets/string_extension.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    final discount =
        product.price - (product.price * product.discountPercentage / 100);
    final priceDiscount = double.parse(discount.toStringAsFixed(1));

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            SizedBox(
              width: width,
              child: Column(
                children: [
                  Container(
                    height: 200.0,
                    width: width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          product.thumbnail,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            color: Colors.red[800],
                          ),
                          child: Text(
                            "Discount ${product.discountPercentage}%",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\$ $priceDiscount',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '\$ ${product.price}',
                              style: const TextStyle(
                                color: Colors.red,
                                decoration: TextDecoration.lineThrough,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                RatingProduct(
                                  rating: product.rating.toDouble(),
                                ),
                                Text(
                                  product.rating.toString(),
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 12.0),
                        Text(
                          product.title,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6.0),
                        Row(
                          children: [
                            Text(
                              product.brand,
                              style: const TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                              child: Icon(
                                Icons.circle,
                                size: 5,
                              ),
                            ),
                            Text(
                              product.category.toCapitalized(),
                              style: const TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Stock: ${product.stock.toString()}',
                          style: const TextStyle(
                            fontSize: 14.0,
                            height: 2,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                product.description,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  _imageCarousel(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageCarousel() {
    final images = product.images;
    return Container(
      margin: const EdgeInsets.only(bottom: 80),
      height: 155.0,
      child: ListView.builder(
        itemCount: images.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => _openImage(index),
              );
            },
            child: Container(
              width: 240.0,
              padding: const EdgeInsets.all(10.0),
              margin: index == 0
                  ? const EdgeInsets.only(
                      left: 15, right: 20, top: 10, bottom: 10)
                  : const EdgeInsets.only(right: 20, top: 10, bottom: 10),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(images[index]),
                  fit: BoxFit.fitHeight,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(16.0),
                ),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(60, 0, 100, 131),
                    blurRadius: 5,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _openImage(index) {
    final image = product.images;
    return Dialog(
      child: Image.network(image[index]),
    );
  }
}
