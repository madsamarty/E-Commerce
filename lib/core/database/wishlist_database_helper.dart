import 'package:e_commerce/constance.dart';
import 'package:e_commerce/data/model/cart_item_model.dart';
import 'package:e_commerce/data/model/product_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class WishlistDatabaseHelper {
  static const _databaseName = "Wishlist.db";
  static const _databaseVersion = 1;

  /// Signleton Class
  WishlistDatabaseHelper._();
  static final WishlistDatabaseHelper instanceOfDatabase =
      WishlistDatabaseHelper._();

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
      CREATE TABLE $tableWishlistProduct(
        $columnUserId TEXT NOT NULL,
        $columnProductId TEXT NOT NULL)
      ''');
    });
  }

  Future<List<UserRelatedItemModel>> getWishlistProducts() async {
    var dbClient = await database;
    if (dbClient != null) {
      List<Map<String, dynamic>> maps =
          await dbClient.query(tableWishlistProduct);
      maps.isNotEmpty
          ? maps
              .map((product) => UserRelatedItemModel.fromJson(product))
              .toList()
          : [];
      return List.generate(maps.length, (i) {
        return UserRelatedItemModel(
            productId: maps[i][columnProductId],
            userId: maps[i][columnUserId],
            quantity: 1);
      });
    } else {
      return [];
    }
  }

  insert(UserRelatedItemModel model) async {
    var dbClient = await database;
    if (dbClient != null) {
      await dbClient.insert(tableWishlistProduct, model.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } else {
      return [];
    }
  }

  updateProduct(ProductModel model) async {
    var dbClient = await database;
    return dbClient!.update(tableWishlistProduct, model.toJson(),
        where: '$columnProductId = ?', whereArgs: [model.productId]);
  }

  deleteProduct(String productId) async {
    var dbClient = await database;
    return dbClient!.delete(tableWishlistProduct,
        where: '$columnProductId = ?', whereArgs: [productId]);
  }
}
