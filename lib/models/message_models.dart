// lib/models/chat_user.dart
class ChatUser {
  final String id;
  final String name;
  final String imageUrl;
  final bool isOnline;
  final DateTime lastSeen;

  const ChatUser({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.isOnline,
    required this.lastSeen,
  });
}

// lib/models/conversation.dart
class Conversation {
  final String id;
  final ChatUser user;
  final String lastMessage;
  final DateTime timestamp;
  final int unreadCount;
  final bool isRead;

  const Conversation({
    required this.id,
    required this.user,
    required this.lastMessage,
    required this.timestamp,
    required this.unreadCount,
    required this.isRead,
  });
}

// lib/models/message.dart
class Message {
  final String id;
  final String content;
  final String senderId;
  final DateTime timestamp;
  final MessageType type;

  const Message({
    required this.id,
    required this.content,
    required this.senderId,
    required this.timestamp,
    required this.type,
  });
}

enum MessageType { sent, received }
