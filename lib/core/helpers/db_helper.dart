import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:office_office/features/Home/data/models/orders_model.dart';
import '../../features/Home/data/models/item_model.dart';

class LocalDatabaseHelper {
  static Database? _db;
  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDB();

    return _db!;
  }

  static Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, 'items.db');
    //  await deleteDatabase(path);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE items(
            id TEXT,
            name TEXT,
            image TEXT,
            availability TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE myOrders(
            id TEXT,
            number_of_sugar_spoons INTEGER,
            room TEXT,
            item_id TEXT,
            status TEXT,
            user_id TEXT,
            created_at TEXT,
            updated_at TEXT,
            order_notes TEXT,
            voice_url TEXT,
            item TEXT,
            user TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE allOrders(
            id TEXT,
            number_of_sugar_spoons INTEGER,
            room TEXT,
            item_id TEXT,
            status TEXT,
            user_id TEXT,
            created_at TEXT,
            updated_at TEXT,
            order_notes TEXT,
            voice_url TEXT,
            item TEXT,
            user TEXT
          )
        ''');
      },
    );
  }

  // items table methods
  static Future<void> insertItems(List<ItemModel> items) async {
    final db = await database;
    await db.delete('items');
    for (var item in items) {
      await db.insert(
        'items',
        item.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  static Future<List<ItemModel>> getItems() async {
    final db = await database;
    final result = await db.query('items');
    return result.map((e) => ItemModel.fromJson(e)).toList();
  }

  // ====================================
  // myorders table methods
  static Future<void> insertMyOrders(List<OrdersModel> myOrders) async {
    final db = await database;
    await db.delete('myOrders');
    for (var myOrder in myOrders) {
      await db.insert(
        'myOrders',
        myOrder.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  static Future<List<OrdersModel>> getMyOrders() async {
    final db = await database;
    final result = await db.query('myOrders');
    return result.map((e) => OrdersModel.fromJson(e)).toList();
  }

  // ====================================
  // allorders table methods
  static Future<void> insertAllOrders(List<OrdersModel> allOrders) async {
    final db = await database;
    await db.delete('allOrders');
    for (var myOrder in allOrders) {
      await db.insert(
        'allOrders',
        myOrder.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  static Future<List<OrdersModel>> getAllOrders() async {
    final db = await database;
    final result = await db.query('allOrders');
    return result.map((e) => OrdersModel.fromJson(e)).toList();
  }
}
