import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/product_providers.dart';
import '../widgets/product_card.dart';
import '../widgets/shimmer_effect_widget.dart';
import 'all_product_screen.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final products = productProvider.displayedProducts;

    return Scaffold(
      body: RefreshIndicator(
        color: Colors.orange,
        elevation: 2,
        onRefresh: () async {
          productProvider.loadNextBatch();
        },
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 16, right: 16, top: 50),
            color: Colors.white,
            child: Column(
              children: [
                _buildTopBar(),
                _buildPromoCard(),
                _buildProductSection(context, productProvider, products),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      children: [
        Expanded(
          child: CupertinoSearchTextField(
            padding: EdgeInsets.all(12.0),
            placeholder: "Search product",
            placeholderStyle: TextStyle(
              fontSize: 14,
              color: CupertinoColors.secondaryLabel,
            ),
            cursorColor: CupertinoColors.secondaryLabel,
          ),
        ),
        SizedBox(width: 20),
        _buildIconButton(Icons.shopping_cart_outlined),
        SizedBox(width: 20),
        _buildNotificationButton(),
      ],
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: CupertinoColors.tertiarySystemFill,
      ),
      child: IconButton(
        icon: Icon(icon, color: CupertinoColors.secondaryLabel, size: 20),
        onPressed: () {},
      ),
    );
  }

  Widget _buildNotificationButton() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _buildIconButton(Icons.notifications_outlined),
        Positioned(
          left: 25,
          bottom: 30,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
            child: Center(
              child: Text(
                '3',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPromoCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.only(top: 20),
      color: Colors.deepPurple[800],
      elevation: 0,
      child: Container(
        height: 100,
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "A Summer Surprise",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Text(
              "Cashback 20%",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductSection(
    BuildContext context,
    ProductProvider productProvider,
    List<Product> products,
  ) {
    if (productProvider.isLoading) {
      return ShimmerLoading();
    } else if (productProvider.errorMessage != null) {
      return _buildErrorWidget(productProvider);
    } else if (products.isEmpty) {
      return Center(child: Text("No products available"));
    }

    return Container(
      margin: EdgeInsets.only(top: 30, bottom: 50),
      child: Column(
        children: [
          _buildHeader(context),
          GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.75,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductCard(product: products[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Popular Products",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () {
            Get.to(
              () => AllProductsScreen(),
              transition: Transition.zoom,
              duration: Duration(seconds: 1),
            );
          },
          child: Text(
            "See more",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorWidget(ProductProvider productProvider) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              productProvider.errorMessage!,
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onPressed: () => productProvider.retryFetchProducts(),
              child: Text("Retry", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
