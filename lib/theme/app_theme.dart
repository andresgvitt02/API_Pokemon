// lib/theme/app_theme.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFCC0000),
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      textTheme: GoogleFonts.poppinsTextTheme(),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFFCC0000),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  // Cores por tipo de Pokémon
  static const Map<String, Color> typeColors = {
    'normal': Color(0xFFA8A878),
    'fire': Color(0xFFF08030),
    'water': Color(0xFF6890F0),
    'electric': Color(0xFFF8D030),
    'grass': Color(0xFF78C850),
    'ice': Color(0xFF98D8D8),
    'fighting': Color(0xFFC03028),
    'poison': Color(0xFFA040A0),
    'ground': Color(0xFFE0C068),
    'flying': Color(0xFF98A8F0),
    'psychic': Color(0xFFF85888),
    'bug': Color(0xFFA8B820),
    'rock': Color(0xFFB8A038),
    'ghost': Color(0xFF705898),
    'dragon': Color(0xFF7038F8),
    'dark': Color(0xFF705848),
    'steel': Color(0xFFB8B8D0),
    'fairy': Color(0xFFF0B6BC),
    'shadow': Color(0xFF604E82),
    'stellar': Color(0xFF40B5A5),
    'unknown': Color(0xFF68A090),
  };

  static Color getTypeColor(String type) {
    return typeColors[type.toLowerCase()] ?? const Color(0xFFA8A878);
  }

  // Ícones por tipo (emoji simples)
  static const Map<String, String> typeIcons = {
    'normal': '⭐',
    'fire': '🔥',
    'water': '💧',
    'electric': '⚡',
    'grass': '🌿',
    'ice': '❄️',
    'fighting': '🥊',
    'poison': '☠️',
    'ground': '🌍',
    'flying': '🌬️',
    'psychic': '🔮',
    'bug': '🐛',
    'rock': '🪨',
    'ghost': '👻',
    'dragon': '🐉',
    'dark': '🌑',
    'steel': '⚙️',
    'fairy': '✨',
  };

  static String getTypeIcon(String type) {
    return typeIcons[type.toLowerCase()] ?? '❓';
  }
}
