import 'package:expense/utils/initializer.dart';
import 'package:expense/utils/routes.dart';
import 'package:expense/utils/theme.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Initializer.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: mainScheme,
        useMaterial3: true,
      ),
      onGenerateRoute: onGenerateRoute,
    );
  }
}
