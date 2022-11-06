import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_counter/views/main_view.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Hive.initFlutter();
  runApp(const MoneyCounterApp());
}

class MoneyCounterApp extends StatelessWidget {
  const MoneyCounterApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoneyCounter',
      theme: ThemeData(primarySwatch: Colors.teal),
      darkTheme: ThemeData(primarySwatch: Colors.teal, brightness: Brightness.dark),
      themeMode: ThemeMode.system,
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        minWidth: 360,
        defaultScale: true,
        breakpoints: const [
          ResponsiveBreakpoint.resize(480, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.resize(1000, name: DESKTOP),
        ],
        background: Container(color: Theme.of(context).canvasColor),
      ),
      home: const MainView(),
    );
  }
}
