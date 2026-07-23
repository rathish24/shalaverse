import 'package:flutter/material.dart';
import '../config/app_config.dart';
import 'app_router.dart';

class ShalaverseApp extends StatelessWidget {
  const ShalaverseApp({super.key});

  @override
  Widget build(BuildContext context) {
    final config = AppConfig.instance;

    return MaterialApp.router(
      title: config.appName,
      debugShowCheckedModeBanner: !config.flavor.isProd,
      routerConfig: appRouter,
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
    );
  }
}
