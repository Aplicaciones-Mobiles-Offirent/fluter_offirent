
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_offirent/model/office.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';


class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'favorites1.db');
    return await openDatabase(
      path,
      version: 3,
      onCreate: _onCreate,
    );
  }
/*
  Future<Database> openDb() async {
    if (_database == null) {
      _database = await openDatabase(join(await getDatabasesPath(),
      'favorites.db'),
      onCreate: (database, version) {
        database.execute(
            '''
      CREATE TABLE favorites(
          id INTEGER PRIMARY KEY,
          address TEXT,
          image TEXT,
          name TEXT,
          floor INTEGER,
          capacity INTEGER,
          allowResource BOOLEAN,
          score DOUBLE,
          description TEXT,
          price DOUBLE,
          status BOOLEAN,
          comment TEXT
      )
      '''
        );
      }, version: version);
    }
    return _database!;
  }

 */

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favorites(
          id INTEGER PRIMARY KEY, 
          address TEXT, 
          image TEXT, 
          name TEXT, 
          floor INTEGER, 
          capacity INTEGER, 
          allowResource BOOLEAN, 
          score DOUBLE, 
          description TEXT, 
          price DOUBLE, 
          status BOOLEAN, 
          comment TEXT 
      )
      ''');
  }

  Future<List<Office>> getFavorites() async {
    Database db = await instance.database;
    var favorites = await db.query('favorites', orderBy: 'id');
    List<Office> favoritesList = favorites.isNotEmpty
        ? favorites.map((c) => Office.fromJson(c)).toList()
        : [];
    print(favoritesList);
    return favoritesList;
  }

  Future<int> add(Office favorite) async {
    Database db = await instance.database;
    print(favorite.toMap());
    return await db.insert('favorites', favorite.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    print(id);
    return await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }
}