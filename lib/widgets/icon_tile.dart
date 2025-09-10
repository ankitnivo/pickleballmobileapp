// lib/widgets/cards/icon_tile.dart
import 'package:flutter/material.dart';
import 'base_card.dart';
import '../../styles/app_theme.dart';

class IconTile extends StatelessWidget {
  final IconData icon;
  final IconData? trailingIcon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const IconTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailingIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      onTap: onTap,
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.primary.withOpacity(0.15),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.cardTitle),
                const SizedBox(height: 4),
                Text(subtitle, style: AppTextStyles.cardSubtitle),
              ],
            ),
          ),
          if (trailingIcon != null)
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.primary.withOpacity(0.15),
              child: Icon(trailingIcon, size: 18, color: AppColors.primary),
            ),
        ],
      ),
    );
  }
}
