import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart'; // ajusta o nome do pacote se for diferente

void main() {
  testWidgets('Verifica se o título do app aparece corretamente', (WidgetTester tester) async {
    // Constrói o app
    await tester.pumpWidget(const RandomizarteApp());

    // Verifica se o título "Randomizarte" aparece
    expect(find.text('Randomizarte'), findsOneWidget);
  });
}
