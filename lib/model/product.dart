class Product {
  final int id;
  final String name;
  final double price;
  final String category;
  final String description;
  final bool availability;

  Product({
    required this.id,
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
      availability: db['availability'],
    );
  }

  Map<String, dynamic> toDB() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'category': category,
      'description': description,
      'availability': availability,
    };
  }
}
