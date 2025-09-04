import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/order_model.dart';
import '../../products/models/product_model.dart';

final orderProvider =
    StateNotifierProvider<OrderNotifier, List<OrderModel>>((ref) {
  return OrderNotifier();
});

class OrderNotifier extends StateNotifier<List<OrderModel>> {
  OrderNotifier() : super([]);

  void addOrder(List<ProductModel> products, double totalPrice) {
    final newOrder = OrderModel(
      products: products,
      totalPrice: totalPrice,
      dateTime: DateTime.now(),
    );
    state = [...state, newOrder];
  }

  void clearOrders() {
    state = [];
  }
}
