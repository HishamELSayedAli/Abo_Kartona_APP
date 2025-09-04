import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart_provider.dart';
import '../../orders/providers/order_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final cart = ref.read(cartProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text("Your Cart")),
      body: cartItems.isEmpty
          ? const Center(child: Text("Cart is empty"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (_, index) {
                      final item = cartItems[index];
                      return ListTile(
                        leading: Image.network(item.product.thumbnail, width: 50),
                        title: Text(item.product.title),
                        subtitle: Text("\$${item.totalPrice.toStringAsFixed(2)}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () => cart.decreaseQuantity(item.product),
                            ),
                            Text("${item.quantity}"),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => cart.increaseQuantity(item.product),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text("Total: \$${cart.totalPrice.toStringAsFixed(2)}",
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 8),
                      ElevatedButton(
                          onPressed: () {
                            // ✅Add the order to OrderProvider
                            ref.read(orderProvider.notifier)
                                .addOrder(cartItems.map((e) => e.product).toList(), cart.totalPrice);

                            // ✅ show Success Dialog ->(alert Success)
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text("Success"),
                                content: const Text("Checkout completed!"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      cart.clearCart(); //deleted all car 
                                    },
                                    child: const Text("OK"),
                                  )
                                ],
                              ),
                            );
                          },
                          child: const Text("Checkout"),
                        )

                    ],
                  ),
                )
              ],
            ),
    );
  }
}
