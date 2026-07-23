import 'config/app_config.dart';
import 'main.dart';

void main() {
  mainWithConfig(
    const AppConfig(
      flavor: AppFlavor.stage,
      appName: 'Shalaverse Stage',
      apiBaseUrl: 'https://stage.api.shalaverse.com',
      bundleId: 'com.shalaverse.app.stage',
    ),
  );
}
