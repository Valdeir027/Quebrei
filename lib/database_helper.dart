import 'package:myapp/models/Conta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/Conta.dart';

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
    String path = join(await getDatabasesPath(), 'contas.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE contas(id INTEGER PRIMARY KEY AUTOINCREMENT, saldo REAL)',
        );
      },
    );
  }

  Future<void> insertConta(Conta conta) async {
    final db = await database;
    await db.insert(
      'contas',
      conta.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Conta>> getContas() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('contas');
    return List.generate(maps.length, (i) {
      return Conta.fromMap(maps[i]);
    });
  }

  Future<void> updateConta(Conta conta) async {
    final db = await database;
    await db.update(
      'contas',
      conta.toMap(),
      where: 'id = ?',
      whereArgs: [conta.id],
    );
  }

  Future<void> deleteConta(int id) async {
    final db = await database;
    await db.delete(
      'contas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
