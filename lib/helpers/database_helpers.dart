import 'package:path/path.dart';
import 'package:sertifikasi/models/item_model.dart';
import 'package:sertifikasi/models/user_models.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = await getDatabasesPath();
    String databasePath = join(path, 'user_item_database.db');

    return await openDatabase(
      databasePath,
      version: 5,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT UNIQUE,
        username TEXT UNIQUE,
        password TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        price TEXT,
        quantity INTEGER DEFAULT 0,
        sellingPrice TEXT DEFAULT '',
        imagePath TEXT,
        date TEXT,
        tanggalMasuk TEXT,
        createdAt TEXT,
        updateAt TEXT
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute(
        "ALTER TABLE items ADD COLUMN quantity INTEGER DEFAULT 0",
      );
      await db.execute(
        "ALTER TABLE items ADD COLUMN sellingPrice TEXT DEFAULT ''",
      );
    }
    if (oldVersion < 3) {
      await db.execute("ALTER TABLE items ADD COLUMN date TEXT");
    }
    if (oldVersion < 4) {
      await db.execute("ALTER TABLE items ADD COLUMN createdAt TEXT");
      await db.execute("ALTER TABLE items ADD COLUMN updateAt TEXT");
    }
    if (oldVersion < 5) {
      await db.execute("ALTER TABLE items ADD COLUMN tanggalMasuk TEXT");
    }
  }

  Future<int> insertUser(User user) async {
    final db = await database;
    try {
      return await db.insert(
        'users',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error inserting user: $e');
      return -1;
    }
  }

  Future<bool> userExists(String email, String username) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'email = ? OR username = ?',
      whereArgs: [email, username],
    );
    return result.isNotEmpty;
  }

  Future<User?> getUserByEmail(String email) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return User(
        id: maps[0]['id'],
        email: maps[0]['email'],
        username: maps[0]['username'],
        password: maps[0]['password'],
      );
    }
    return null;
  }

  Future<int> insertItem(Item item) async {
    final db = await database;
    try {
      return await db.insert(
        'items',
        item
            .copyWith(createdAt: DateTime.now(), updateAt: DateTime.now())
            .toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error inserting item: $e');
      return -1;
    }
  }

  Future<List<Item>> getItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('items');

    return List.generate(maps.length, (i) {
      return Item.fromMap(maps[i]);
    });
  }

  Future<int> updateItem(Item item) async {
    final db = await database;
    return await db.update(
      'items',
      item.copyWith(updateAt: DateTime.now()).toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<void> deleteItem(int id) async {
    final db = await database;
    await db.delete('items', where: 'id = ?', whereArgs: [id]);
  }
}
