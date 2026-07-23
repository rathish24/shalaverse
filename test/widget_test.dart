import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shalaverse/config/app_config.dart';
import 'package:shalaverse/main.dart';

void main() {
  setUp(() {
    AppConfig.initialize(
      const AppConfig(
        flavor: AppFlavor.dev,
        appName: 'Shalaverse Dev',
        apiBaseUrl: 'https://dev.api.shalaverse.com',
        bundleId: 'com.shalaverse.app.dev',
      ),
    );
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
