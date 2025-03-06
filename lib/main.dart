import 'package:anubhavassignment/providers/product_providers.dart';
import 'package:anubhavassignment/screens/product_screen.dart';
import 'package:anubhavassignment/screens/spalsh_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider()..fetchProducts(),
      child: GetMaterialApp(
        title: 'Anubhav Assignment Demo',
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
