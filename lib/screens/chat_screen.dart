// lib/screens/chat_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:pickleballmobileapp/models/message_models.dart';
import '../styles/app_theme.dart';

class ChatDetailScreen extends StatelessWidget {
  final Conversation conversation;

  const ChatDetailScreen({
    super.key,
    required this.conversation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.cream,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage(conversation.user.imageUrl),
            ),
            const SizedBox(width: AppSpacing.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  conversation.user.name,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  conversation.user.isOnline ? 'Online' : 'Offline',
                  style: TextStyle(
                    color: conversation.user.isOnline ? Colors.green : AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam_outlined, color: AppColors.textPrimary),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.call_outlined, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: const Center(
        child: Text('Chat messages will be implemented here'),
      ),
    );
  }
}
