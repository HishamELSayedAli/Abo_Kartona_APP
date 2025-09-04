import 'package:flutter/material.dart';
import 'package:e_commerce_app/features/auth/views/login.dart';
import 'package:e_commerce_app/features/home.dart';
import 'package:e_commerce_app/features/cart/views/cart_screen.dart';

// 👇 انت مستورد product_screen.dart فالغالب الكلاس اسمه ProductScreen (مش ProductsScreen)
import 'package:e_commerce_app/features/products/views/product_screen.dart';

// 👇 انت مستورد product_details_view.dart فالغالب الكلاس اسمه ProductDetailsView (مش ProductDetailsScreen)
import 'package:e_commerce_app/features/products/views/product_details_view.dart';

import 'package:e_commerce_app/features/products/models/product_model.dart';

class AppRouter {
  static const String home = '/';
  static const String login = '/login';
  static const String cart = '/cart';
  static const String products = '/products';
  static const String productDetails = '/product-details';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeView());

      case login:
        return MaterialPageRoute(builder: (_) => const LoginView());

      case cart:
        return MaterialPageRoute(builder: (_) => const CartScreen());

      case products:
        // ⬅️ استخدم اسم الكلاس المطابق لملف product_screen.dart
        return MaterialPageRoute(builder: (_) => ProductsScreen());

      case productDetails:
        final product = settings.arguments as ProductModel;
        // ⬅️ استخدم اسم الكلاس المطابق لملف product_details_view.dart
        return MaterialPageRoute(
          builder: (_) => ProductDetailsView(product: product),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route defined')),
          ),
        );
    }
  }
}
