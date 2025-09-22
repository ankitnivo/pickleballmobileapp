// lib/widgets/cards/feature_card.dart
import 'package:flutter/material.dart';
import 'package:pickleballmobileapp/widgets/base_card.dart';
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
    return Stack(
      clipBehavior: Clip.none, // allow text card to overflow slightly
      children: [
        // Base image with rounded corners
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 140,
            decoration:  BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
    
        // Overlapped info card
        Positioned(
          left: -4,
          right: -4,
          bottom: -18, // pull it outside to create overlap
          child: BaseCard(
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
        ),
      ],
    );
  }
}
