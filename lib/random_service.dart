import 'database_helper.dart';

Future<String> getRandom(String table) async {
  final db = await DatabaseHelper.database;

  final result = await db.rawQuery(
    'SELECT nome FROM $table ORDER BY RANDOM() LIMIT 1',
  );

  return result.first['nome'] as String;
}

Future<String> gerarIdeia() async {
  return "${await getRandom('conceito')} "
      "${await getRandom('objeto')} "
      "${await getRandom('lugar')} "
      "${await getRandom('criatura')} "
      "${await getRandom('acao')}";
}
