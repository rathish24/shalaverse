import 'config/app_config.dart';
import 'main.dart';

void main() {
  mainWithConfig(
    const AppConfig(
      flavor: AppFlavor.prod,
      appName: 'Shalaverse',
      apiBaseUrl: 'https://api.shalaverse.com',
      bundleId: 'com.shalaverse.app',
    ),
  );
}
