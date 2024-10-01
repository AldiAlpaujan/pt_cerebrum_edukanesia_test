import 'package:aldi_test/helper/global_var.dart';
import 'package:aldi_test/model/product.cart.dart';
import 'package:aldi_test/model/sale.dart';
import 'package:aldi_test/services/sql/sql_helper.dart';
import 'package:aldi_test/services/sql/sql_service.dart';

class SaleData {
  static Future<List<Sale>> get({String? customer}) async {
    final saleData = <Sale>[];

    final where = [
      'user_id = ?',
      if (customer != null) 'customer LIKE ?',
    ].join(' AND ');

    final whereArgs = [
      user!.id,
      if (customer != null) '%${customer.toLowerCase()}%',
    ];

    final saleResults = await SqlService.getData(
      SqlHelper.tbSale,
      where: where,
      whereArgs: whereArgs,
    );
    for (var saleItem in saleResults) {
      final productResults = await SqlService.rawQuery("""
        select * from ${SqlHelper.tbProductSale} 
        inner join ${SqlHelper.tbProduct} on ${SqlHelper.tbProduct}.id = ${SqlHelper.tbProductSale}.product_id 
        where sale_id = ${saleItem['id']}
      """);
      saleData.add(Sale.fromJson({
        ...saleItem,
        'products': productResults,
      }));
    }
    return saleData;
  }

  static Future<Sale?> getSingle(int id) async {
    final saleResults = await SqlService.getData(
      SqlHelper.tbSale,
      where: 'user_id = ? AND id = ?',
      whereArgs: [user!.id, id],
    );
    if (saleResults.isNotEmpty) {
      final productResults = await SqlService.rawQuery("""
        select * from ${SqlHelper.tbProductSale} 
        inner join ${SqlHelper.tbProduct} on ${SqlHelper.tbProduct}.id = ${SqlHelper.tbProductSale}.product_id 
        where sale_id = ${saleResults.first['id']}
      """);
      return Sale.fromJson({
        ...saleResults.first,
        'products': productResults,
      });
    }
    return null;
  }

  static Future<bool> create({
    required String customer,
    required double payment,
    required List<ProductCart> productCarts,
  }) async {
    final result = await SqlService.dbTransaction((trx) async {
      final result = await trx.insert(
        SqlHelper.tbSale,
        {
          'user_id': user!.id,
          'payment': payment,
          'customer': customer,
          'date_time': DateTime.now().toIso8601String(),
          'update_at': null,
        },
      );
      for (var element in productCarts) {
        await trx.insert(SqlHelper.tbProductSale, {
          'sale_id': result,
          'product_id': element.id,
          'qty': element.qty,
        });
      }
    });
    return result;
  }

  static Future<bool> update({
    required int id,
    required String customer,
    required double payment,
    required List<ProductCart> productCarts,
  }) async {
    final result = await SqlService.dbTransaction((trx) async {
      await trx.update(
        SqlHelper.tbSale,
        {
          'user_id': user!.id,
          'payment': payment,
          'customer': customer,
          'update_at': DateTime.now().toIso8601String(),
        },
        where: 'id = ?',
        whereArgs: [id],
      );
      await trx.delete(
        SqlHelper.tbProductSale,
        where: 'sale_id = ?',
        whereArgs: [id],
      );
      for (var element in productCarts) {
        await trx.insert(SqlHelper.tbProductSale, {
          'sale_id': id,
          'product_id': element.id,
          'qty': element.qty,
        });
      }
    });
    return result;
  }

  static Future<bool> delete(int id) async {
    final result = await SqlService.delete(
      SqlHelper.tbSale,
      where: 'id = ?',
      whereArgs: [id],
    );
    return result;
  }
}
