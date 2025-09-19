// lib/widgets/chat/conversation_item.dart
import 'package:flutter/material.dart';
import 'package:pickleballmobileapp/models/message_models.dart';
import '../../styles/app_theme.dart';
import '../../utils/date_formatter.dart';

class ConversationItem extends StatelessWidget {
  final Conversation conversation;
  final VoidCallback onTap;

  const ConversationItem({
    super.key,
    required this.conversation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage(conversation.user.imageUrl),
          ),
          if (conversation.user.isOnline)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
        ],
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              conversation.user.name,
              style: TextStyle(
                fontWeight: conversation.isRead ? FontWeight.w500 : FontWeight.w700,
                fontSize: 16,
                color: AppColors.textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            DateFormatter.formatChatTime(conversation.timestamp),
            style: TextStyle(
              fontSize: 12,
              color: conversation.isRead ? AppColors.textSecondary : AppColors.primary,
              fontWeight: conversation.isRead ? FontWeight.normal : FontWeight.w600,
            ),
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Row(
          children: [
            Expanded(
              child: Text(
                conversation.lastMessage,
                style: TextStyle(
                  color: conversation.isRead ? AppColors.textSecondary : AppColors.textPrimary,
                  fontWeight: conversation.isRead ? FontWeight.normal : FontWeight.w500,
                  fontSize: 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (conversation.unreadCount > 0)
              Container(
                margin: const EdgeInsets.only(left: AppSpacing.sm),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Text(
                  conversation.unreadCount > 99 ? '99+' : '${conversation.unreadCount}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
