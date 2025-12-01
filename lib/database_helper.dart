import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _db;

  static Future<Database> get database async {
    _db ??= await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, 'randomizador.db');

    if (!File(path).existsSync()) {
      final data = await rootBundle.load('assets/db/randomizador.db');
      final bytes = data.buffer.asUint8List();
      await File(path).writeAsBytes(bytes);
    }

    return openDatabase(path);
  }
}
