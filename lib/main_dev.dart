import 'config/app_config.dart';
import 'main.dart';

void main() {
  mainWithConfig(
    const AppConfig(
      flavor: AppFlavor.dev,
      appName: 'Shalaverse Dev',
      apiBaseUrl: 'https://dev.api.shalaverse.com',
      bundleId: 'com.shalaverse.app.dev',
    ),
  );
}
