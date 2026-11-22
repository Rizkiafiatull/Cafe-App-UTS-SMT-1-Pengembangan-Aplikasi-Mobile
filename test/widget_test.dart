import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:katalog_menu/main.dart';

void main() {
  testWidgets('katalog memuat menu sampai item kesepuluh', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const KatalogApp());

    await tester.scrollUntilVisible(
      find.text('Cold Brew'),
      300,
      scrollable: find.byType(Scrollable).last,
    );
    expect(find.text('Cold Brew'), findsOneWidget);
  });

  testWidgets('tekan lama mengubah ketersediaan menu menjadi habis', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const KatalogApp());

    await tester.longPress(find.byType(MenuCard).first);
    await tester.pump();

    expect(find.text('Habis'), findsOneWidget);
    expect(
      tester.widget<AnimatedOpacity>(find.byType(AnimatedOpacity).first).opacity,
      0.4,
    );
  });

  testWidgets('menekan kartu membuka halaman detail', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const KatalogApp());

    await tester.tap(find.byType(MenuCard).first);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 700));

    expect(find.text('Detail Menu'), findsOneWidget);
    expect(find.text('Espresso'), findsOneWidget);
  });
}
