import 'package:flutter/material.dart';
import 'package:pickleballmobileapp/screens/login_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Fullscreen Background Image
           SizedBox.expand(
              child: Opacity(
                opacity: 0.3,
                child: Image.asset(
                  "lib/assests/ball_image.jpg", // background image
                  fit: BoxFit.cover, // makes it cover the entire screen
                ),
              ),
            ),
        
            // Main Content (inside SafeArea so it stays properly aligned)
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo + Text
                  Column(
                    children: [
                      Image.asset(
                        "lib/assests/splash_logo.png",
                        height: 120,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "VERSYON",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Ever Evolving",
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 80),
        
                  // Get Started Button
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignUpScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 30),
                      ),
                      child: const Text(
                        "Get Started",
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
        
                  const SizedBox(height: 10),
        
                  // Already have account
                  TextButton(
                    onPressed: () => const {},
                    child: const Text(
                    "I already have an account",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
