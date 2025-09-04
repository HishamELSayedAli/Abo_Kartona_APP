import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/product_providers.dart';
import 'product_details_view.dart';

class ProductsScreen extends ConsumerWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch( productControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch<String>(
                context: context,
                delegate: ProductSearchDelegate(ref),
              );
            },
          ),
        ],
      ),
      body: productState.when(
        data: (products) => GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10,
          ),
          itemCount: products.length,
          itemBuilder: (context, idx) {
            final p = products[idx];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailsView(product: p),
                  ),
                );
              },
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(p.thumbnail, height: 80, fit: BoxFit.cover),
                    const SizedBox(height: 8),
                    Text(p.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text("\$${p.price}"),
                  ],
                ),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

class ProductSearchDelegate extends SearchDelegate<String> {
  final WidgetRef ref;
  ProductSearchDelegate(this.ref);

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
      ];

  @override
  Widget? buildLeading(BuildContext context) =>
      IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => close(context, ''));

  @override
  Widget buildResults(BuildContext context) {
    ref.read(productControllerProvider.notifier).search(query);
    return Consumer(builder: (context, ref, _) {
      final state = ref.watch(productControllerProvider);
      return state.when(
        data: (list) => ListView(
          children: list.map((p) => ListTile(
            title: Text(p.title),
            subtitle: Text("\$${p.price}"),
            onTap: () {
              close(context, '');
              Navigator.push(context, MaterialPageRoute(
                builder: (_) => ProductDetailsView(product: p),
              ));
            },
          )).toList(),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) => const SizedBox.shrink();
}
