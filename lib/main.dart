import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meal_planner/config/providers/app.providers.dart';
import 'package:meal_planner/config/routing/router.dart';
import 'package:provider/provider.dart';

Future<void> _main () async {
  final providers = await appProviders;
  runApp(MultiProvider(providers: providers, child: const MainApp()));
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  await _main();
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: router());
  }
}
