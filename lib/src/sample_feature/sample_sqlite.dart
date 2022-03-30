import 'package:flutter/material.dart';
import 'package:foodsora/src/models/dog.dart';
import 'package:sqflite/sqflite.dart';
import 'package:foodsora/src/db/database_helper.dart';

class SampleSqlite extends StatefulWidget {
  const SampleSqlite({Key? key}) : super(key: key);

  static const routeName = '/sample_sqlite';

  @override
  State<SampleSqlite> createState() => _SampleSqliteState();
}

class _SampleSqliteState extends State<SampleSqlite> {
  final DatabaseHelper _db = DatabaseHelper.instance;

  Dog fido = const Dog(0, 'Fido', 35);

  Future<void> insertDog(Dog dog) async {
    Database db = await _db.database;
    await db.insert(
      'dogs',
      dog.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> dogs() async {
    Database db = await _db.database;
    final List<Map<String, dynamic>> maps = await db.query('dogs');
    return List.generate(maps.length, (i) {
      return Dog(
        maps[i]['id'],
        maps[i]['name'],
        maps[i]['age'],
      ).toJson();
    });
  }

  Future<void> updateDog(Dog dog) async {
    Database db = await _db.database;
    await db.update(
      'dogs',
      dog.toJson(),
      where: 'id = ?',
      whereArgs: [dog.id],
    );
  }

  Future<void> deleteDog(int id) async {
    Database db = await _db.database;
    await db.delete(
      'dogs',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> todoInsertDog() async {
    await insertDog(fido);
    print(await dogs());
  }

  Future<void> todoUpdateDog() async {
    fido = Dog(
      fido.id,
      fido.name,
      fido.age + 7,
    );
    await updateDog(fido);
    print(await dogs());
  }

  Future<void> todoDeleteDog() async {
    await deleteDog(fido.id);
    print(await dogs());
  }

  Future<void> todoQueryDog() async {
    print(await dogs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Sqlite'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              title: const Text('test insert to db'),
              onTap: todoInsertDog,
            ),
            ListTile(
              title: const Text('test update to db'),
              onTap: todoUpdateDog,
            ),
            ListTile(
              title: const Text('test delete to db'),
              onTap: todoDeleteDog,
            ),
            ListTile(
              title: const Text('test query to db'),
              onTap: todoQueryDog,
            ),
          ],
        ),
      ),
    );
  }
}
