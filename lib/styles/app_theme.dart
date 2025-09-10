// lib/styles/app_theme.dart
import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFF59C1A); // Orange from screenshot
  static const Color darkBg = Color(0xFF1F1B16);
  static const Color cream = Color(0xFFF5F1E8);
  static const Color white = Colors.white;
  static const Color textPrimary = Colors.black87;
  static const Color textSecondary = Colors.black54;
  static const Color textLight = Colors.white;
}

class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
}

class AppRadius {
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 18.0;
  static const double pill = 30.0;
}

class AppElevation {
  static const double low = 2.0;
  static const double medium = 4.0;
  static const double high = 8.0;
}

class AppTextStyles {
  static const TextStyle cardTitle = TextStyle(
    color: AppColors.primary,
    fontWeight: FontWeight.w700,
    fontSize: 14,
  );
  
  static const TextStyle cardSubtitle = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 12,
    height: 1.3,
  );
  
  static const TextStyle promoHeadline = TextStyle(
    color: AppColors.textLight,
    fontWeight: FontWeight.w800,
    fontSize: 20,
  );
}
