// lib/widgets/cards/base_card.dart
import 'package:flutter/material.dart';
import '../../styles/app_theme.dart';

class BaseCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double? elevation;
  final EdgeInsets? padding;
  final VoidCallback? onTap;

  const BaseCard({
    super.key,
    required this.child,
    this.color,
    this.elevation,
    this.padding,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      child: Card(
        color: color ?? AppColors.white,
        elevation: elevation ?? AppElevation.low,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          onTap: onTap,
          child: Padding(
            padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
            child: child,
          ),
        ),
      ),
    );
  }
}
