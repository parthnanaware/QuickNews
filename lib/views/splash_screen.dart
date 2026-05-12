import 'package:flutter/material.dart';
import 'dart:async';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to HomeScreen after 3 seconds
    Timer(const Duration(seconds: 3), () {
      // Use pushReplacement so the user can't press 'Back' to return to the splash screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Fade-in animation for the logo
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(seconds: 2),
              builder: (context, double value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.scale(
                    scale: 0.8 + (value * 0.2), // Slight zoom effect
                    child: child,
                  ),
                );
              },
              child: Image.asset(
                'assets/applogo.png',
                width: 140, // Keeping the logo well-proportioned
                height: 140,
              ),
            ),
            const SizedBox(height: 24),
            // App Title
            const Text(
              'QuickNews',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: -1,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 40),
            // Modern, subtle loading indicator
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}