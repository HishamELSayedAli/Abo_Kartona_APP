import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../products/models/product_model.dart';
import '../models/cart_model.dart';

final cartProvider = NotifierProvider<CartController, List<CartItem>>(() {
  return CartController();
});

class CartController extends Notifier<List<CartItem>> {
  @override
  List<CartItem> build() => [];

  void addToCart(ProductModel product) {
    final index = state.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == index)
            state[i].copyWith(quantity: state[i].quantity + 1)
          else
            state[i]
      ];
    } else {
      state = [...state, CartItem(product: product, quantity: 1)];
    }
  }

  void removeFromCart(ProductModel product) {
    state = state.where((item) => item.product.id != product.id).toList();
  }

  void increaseQuantity(ProductModel product) => addToCart(product);

  void decreaseQuantity(ProductModel product) {
    final index = state.indexWhere((item) => item.product.id == product.id);
    if (index >= 0 && state[index].quantity > 1) {
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == index)
            state[i].copyWith(quantity: state[i].quantity - 1)
          else
            state[i]
      ];
    } else {
      removeFromCart(product);
    }
  }

  double get totalPrice =>
      state.fold(0, (sum, item) => sum + item.totalPrice);

  void clearCart() => state = [];
}
