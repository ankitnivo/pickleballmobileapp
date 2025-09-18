// lib/widgets/common/custom_app_bar.dart
import 'package:flutter/material.dart';
import '../../styles/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String location;
  final VoidCallback? onLocationTap;
  final VoidCallback? onMessageTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileTap;

  const CustomAppBar({
    super.key,
    required this.location,
    this.onLocationTap,
    this.onMessageTap,
    this.onNotificationTap,
    this.onProfileTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 8);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.cream,
      elevation: 0,
      titleSpacing: AppSpacing.lg,
      title: InkWell(
        onTap: onLocationTap,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.xs,
            horizontal: AppSpacing.sm,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.place_outlined, color: AppColors.primary, size: 18),
              const SizedBox(width: 6),
              Text(
                location,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.keyboard_arrow_down, color: AppColors.textPrimary),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: onMessageTap,
          icon: const Icon(Icons.message_outlined, color: AppColors.textPrimary),
          tooltip: 'Message',
        ),
        IconButton(
          onPressed: onNotificationTap,
          icon: const Icon(Icons.notifications_none, color: AppColors.textPrimary),
          tooltip: 'Notifications',
        ),
        Padding(
          padding: const EdgeInsets.only(right: AppSpacing.lg),
          child: GestureDetector(
            onTap: onProfileTap,
            child: const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('lib/assests/avatar.jpeg'),
            ),
          ),
        ),
      ],
    );
  }
}
