import 'config/app_config.dart';
import 'main.dart';

void main() {
  mainWithConfig(
    const AppConfig(
      flavor: AppFlavor.uat,
      appName: 'Shalaverse UAT',
      apiBaseUrl: 'https://uat.api.shalaverse.com',
      bundleId: 'com.shalaverse.app.uat',
    ),
  );
}
