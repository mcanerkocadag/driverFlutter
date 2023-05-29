import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/feature/home/chat/chat_view.dart';
import 'package:flutter_application_firebase/feature/message/message_view.dart';
import 'package:flutter_application_firebase/feature/profile/profile_view.dart';
import 'package:flutter_application_firebase/product/initialize/app_theme.dart';
import 'package:flutter_application_firebase/product/initialize/application_start.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'feature/auth/authentication_view.dart';
import 'feature/home/chat/chat_screen_view.dart';

Future<void> main() async {
  await ApplicationStart.init();

  // initializeDateFormatting().then((_) => runApp(const MyApp()));
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: MessageView(),
      theme: AppTheme(context).theme,
    );
  }
}
