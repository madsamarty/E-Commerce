import 'package:e_commerce/constants/constance.dart';
import 'package:e_commerce/data/model/cart_item_model.dart';
import 'package:e_commerce/data/model/product_model.dart';
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
        $columnProductId TEXT NOT NULL,
        $columnUserId TEXT NOT NULL,
        $columnName TEXT NOT NULL,
        $columnImage TEXT NOT NULL,
        $columnDis TEXT NOT NULL,
        $columnPrice TEXT NOT NULL,
        $columnCategory TEXT NOT NULL,
        $columnQuantity INTEGER NOT NULL)
      ''');
    });
  }

  Future<List<ProductModel>> getCartProducts() async {
    var dbClient = await database;
    if (dbClient != null) {
      List<Map<String, dynamic>> maps = await dbClient.query(tableCartProduct);
      List<ProductModel> list = maps.isNotEmpty
          ? maps.map((product) => ProductModel.fromJson(product)).toList()
          : [];
      return List.generate(maps.length, (i) {
        return ProductModel(
          productId: maps[i][columnProductId],
          userId: maps[i][columnUserId],
          name: maps[i][columnName],
          image: maps[i][columnImage],
          dis: maps[i][columnDis],
          price: maps[i][columnPrice],
          category: maps[i][columnCategory],
          quantity: maps[i][columnQuantity],
        );
      });
    } else {
      return [];
    }
  }
  /* Future<List<CartItemModel>> getCartProductsLocal() async {
    var dbClient = await database;
    if (dbClient != null) {
      List<Map<String, dynamic>> maps = await dbClient.query(tableCartProduct);
      List<ProductModel> list = maps.isNotEmpty
          ? maps.map((product) => ProductModel.fromJson(product)).toList()
          : [];
      return List.generate(maps.length, (i) {
        return CartItemModel(
            productId: maps[i][columnId],
            userId: maps[i][columnUserId],
            //name: maps[i][columnName],
            //category: maps[i][columnCategory],
            //image: maps[i][columnImage],
            //dis: maps[i][columnDis],
            //price: maps[i][columnPrice],
            quantity: 1);
      });
    } else {
      return [];
    }
  } */

  insert(ProductModel model) async {
    var dbClient = await database;
    if (dbClient != null) {
      await dbClient.insert(tableCartProduct, model.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } else {
      return [];
    }
  }

  updateProduct(ProductModel model) async {
    var dbClient = await database;
    return dbClient!.update(tableCartProduct, model.toJson(),
        where: '$columnProductId = ?', whereArgs: [model.productId]);
  }

  deleteProduct(String productId) async {
    var dbClient = await database;
    return dbClient!.delete(tableCartProduct,
        where: '$columnProductId = ?', whereArgs: [productId]);
  }

  deleteAll() async {
    var dbClient = await database;
    return dbClient!.delete(tableCartProduct);
  }
}
