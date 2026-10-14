import 'package:flutter/material.dart';
import 'package:appnota_mobile/screens/score_list_screen.dart';

void main() {
  runApp(const AppNota());
}

class AppNota extends StatelessWidget {
  const AppNota({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppNota',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFFAFBFC),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF0F172A),
          elevation: 0,
          centerTitle: false,
        ),
      ),
      home: const ScoreListScreen(),
    );
  }
}