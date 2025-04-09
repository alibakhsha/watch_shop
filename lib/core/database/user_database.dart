import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:watch_shop/core/model/user_data.dart';

class UserDatabase {
  static final UserDatabase _instance = UserDatabase._internal();

  factory UserDatabase() => _instance;

  static Database? _database;

  UserDatabase._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'user.db');
    debugPrint('Database path: $path');

    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDb,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE user(
        id INTEGER PRIMARY KEY,
        name TEXT,
        mobile TEXT,
        phone TEXT,
        address TEXT,
        lat REAL,
        lng REAL,
        postalCode TEXT,
        imagePaths TEXT -- اضافه کردن ستون برای مسیرهای تصویر
      )
    ''');
    debugPrint('Database table created');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE user ADD COLUMN imagePaths TEXT');
      debugPrint('Database upgraded: Added imagePaths column');
    }
  }

  Future<void> insertUser(UserData user) async {
    final db = await database;
    debugPrint('Inserting user: ${user.toMap()}');
    try {
      await db.insert(
        'user',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      debugPrint('User inserted into database');
    } catch (e) {
      debugPrint('Error inserting user: $e');
      rethrow;
    }
  }

  Future<UserData?> getUser() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('user');
    debugPrint('Queried users from database: $maps');

    if (maps.isNotEmpty) {
      final user = UserData.fromMap(maps.first);
      debugPrint('User found: $user');
      return user;
    }
    debugPrint('No user found in database');
    return null;
  }

  Future<void> deleteUser() async {
    final db = await database;
    await db.delete('user');
    debugPrint('User deleted from database');
  }

  Future<void> close() async {
    final db = await database;
    db.close();
    debugPrint('Database closed');
  }
}
