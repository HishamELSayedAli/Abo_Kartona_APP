import '../models/product_model.dart';
import '../repository/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productControllerProvider =
    StateNotifierProvider<ProductController, AsyncValue<List<ProductModel>>>(
  (ref) => ProductController(ref),
);

class ProductController extends StateNotifier<AsyncValue<List<ProductModel>>> {
  
  final ProductRemoteRepository _repo;
    final Ref ref;

  ProductController(this.ref)
      : _repo = ProductRemoteRepository(),
        super(const AsyncValue.loading()) {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final products = await _repo.fetchAllProducts();
      state = AsyncValue.data(products);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> search(String query) async {
    state = const AsyncValue.loading();
    try {
      final results = await _repo.searchProducts(query);
      state = AsyncValue.data(results);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
