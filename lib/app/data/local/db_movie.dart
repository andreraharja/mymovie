class DBMovie {
  static String tableName = "dbmovie";

  static String createTable = "CREATE TABLE IF NOT EXISTS $tableName "
      "("
      "id NUMERIC PRIMARY KEY, "
      "original_title TEXT, "
      "release_date TEXT "
      ")";

  static String select = "select * from $tableName";
}