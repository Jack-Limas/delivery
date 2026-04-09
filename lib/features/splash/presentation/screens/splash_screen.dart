import 'package:flutter/material.dart';

import '../../../../app/app_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Navigator.pushReplacementNamed(context, AppRouter.home),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFF8795),
                Color(0xFFFF1035),
              ],
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                Align(
                  alignment: const Alignment(0, -0.02),
                  child: Text(
                    'Foodgo',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.w800,
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                ),
                Positioned(
                  left: -32,
                  bottom: -10,
                  child: Image.asset(
                    'assets/images/splash_burger.png',
                    width: 250,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  right: 14,
                  bottom: 6,
                  child: Image.asset(
                    'assets/images/veggie_burger.png',
                    width: 164,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
