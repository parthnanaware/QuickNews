import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/news_provider.dart';
// Import your new splash screen
import 'views/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsProvider()),
      ],
      child: const QuickNewsApp(),
    ),
  );
}

class QuickNewsApp extends StatelessWidget {
  const QuickNewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickNews',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      // Change this from HomeScreen() to SplashScreen()
      home: const SplashScreen(),
    );
  }
}