import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const YinXinApp());
}

class YinXinApp extends StatelessWidget {
  const YinXinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '印享',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF5A623),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F5F7),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Color(0xFF1D1D1F)),
          titleTextStyle: TextStyle(
            color: Color(0xFF1D1D1F),
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
