import 'package:flutter/material.dart';
import 'package:flutter_application_7/music_player_screen.dart';
import 'package:flutter_application_7/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      themeMode: themeProvider.themeMode, // <-- IMPORTANT
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),

      home: const MusicPlayerScreen(),
    );
  }
}
