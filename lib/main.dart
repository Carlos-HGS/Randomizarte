import 'package:flutter/material.dart';
import 'random_service.dart';
import 'dart:math';

void main() {
  runApp(const RandomizarteApp());
}

class RandomizarteApp extends StatefulWidget {
  const RandomizarteApp({super.key});

  @override
  State<RandomizarteApp> createState() => _RandomizarteAppState();
}

class _RandomizarteAppState extends State<RandomizarteApp> {
  bool temaEscuro = false;
  String palavraAtual = '';
  Color corAleatoria = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    final tema = temaEscuro ? ThemeData.dark() : ThemeData.light();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: tema,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Randomizarte',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: Icon(temaEscuro ? Icons.dark_mode : Icons.light_mode),
              onPressed: () {
                setState(() {
                  temaEscuro = !temaEscuro;
                });
              },
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 40),
                  child: Text(
                    'Selecione uma categoria para randomizar inspiração pra sua arte!',
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),

                // Botões
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    botaoCategoria('Ação', Colors.redAccent),
                    botaoCategoria('Conceito', Colors.orangeAccent),
                    botaoCategoria('Criatura', Colors.greenAccent),
                    botaoCategoria('Lugar', Colors.blueAccent),
                    botaoCategoria('Objeto', Colors.purpleAccent),
                  ],
                ),

                const SizedBox(height: 50),

                // Palavra abaixo dos botões
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 600),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                  child: palavraAtual.isEmpty
                      ? const SizedBox.shrink()
                      : Column(
                          key: ValueKey<String>(palavraAtual),
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: corAleatoria,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: corAleatoria.withValues(alpha: 0.3),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Contorno preto
                                  Text(
                                    palavraAtual,
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      foreground: Paint()
                                        ..style = PaintingStyle.stroke
                                        ..strokeWidth = 3
                                        ..color = Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  // Texto branco
                                  Text(
                                    palavraAtual,
                                    style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '#${corAleatoria.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}',
                              style: TextStyle(
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                color: temaEscuro
                                    ? Colors.white70
                                    : Colors.black54,
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget botaoCategoria(String nome, Color cor) {
    String table;

    switch (nome) {
      case 'Ação':
        table = 'acao';
        break;
      case 'Conceito':
        table = 'conceito';
        break;
      case 'Criatura':
        table = 'criatura';
        break;
      case 'Lugar':
        table = 'lugar';
        break;
      case 'Objeto':
        table = 'objeto';
        break;
      default:
        table = '';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: SizedBox(
        width: 250,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: cor,
            foregroundColor: Colors.black,
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
            minimumSize: const Size(0, 48),
          ),
          onPressed: () async {
            final palavra = await getRandom(table);

            setState(() {
              palavraAtual = palavra;
              corAleatoria = Color(
                (Random().nextDouble() * 0xFFFFFF).toInt(),
              ).withValues(alpha: 1.0);
            });
          },
          child: Text(nome),
        ),
      ),
    );
  }
}
