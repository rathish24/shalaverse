import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app/app.dart';
import 'config/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: String.fromEnvironment('FIREBASE_API_KEY', defaultValue: 'demo-api-key'),
          appId: String.fromEnvironment('FIREBASE_APP_ID', defaultValue: '1:123456789:web:shalaverse'),
          messagingSenderId: String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID', defaultValue: '123456789'),
          projectId: String.fromEnvironment('FIREBASE_PROJECT_ID', defaultValue: 'shalaverse-app'),
        ),
      );
    } else {
      await Firebase.initializeApp();
    }
  } catch (e) {
    debugPrint('Firebase initialization notice: $e');
  }

  // Detect flavor from native `--flavor` flag (appFlavor) or `--dart-define=APP_FLAVOR=...`
  final String rawFlavor = appFlavor ??
      const String.fromEnvironment('APP_FLAVOR', defaultValue: 'dev');

  final AppFlavor flavor = AppFlavor.values.firstWhere(
    (f) => f.name.toLowerCase() == rawFlavor.toLowerCase(),
    orElse: () => AppFlavor.dev,
  );

  final config = AppConfig(
    flavor: flavor,
    appName: flavor.isProd
        ? 'Shalaverse'
        : 'Shalaverse ${flavor.name.toUpperCase()}',
    apiBaseUrl: 'https://${flavor.name}.api.shalaverse.com',
    bundleId: flavor.isProd
        ? 'com.shalaverse.app'
        : 'com.shalaverse.app.${flavor.name}',
  );

  AppConfig.initialize(config);

  runApp(const ShalaverseApp());
}
