import '../../products/models/product_model.dart';

class OrderModel {
  final List<ProductModel> products;
  final double totalPrice;
  final DateTime dateTime;

  OrderModel({
    required this.products,
    required this.totalPrice,
    required this.dateTime,
  });

  OrderModel copyWith({
    List<ProductModel>? products,
    double? totalPrice,
    DateTime? dateTime,
  }) {
    return OrderModel(
      products: products ?? this.products,
      totalPrice: totalPrice ?? this.totalPrice,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}
