// lib/models/notification.dart
enum NotificationType {
  friendRequest,
  gameInvite,
  venueBooked,
  message,
  system,
  achievement,
}

enum NotificationStatus {
  pending,
  accepted,
  rejected,
  read,
  unread,
}

class AppNotification {
  final String id;
  final NotificationType type;
  final String title;
  final String message;
  final String? senderName;
  final String? senderImage;
  final String? senderId;
  final DateTime timestamp;
  final NotificationStatus status;
  final Map<String, dynamic>? data;
  final bool hasActions;

  const AppNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.timestamp,
    this.senderName,
    this.senderImage,
    this.senderId,
    this.status = NotificationStatus.unread,
    this.data,
    this.hasActions = false,
  });

  AppNotification copyWith({
    NotificationStatus? status,
    Map<String, dynamic>? data,
  }) {
    return AppNotification(
      id: id,
      type: type,
      title: title,
      message: message,
      senderName: senderName,
      senderImage: senderImage,
      senderId: senderId,
      timestamp: timestamp,
      status: status ?? this.status,
      data: data ?? this.data,
      hasActions: hasActions,
    );
  }
}
