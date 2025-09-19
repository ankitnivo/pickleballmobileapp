import 'package:flutter/material.dart';
import 'package:pickleballmobileapp/screens/home_page.dart';
import 'package:pickleballmobileapp/screens/nav_page.dart';
import 'dart:async';

import 'package:pickleballmobileapp/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _fadeController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize animation controllers
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Scale animation: small to large (zoom out effect like Myntra)
    _scaleAnimation = Tween<double>(
      begin: 0.5, // Start small
      end: 4.0,   // Scale up to 4x (zoom out to edges)
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeInOutCubic,
    ));

    // Fade animation: visible to transparent
    _fadeAnimation = Tween<double>(
      begin: 1.0, // Fully visible
      end: 0.0,   // Completely transparent
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    // Start the splash animation sequence
    _startSplashAnimation();
  }

  void _startSplashAnimation() async {
    // Wait a moment before starting
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Start scale animation
    _scaleController.forward();
    
    // Start fade animation after scale begins
    await Future.delayed(const Duration(milliseconds: 800));
    _fadeController.forward();
    
    // Navigate to onboarding after animation completes
    await Future.delayed(const Duration(milliseconds: 1200));
    _navigateToOnboarding();
  }

  void _navigateToOnboarding() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const NavPage()),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image with dark opacity overlay
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assests/ball_image.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Color.fromRGBO(0, 0, 0, 0.6), // Dark overlay with 60% opacity
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          
          // Animated logo in the center
          Center(
            child: AnimatedBuilder(
              animation: Listenable.merge([_scaleAnimation, _fadeAnimation]),
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Opacity(
                    opacity: _fadeAnimation.value,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'lib/assests/VERSYON-LOGO-01.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


