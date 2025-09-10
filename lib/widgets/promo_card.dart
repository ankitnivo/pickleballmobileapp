// lib/widgets/cards/promo_card.dart
import 'package:flutter/material.dart';
import 'base_card.dart';
import '../../styles/app_theme.dart';

class PromoCard extends StatelessWidget {
  final String headline;
  final String subtitle;
  final String ctaText;
  final VoidCallback? onCtaTap;

  const PromoCard({
    super.key,
    required this.headline,
    required this.subtitle,
    required this.ctaText,
    this.onCtaTap,
  });

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      color: AppColors.primary,
      elevation: AppElevation.medium,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Brand text (rotated)
          Text(
            'VER5YON\nBY APP NAME',
            style: TextStyle(
              color: AppColors.textLight.withOpacity(0.95),
              fontWeight: FontWeight.w900,
              letterSpacing: 0.8,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          // Headline
          Text(headline, style: AppTextStyles.promoHeadline),
          const SizedBox(height: AppSpacing.sm),
          // Subtitle
          Text(
            subtitle,
            style: AppTextStyles.cardSubtitle.copyWith(
              color: AppColors.textLight,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          // CTA Button
          OutlinedButton(
            onPressed: onCtaTap,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.textLight,
              side: const BorderSide(color: AppColors.white),
              shape: const StadiumBorder(),
              visualDensity: VisualDensity.compact,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: 6,
              ),
            ),
            child: Text(ctaText),
          ),
        ],
      ),
    );
  }
}
