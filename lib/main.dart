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
  theme: ThemeData.light().copyWith(
  scaffoldBackgroundColor: const Color(0xFFF5F5F8), // soft off-white
  cardColor: Colors.white, // cards pop on light background
  primaryColor: const Color(0xFF6200EE), // nice purple accent
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF6200EE),
    secondary: Color(0xFF03DAC6), // teal accent
  ),

  // AppBar
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFFFFFFF),
    foregroundColor: Color(0xFF6200EE),
    iconTheme: IconThemeData(color: Color(0xFF6200EE)),
    elevation: 4,
    shadowColor: Colors.black26,
    titleTextStyle: TextStyle(
      color: Color(0xFF6200EE),
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),

  // Icons
  iconTheme: const IconThemeData(
    color: Color(0xFF6200EE),
  ),

  // Text
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black87),
    bodyMedium: TextStyle(color: Colors.black87),
    bodySmall: TextStyle(color: Colors.black54),
    titleMedium: TextStyle(color: Colors.black87),
  ),

  // Slider Theme
  sliderTheme: SliderThemeData(
    activeTrackColor: const Color(0xFF6200EE),
    inactiveTrackColor: const Color(0xFFC4C4C4),
    thumbColor: const Color(0xFF6200EE),
    overlayColor: const Color(0x336200EE),
    trackHeight: 4,
    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
  ),

  // ListTile
  listTileTheme: ListTileThemeData(
    iconColor: const Color(0xFF6200EE),
    textColor: Colors.black87,
    tileColor: Colors.white.withOpacity(0.7),
    selectedColor: const Color(0xFF6200EE),
  ),

  // ElevatedButton
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF6200EE),
      foregroundColor: Colors.white,
      shadowColor: Colors.black26,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
),


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
