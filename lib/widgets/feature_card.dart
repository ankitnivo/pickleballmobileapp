// lib/widgets/cards/feature_card.dart
import 'package:flutter/material.dart';
import 'base_card.dart';
import '../../styles/app_theme.dart';

class FeatureCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const FeatureCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image container with dark background
        Container(
          height: 110,
          decoration: BoxDecoration(
            color: AppColors.darkBg,
            borderRadius: BorderRadius.circular(AppRadius.xl),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        // Text card overlay
        BaseCard(
          padding: const EdgeInsets.all(AppSpacing.md),
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.cardTitle),
              const SizedBox(height: 6),
              Text(subtitle, style: AppTextStyles.cardSubtitle),
            ],
          ),
        ),
      ],
    );
  }
}
