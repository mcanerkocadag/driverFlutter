import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/feature/home/home_view.dart';
import 'package:flutter_application_firebase/product/initialize/app_theme.dart';
import 'package:flutter_application_firebase/product/initialize/application_start.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  await ApplicationStart.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: HomeView(),
      theme: AppTheme(context).theme,
    );
  }
}
