import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';
import '../providers/product_providers.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Products Detail",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          double imageHeight = constraints.maxHeight * 0.4;
          double overlapHeight = 25;

          return Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Image.network(
                  product.image!,
                  height: imageHeight,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: imageHeight - overlapHeight,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xfff5f5f5),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Consumer<ProductProvider>(
                            builder: (context, productProvider, child) {
                              return Container(
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
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          product.title!,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Price : ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: "\$${product.price!}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Description",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          product.description!,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Rating: ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: "${product.rating?.rate}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: " rated by ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              TextSpan(
                                text: "${product.rating?.count}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: " people",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
