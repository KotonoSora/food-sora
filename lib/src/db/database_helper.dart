import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "sample_sqlite.db";
  static const _databaseVersion = 1;

  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async => await openDatabase(
        join(await getDatabasesPath(), _databaseName),
        version: _databaseVersion,
        onCreate: (Database db, int version) async {
          await db.execute('''
          CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)
          ''');
        },
      );
}
