import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../providers/product_providers.dart';
import 'package:provider/provider.dart';
import '../widgets/product_card.dart';

class AllProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final allProducts = productProvider.allProducts;

    return Scaffold(
      appBar: AppBar(title: Text("Products", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)),
      body: GridView.builder(
        padding: EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75,
        ),
        itemCount: allProducts.length,
        itemBuilder: (context, index) {
          return ProductCard(product: allProducts[index]);
        },
      ),
    );
  }
}