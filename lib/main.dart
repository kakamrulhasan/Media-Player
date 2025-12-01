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

  themeMode: themeProvider.themeMode,

  // ☀️ LIGHT THEME (normal default)
  theme: ThemeData.light(),

  // 🌙 DARK THEME (CUSTOM ORANGE THEME)
  darkTheme: ThemeData.dark().copyWith(
  scaffoldBackgroundColor: const Color(0xFF121212),  // deep charcoal
  cardColor: const Color(0xFF1E1E1E),                // soft dark card

  colorScheme: const ColorScheme.dark(
    primary: Color(0xFFBB86FC),   // soft purple
    secondary: Color(0xFF03DAC6), // teal accent
  ),

  // AppBar
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Color(0xFFBB86FC), // purple text
    iconTheme: IconThemeData(color: Color(0xFFBB86FC)),
    titleTextStyle: TextStyle(
      color: Color(0xFFBB86FC),
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),

  // Icons
  iconTheme: const IconThemeData(
    color: Color(0xFFBB86FC), // purple
  ),

  // Text
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white70),
    bodyMedium: TextStyle(color: Colors.white70),
    bodySmall: TextStyle(color: Colors.white54),
    titleMedium: TextStyle(color: Colors.white),
  ),

  // Slider Theme
  sliderTheme: const SliderThemeData(
    activeTrackColor: Color(0xFFBB86FC),
    inactiveTrackColor: Color(0xFF03DAC6),
    thumbColor: Color(0xFFBB86FC),
    overlayColor: Color(0x33BB86FC),
  ),

  // ListTile
  listTileTheme: const ListTileThemeData(
    iconColor: Color(0xFFBB86FC),
    textColor: Colors.white70,
  ),
),


  home: const MusicPlayerScreen(),
);

  }
}
