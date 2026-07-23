import 'package:flutter/material.dart';
import 'config/app_config.dart';

void main() {
  const flavorName = String.fromEnvironment('FLUTTER_APP_FLAVOR', defaultValue: 'dev');
  final AppFlavor flavor = AppFlavor.values.firstWhere(
    (f) => f.name == flavorName,
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

  mainWithConfig(config);
}

void mainWithConfig(AppConfig config) {
  WidgetsFlutterBinding.ensureInitialized();
  AppConfig.initialize(config);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final config = AppConfig.instance;

    return MaterialApp(
      title: config.appName,
      debugShowCheckedModeBanner: !config.flavor.isProd,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: switch (config.flavor) {
            AppFlavor.dev => Colors.blue,
            AppFlavor.uat => Colors.orange,
            AppFlavor.stage => Colors.purple,
            AppFlavor.prod => Colors.deepPurple,
          },
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = AppConfig.instance;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(config.appName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Chip(
              avatar: Icon(
                switch (config.flavor) {
                  AppFlavor.dev => Icons.developer_mode,
                  AppFlavor.uat => Icons.bug_report,
                  AppFlavor.stage => Icons.fact_check,
                  AppFlavor.prod => Icons.verified,
                },
                size: 18,
              ),
              label: Text('Environment: ${config.flavor.name.toUpperCase()}'),
            ),
            const SizedBox(height: 8),
            Text('API Base URL: ${config.apiBaseUrl}'),
            Text('Bundle ID: ${config.bundleId}'),
            const SizedBox(height: 24),
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
