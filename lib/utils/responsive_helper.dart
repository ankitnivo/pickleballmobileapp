// lib/utils/responsive_helper.dart
import 'package:flutter/material.dart';

class ResponsiveHelper {
  static bool isMobile(BuildContext context) => 
      MediaQuery.of(context).size.width < 600;
  
  static bool isTablet(BuildContext context) => 
      MediaQuery.of(context).size.width >= 600 && 
      MediaQuery.of(context).size.width < 1024;
  
  static bool isDesktop(BuildContext context) => 
      MediaQuery.of(context).size.width >= 1024;

  static double getResponsivePadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return 16.0;
    if (width < 1024) return 24.0;
    return 32.0;
  }
}
