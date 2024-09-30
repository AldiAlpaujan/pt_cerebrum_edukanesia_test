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
}
