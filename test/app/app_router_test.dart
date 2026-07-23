import 'package:flutter_test/flutter_test.dart';
import 'package:shalaverse/app/app.dart';
import 'package:shalaverse/config/app_config.dart';

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

  testWidgets('App renders main shell and default initial route', (WidgetTester tester) async {
    await tester.pumpWidget(const ShalaverseApp());
    await tester.pumpAndSettle();

    expect(find.text('Login - Shalaverse'), findsOneWidget);
  });
}
