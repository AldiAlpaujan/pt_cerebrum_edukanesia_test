import 'package:aldi_test/helper/dialog.dart';
import 'package:aldi_test/model/user.dart';
import 'package:aldi_test/services/sql/sql_helper.dart';
import 'package:aldi_test/services/sql/sql_service.dart';

class UserData {
  static Future<User?> login(String email, String password) async {
    final result = await SqlService.getData(
      SqlHelper.tbUser,
      where: 'email = ? AND pw = ?',
      whereArgs: [email, password],
    );
    if (result.isEmpty) {
      info(
        message:
            'Ops, email tidak ditemukan atau kombinasi email dan password tidak valid!',
      );
      return null;
    }
    return User.fromMap(result.first);
  }

  static Future<bool> register(
    String name,
    String email,
    String phone,
    String password,
  ) async {
    final result = await SqlService.getData(
      SqlHelper.tbUser,
      where: 'email = ?',
      whereArgs: [email],
    );
    if (result.isNotEmpty) {
      info(message: "Ops, email telah terdaftar!");
      return false;
    }
    final id = await SqlService.create(
      SqlHelper.tbUser,
      {
        'username': name,
        'email': email,
        'phone': phone,
        'pw': password,
      },
    );
    return id != null;
  }

  static Future<User?> getData(int id) async {
    final result = await SqlService.getData(
      SqlHelper.tbUser,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    }
    return null;
  }
}
