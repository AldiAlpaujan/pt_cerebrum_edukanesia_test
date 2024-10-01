import 'package:aldi_test/helper/dialog.dart';
import 'package:aldi_test/helper/global_var.dart';
import 'package:aldi_test/model/product.dart';
import 'package:aldi_test/services/sql/sql_helper.dart';
import 'package:aldi_test/services/sql/sql_service.dart';

class ProductData {
  static Future<List<Product>> get({String? name}) async {
    final where = [
      'user_id = ?',
      if (name != null) 'name LIKE ?',
    ].join(' AND ');

    final whereArgs = [
      user!.id,
      if (name != null) '%${name.toLowerCase()}%',
    ];

    final results = await SqlService.getData(
      SqlHelper.tbProduct,
      where: where,
      whereArgs: whereArgs,
    );

    return results.map((e) => Product.fromMap(e)).toList();
  }

  static Future<Product?> getSingle(int id) async {
    final results = await SqlService.getData(
      SqlHelper.tbProduct,
      where: 'user_id = ? AND id = ?',
      whereArgs: [user!.id, id],
    );
    if (results.isEmpty) return null;
    return Product.fromMap(results.first);
  }

  static Future<bool> create(Product product) async {
    final results = await SqlService.getData(
      SqlHelper.tbProduct,
      where: 'user_id = ? AND name = ?',
      whereArgs: [user!.id, product.name],
    );

    if (results.isNotEmpty) {
      info(message: "Ops, produk tersebut telah terdaftar");
      return false;
    }

    final id = await SqlService.create(SqlHelper.tbProduct, product.toDB());
    return id != null;
  }

  static Future<bool> update(Product product) async {
    if (user == null) return false;

    final results = await SqlService.getData(
      SqlHelper.tbProduct,
      where: 'user_id = ? AND name = ? AND id != ?',
      whereArgs: [user!.id, product.name, product.id],
    );

    if (results.isNotEmpty) {
      info(message: "Opps, produk dengan nama tersebut telah terdaftar");
      return false;
    }

    final result = await SqlService.update(
      SqlHelper.tbProduct,
      product.toDB(),
      where: 'user_id = ? AND id = ?',
      whereArgs: [user!.id, product.id],
    );
    return result;
  }

  static Future<bool> delete(int id) async {
    if (user == null) return false;
    final result = await SqlService.delete(
      SqlHelper.tbProduct,
      where: 'user_id = ? AND id = ?',
      whereArgs: [user!.id, id],
    );
    return result;
  }
}
