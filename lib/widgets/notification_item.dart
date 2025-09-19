// lib/widgets/notifications/notification_item.dart
import 'package:flutter/material.dart';
import '../../models/notification.dart';
import '../../styles/app_theme.dart';
import '../../utils/date_formatter.dart';

class NotificationItem extends StatelessWidget {
  final AppNotification notification;
  final VoidCallback? onTap;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;
  final VoidCallback? onMarkRead;

  const NotificationItem({
    super.key,
    required this.notification,
    this.onTap,
    this.onAccept,
    this.onReject,
    this.onMarkRead,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xs,
      ),
      elevation: notification.status == NotificationStatus.unread ? 2 : 1,
      color: notification.status == NotificationStatus.unread 
          ? Colors.white 
          : Colors.grey.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.md),
        onTap: () {
          onMarkRead?.call();
          onTap?.call();
        },
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildAvatar(),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                notification.title,
                                style: TextStyle(
                                  fontWeight: notification.status == NotificationStatus.unread 
                                      ? FontWeight.w700 
                                      : FontWeight.w600,
                                  fontSize: 16,
                                  color: AppColors.textPrimary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              DateFormatter.formatNotificationTime(notification.timestamp),
                              style: TextStyle(
                                fontSize: 12,
                                color: notification.status == NotificationStatus.unread 
                                    ? AppColors.primary 
                                    : AppColors.textSecondary,
                                fontWeight: notification.status == NotificationStatus.unread 
                                    ? FontWeight.w600 
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          notification.message,
                          style: TextStyle(
                            color: notification.status == NotificationStatus.unread 
                                ? AppColors.textPrimary 
                                : AppColors.textSecondary,
                            fontSize: 14,
                            height: 1.3,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  if (notification.status == NotificationStatus.unread)
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
              
              // Action buttons for friend requests
              if (notification.type == NotificationType.friendRequest && 
                  notification.status == NotificationStatus.pending)
                _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    IconData iconData;
    Color backgroundColor;
    
    switch (notification.type) {
      case NotificationType.friendRequest:
        iconData = Icons.person_add_outlined;
        backgroundColor = Colors.blue.shade100;
        break;
      case NotificationType.gameInvite:
        iconData = Icons.sports_tennis;
        backgroundColor = AppColors.primary.withOpacity(0.15);
        break;
      case NotificationType.venueBooked:
        iconData = Icons.place_outlined;
        backgroundColor = Colors.green.shade100;
        break;
      case NotificationType.message:
        iconData = Icons.chat_bubble_outline;
        backgroundColor = Colors.purple.shade100;
        break;
      case NotificationType.achievement:
        iconData = Icons.emoji_events_outlined;
        backgroundColor = Colors.amber.shade100;
        break;
      default:
        iconData = Icons.notifications_outlined;
        backgroundColor = Colors.grey.shade100;
    }

    if (notification.senderImage != null) {
      return CircleAvatar(
        radius: 20,
        backgroundImage: AssetImage(notification.senderImage!),
      );
    }

    return CircleAvatar(
      radius: 20,
      backgroundColor: backgroundColor,
      child: Icon(
        iconData,
        color: notification.type == NotificationType.gameInvite 
            ? AppColors.primary 
            : Colors.grey.shade700,
        size: 20,
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      child: Row(
        children: [
          const SizedBox(width: 52), // Align with text content
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onReject,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      visualDensity: VisualDensity.compact,
                    ),
                    child: const Text('Decline'),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onAccept,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      visualDensity: VisualDensity.compact,
                    ),
                    child: const Text('Accept'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
