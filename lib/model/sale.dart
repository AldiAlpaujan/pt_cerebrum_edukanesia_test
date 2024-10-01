import 'package:aldi_test/interface/iname.dart';
import 'package:aldi_test/model/product.cart.dart';

class Sale extends IName {
  final int id;
  final DateTime dateTime;
  final String customer;
  final double payment;
  final List<ProductCart> products;
  final DateTime? updateAt;

  double get total {
    double total = 0;
    for (var element in products) {
      total += element.price * element.qty;
    }
    return total;
  }

  String get initial => getInitialName(customer);

  Sale({
    required this.id,
    required this.dateTime,
    required this.customer,
    required this.payment,
    required this.products,
    required this.updateAt,
  });

  factory Sale.fromJson(Map<String, dynamic> json) {
    return Sale(
      id: json['id'],
      dateTime: DateTime.parse(json['date_time']),
      customer: json['customer'],
      payment: json['payment'],
      products:
          (json['products'] as List).map((i) => ProductCart.fromDB(i)).toList(),
      updateAt: DateTime.tryParse(json['update_at'].toString()),
    );
  }
}
