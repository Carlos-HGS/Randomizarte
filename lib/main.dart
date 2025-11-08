import 'dart:math';
import 'package:flutter/material.dart';

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

  final Map<String, List<String>> bancos = {
    'Ação': [
      'Ajudar',
      'Aumentar',
      'Benzer',
      'Bisbilhotar',
      'Cair',
      'Conquistar',
      'Cuidar',
      'Doar',
      'Descobrir',
      'Desenterrar',
      'Flutuar',
      'Guiar',
      'Honrar',
      'Julgar',
      'Libertar',
      'Machucar',
      'Mergulhar',
      'Navegar',
      'Negociar',
      'Operar',
      'Pescar',
      'Procrastinar',
      'Reinar',
      'Salvar',
      'Sobreviver',
      'Transformar',
      'Unir',
      'Vigiar',
      'Zarpar',
    ],
    'Conceito': [
      'Afrofuturismo',
      'Ambição',
      'Arcano',
      'Autonomia',
      'Culpa',
      'Cyberpunk',
      'Democracia',
      'Desejo',
      'Destino',
      'Distopia',
      'Empatia',
      'Esperança',
      'Fragilidade',
      'Futuro',
      'Gótico',
      'Heroísmo',
      'Humildade',
      'Ignorância',
      'Inocência',
      'Liberdade',
      'Luxúria',
      'Memória',
      'Mistério',
      'Nostalgia',
      'Obsessão',
      'Ordem',
      'Paixão',
      'Poder',
      'Preguiça',
      'Rebeldia',
      'Sacrifício',
      'Serenidade',
      'Tradição',
      'Tristeza',
      'Utopia',
      'Virtude',
    ],
    'Criatura': [
      'Agricultor',
      'Anubis',
      'Baleia',
      'Behemoth',
      'Boto',
      'Capivara',
      'Curupira',
      'Djinn',
      'Fenrir',
      'Gnomo',
      'Grifo',
      'Hidra',
      'Justiceiro',
      'Kitsune',
      'Lich',
      'Mapinguari',
      'Monstro do Lago Ness',
      'Pinguim',
      'Quimera',
      'Rakshasa',
      'Sátiro',
      'Valkíria',
      'Wendigo',
      'Yeti',
    ],
    'Lugar': [
      'Abismo',
      'Arena',
      'Arquipélago',
      'Castelo',
      'Cemitério',
      'Deserto',
      'Estufa',
      'Farol',
      'Forte',
      'Galáxia',
      'Labirinto',
      'Montanha',
      'Nave',
      'Oásis',
      'Paraíso',
      'Penhasco',
      'Prisão',
      'Reino',
      'Ruínas',
      'Santuário',
      'Savana',
      'Templo',
      'Tundra',
      'Vale',
      'Vilarejo',
      'Vulcão',
    ],
    'Objeto': [
      'Alçapão',
      'Armadura',
      'Bússola',
      'Cápsula de tempo',
      'Disco',
      'Elixir',
      'Escudo',
      'Frasco',
      'Foguete',
      'Gaiola',
      'Gancho',
      'Gramofone',
      'Incenso',
      'Joia',
      'Lampião',
      'Mapa',
      'Medalha',
      'Necronomicon',
      'Ornamento',
      'Osso',
      'Pêndulo',
      'Peruca',
      'Relógio de sol',
      'Roupão',
      'Selo',
      'Sino',
      'Talismã',
      'Torre',
      'Uniforme',
      'Urna',
    ],
  };

  void gerarPalavra(String categoria) {
    final random = Random();
    final lista = bancos[categoria]!;
    final palavra = lista[random.nextInt(lista.length)];
    final cor = Color(
      (Random().nextDouble() * 0xFFFFFF).toInt(),
    ).withValues(alpha: 1.0);

    setState(() {
      palavraAtual = palavra;
      corAleatoria = cor;
    });
  }

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
          onPressed: () => gerarPalavra(nome),
          child: Text(nome),
        ),
      ),
    );
  }
}
