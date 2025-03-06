import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/product.dart';
import '../providers/product_providers.dart';
import '../screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(product.title);

        Get.to(
          () => ProductDetailScreen(product: product),
          transition: Transition.fade,
          duration: Duration(seconds: 1),
        );
      },
      child: Card(
        elevation: 0,
        color: Color(0xFFF5F5F5f5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Expanded(
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(product.image!),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                product.title!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${product.price}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          product.favorite!
                              ? Color(0xFFffefea)
                              : CupertinoColors.tertiarySystemFill,
                    ),
                    child: IconButton(
                      onPressed: () {
                        product.toggleFavorite();
                        Provider.of<ProductProvider>(
                          context,
                          listen: false,
                        ).notifyListeners();
                      },
                      icon: Icon(
                        product.favorite!
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color:
                            product.favorite!
                                ? Colors.redAccent
                                : CupertinoColors.secondaryLabel,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
