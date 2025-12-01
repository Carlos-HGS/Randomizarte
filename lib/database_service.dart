import 'dart:math';
import 'package:flutter/foundation.dart';

// APP (SQLite)
import 'database_helper.dart';

// WEB (IndexedDB)
import 'package:sembast_web/sembast_web.dart';

class DatabaseService {

  // Banco WEB
  static final _webFactory = databaseFactoryWeb;
  static Database? _webDB;

  // Store por tabela
  static StoreRef<String, Map<String, Object?>> _store(String table) {
    return stringMapStoreFactory.store(table);
  }

  // Abre WEB DB
  static Future<Database> _getWebDB() async {
    _webDB ??= await _webFactory.openDatabase('randomizarte_web.db');
    return _webDB!;
  }

  // Interface única
  static Future<String> getRandom(String table) async {
    if (kIsWeb) {
      return await _getWebRandom(table);
    } else {
      return await _getSQLiteRandom(table);
    }
  }

  // ✅ FLUTTER APP
  static Future<String> _getSQLiteRandom(String table) async {
    final db = await DatabaseHelper.database;
    final result = await db.rawQuery(
      'SELECT nome FROM $table ORDER BY RANDOM() LIMIT 1'
    );
    return result.first['nome'] as String;
  }

  // ✅ FLUTTER WEB
  static Future<String> _getWebRandom(String table) async {
    final db = await _getWebDB();
    final store = _store(table);

    final records = await store.find(db);

    // Se vazio → importar do SQL
    if (records.isEmpty) {
  return 'Banco vazio no navegador';
}
    final rand = Random().nextInt(records.length);
    return records[rand].value['nome'] as String;
  }

  
}
