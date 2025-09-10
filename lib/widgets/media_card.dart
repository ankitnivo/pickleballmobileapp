// lib/widgets/cards/media_card.dart
import 'package:flutter/material.dart';
import '../../styles/app_theme.dart';

class MediaCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const MediaCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppElevation.low,
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left thumbnail with rounded corners
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.md),
                child: Image.asset(
                  imagePath,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(width: AppSpacing.lg),

              // Right text column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.cardTitle),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: AppTextStyles.cardSubtitle,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
