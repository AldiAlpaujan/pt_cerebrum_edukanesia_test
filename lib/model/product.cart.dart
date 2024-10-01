import 'package:aldi_test/model/product.dart';

class ProductCart extends Product {
  int qty;

  ProductCart({
    required super.id,
    required super.name,
    required super.price,
    required super.category,
    required super.description,
    required super.availability,
    required this.qty,
  });

  factory ProductCart.fromParent(Product product, int qty) {
    return ProductCart(
      id: product.id,
      name: product.name,
      price: product.price,
      category: product.category,
      description: product.description,
      availability: product.availability,
      qty: qty,
    );
  }
}
