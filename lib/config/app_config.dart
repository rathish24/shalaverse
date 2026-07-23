enum AppFlavor {
  dev,
  uat,
  stage,
  prod;

  bool get isDev => this == AppFlavor.dev;
  bool get isUat => this == AppFlavor.uat;
  bool get isStage => this == AppFlavor.stage;
  bool get isProd => this == AppFlavor.prod;
}

class AppConfig {
  final AppFlavor flavor;
  final String appName;
  final String apiBaseUrl;
  final String bundleId;

  const AppConfig({
    required this.flavor,
    required this.appName,
    required this.apiBaseUrl,
    required this.bundleId,
  });

  static late final AppConfig _instance;

  static AppConfig get instance => _instance;

  static void initialize(AppConfig config) {
    _instance = config;
  }
}
