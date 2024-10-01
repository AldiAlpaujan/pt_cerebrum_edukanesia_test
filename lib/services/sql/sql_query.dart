import 'package:aldi_test/services/sql/sql_helper.dart';

class SqlQuery {
  static const craeteTBUser = """
    CREATE TABLE IF NOT EXISTS ${SqlHelper.tbUser}(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      username VARCHAR(100) NOT NULL,
      email VARCHAR(100) NOT NULL,
      phone VARCHAR(100) NOT NULL, 
      pw VARCHAR(100) NOT NULL
    )
  """;
  static const createTBProduct = """
    CREATE TABLE IF NOT EXISTS ${SqlHelper.tbProduct}(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name VARCHAR(100) NOT NULL,
      price DOUBLE NOT NULL,
      category VARCHAR(100) NOT NULL,
      description TEXT,
      availability INTEGER NOT NULL,
      user_id INTEGER NOT NULL,
      FOREIGN KEY (user_id) REFERENCES ${SqlHelper.tbUser}(id)
    )
  """;
  static const createTBSale = """
    CREATE TABLE IF NOT EXISTS ${SqlHelper.tbSale}(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date_time TEXT NOT NULL,
      customer VARCHAR(100) NOT NULL,
      payment DOUBLE NOT NULL,
      user_id INTEGER NOT NULL,
      update_at TEXT,
      FOREIGN KEY (user_id) REFERENCES ${SqlHelper.tbUser}(id)
    )
  """;
  static const createTBProductSale = """
    CREATE TABLE IF NOT EXISTS ${SqlHelper.tbProductSale}(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      qty INTEGER NOT NULL,
      product_id INTEGER NOT NULL,
      sale_id INTEGER NOT NULL,
      FOREIGN KEY (product_id) REFERENCES ${SqlHelper.tbProduct}(id),
      FOREIGN KEY (sale_id) REFERENCES ${SqlHelper.tbSale}(id) ON DELETE CASCADE
    )
  """;
}
