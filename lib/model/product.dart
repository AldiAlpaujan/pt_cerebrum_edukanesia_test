import 'package:aldi_test/helper/global_var.dart';

class Product {
  final int? id;
  final String name;
  final double price;
  final String category;
  final String? description;
  final bool availability;

  Product({
    this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.description,
    required this.availability,
  });

  factory Product.fromMap(Map<String, dynamic> db) {
    return Product(
      id: db['id'],
      name: db['name'],
      price: db['price'],
      category: db['category'],
      description: db['description'],
      availability: db['availability'] == 0 ? false : true,
    );
  }

  Map<String, dynamic> toDB() {
    return {
      'name': name,
      'price': price,
      'category': category,
      'description': description == "" ? null : description,
      'availability': availability ? 1 : 0,
      'user_id': user!.id,
    };
  }
}
