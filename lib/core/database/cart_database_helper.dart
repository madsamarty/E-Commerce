import 'package:e_commerce/constance.dart';
import 'package:e_commerce/model/cart_product_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CartDatabaseHelper {
  static const _databaseName = "CartProduct.db";
  static const _databaseVersion = 1;

  /// Signleton Class
  CartDatabaseHelper._();
  static final CartDatabaseHelper instanceOfDatabase = CartDatabaseHelper._();

  ///
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDb();
    return _database;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: _databaseVersion,
        onCreate: (Database db, int version) async {
      await db.execute('''
      CREATE TABLE $tableCartProduct(
        $columnId TEXT NOT NULL,
        $columnName TEXT NOT NULL,
        $columnImage TEXT NOT NULL,
        $columnPrice TEXT NOT NULL,
        $columnQuantity INTEGER NOT NULL)
      ''');
    });
  }

  Future<List<CartProductModel>> getAllProducts() async {
    var dbClient = await database;
    if (dbClient != null) {
      List<Map<String, dynamic>> maps = await dbClient.query(tableCartProduct);
      List<CartProductModel> list = maps.isNotEmpty
          ? maps.map((product) => CartProductModel.fromJson(product)).toList()
          : [];
      return List.generate(maps.length, (i) {
        return CartProductModel(
            productId: maps[i][columnId],
            userId: maps[i][columnIdUser],
            name: maps[i][columnName],
            image: maps[i][columnImage],
            price: maps[i][columnPrice],
            quantity: 1);
      });
    } else {
      return [];
    }
  }

  insert(CartProductModel model) async {
    var dbClient = await database;
    if (dbClient != null) {
      await dbClient.insert(tableCartProduct, model.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } else {
      return [];
    }
  }

  updateProduct(CartProductModel model) async {
    var dbClient = await database;
    return dbClient!.update(tableCartProduct, model.toJson(),
        where: '$columnId = ?', whereArgs: [model.productId]);
  }
}
