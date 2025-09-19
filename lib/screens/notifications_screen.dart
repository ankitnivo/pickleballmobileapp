// lib/screens/notifications_screen.dart
import 'package:flutter/material.dart';
import '../widgets/notification_item.dart';
import '../widgets/notification_filter_tab.dart';
import '../models/notification.dart';
import '../styles/app_theme.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  int _selectedTabIndex = 0;
  List<AppNotification> _notifications = [];
  List<AppNotification> _filteredNotifications = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  void _loadNotifications() {
    // Mock data - replace with actual data from your backend
    _notifications = [
      AppNotification(
        id: '1',
        type: NotificationType.friendRequest,
        title: 'Friend Request',
        message: 'Sarah Johnson wants to be your friend',
        senderName: 'Sarah Johnson',
        senderImage: 'assets/images/avatar1.jpg',
        senderId: 'user1',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        status: NotificationStatus.pending,
        hasActions: true,
      ),
      AppNotification(
        id: '2',
        type: NotificationType.gameInvite,
        title: 'Game Invitation',
        message: 'Mike Chen invited you to play tennis at Central Park Court',
        senderName: 'Mike Chen',
        senderImage: 'assets/images/avatar2.jpg',
        senderId: 'user2',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        status: NotificationStatus.unread,
      ),
      AppNotification(
        id: '3',
        type: NotificationType.friendRequest,
        title: 'Friend Request',
        message: 'Emma Wilson wants to connect with you',
        senderName: 'Emma Wilson',
        senderImage: 'assets/images/avatar3.jpg',
        senderId: 'user3',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        status: NotificationStatus.pending,
        hasActions: true,
      ),
      AppNotification(
        id: '4',
        type: NotificationType.venueBooked,
        title: 'Booking Confirmed',
        message: 'Your court reservation at Tennis Club is confirmed for tomorrow 3:00 PM',
        timestamp: DateTime.now().subtract(const Duration(hours: 4)),
        status: NotificationStatus.read,
      ),
      AppNotification(
        id: '5',
        type: NotificationType.message,
        title: 'New Message',
        message: 'David: "Great game yesterday! Same time next week?"',
        senderName: 'David Park',
        senderImage: 'assets/images/avatar4.jpg',
        senderId: 'user4',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        status: NotificationStatus.unread,
      ),
      AppNotification(
        id: '6',
        type: NotificationType.achievement,
        title: 'Achievement Unlocked',
        message: 'Congratulations! You\'ve played 10 games this month',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        status: NotificationStatus.read,
      ),
      AppNotification(
        id: '7',
        type: NotificationType.system,
        title: 'App Update',
        message: 'New version available with improved features',
        timestamp: DateTime.now().subtract(const Duration(days: 3)),
        status: NotificationStatus.read,
      ),
    ];

    _filterNotifications();
  }

  void _filterNotifications() {
    switch (_selectedTabIndex) {
      case 0: // All
        _filteredNotifications = List.from(_notifications);
        break;
      case 1: // Requests
        _filteredNotifications = _notifications
            .where((n) => n.type == NotificationType.friendRequest)
            .toList();
        break;
      case 2: // Updates
        _filteredNotifications = _notifications
            .where((n) => n.type != NotificationType.friendRequest)
            .toList();
        break;
    }
    setState(() {});
  }

  List<int> _getBadgeCounts() {
    final all = _notifications.where((n) => n.status == NotificationStatus.unread || n.status == NotificationStatus.pending).length;
    final requests = _notifications.where((n) => n.type == NotificationType.friendRequest && n.status == NotificationStatus.pending).length;
    final updates = _notifications.where((n) => n.type != NotificationType.friendRequest && n.status == NotificationStatus.unread).length;
    
    return [all, requests, updates];
  }

  void _onTabChanged(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
    _filterNotifications();
  }

  void _onNotificationTap(AppNotification notification) {
    // Handle notification tap - navigate to relevant screen
    print('Notification tapped: ${notification.title}');
  }

  void _onAcceptFriendRequest(AppNotification notification) {
    setState(() {
      final index = _notifications.indexWhere((n) => n.id == notification.id);
      if (index != -1) {
        _notifications[index] = notification.copyWith(status: NotificationStatus.accepted);
      }
    });
    _filterNotifications();
    
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Friend request accepted from ${notification.senderName}'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _onRejectFriendRequest(AppNotification notification) {
    setState(() {
      final index = _notifications.indexWhere((n) => n.id == notification.id);
      if (index != -1) {
        _notifications[index] = notification.copyWith(status: NotificationStatus.rejected);
      }
    });
    _filterNotifications();
    
    // Show message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Friend request declined from ${notification.senderName}'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  void _onMarkAsRead(AppNotification notification) {
    if (notification.status == NotificationStatus.unread) {
      setState(() {
        final index = _notifications.indexWhere((n) => n.id == notification.id);
        if (index != -1) {
          _notifications[index] = notification.copyWith(status: NotificationStatus.read);
        }
      });
      _filterNotifications();
    }
  }

  void _markAllAsRead() {
    setState(() {
      _notifications = _notifications.map((notification) {
        if (notification.status == NotificationStatus.unread) {
          return notification.copyWith(status: NotificationStatus.read);
        }
        return notification;
      }).toList();
    });
    _filterNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final badgeCounts = _getBadgeCounts();
    
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.cream,
        elevation: 0,
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (badgeCounts[0] > 0)
            TextButton(
              onPressed: _markAllAsRead,
              child: const Text(
                'Mark all read',
                style: TextStyle(color: AppColors.primary),
              ),
            ),
          const SizedBox(width: AppSpacing.sm),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: AppSpacing.md),
          
          // Filter tabs
          NotificationFilterTabs(
            selectedIndex: _selectedTabIndex,
            onTabChanged: _onTabChanged,
            badgeCounts: badgeCounts,
          ),
          
          const SizedBox(height: AppSpacing.lg),
          
          // Notifications list
          Expanded(
            child: _buildNotificationsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsList() {
    if (_filteredNotifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none,
              size: 64,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              _getEmptyMessage(),
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'New notifications will appear here',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      itemCount: _filteredNotifications.length,
      itemBuilder: (context, index) {
        final notification = _filteredNotifications[index];
        return NotificationItem(
          notification: notification,
          onTap: () => _onNotificationTap(notification),
          onAccept: notification.type == NotificationType.friendRequest 
              ? () => _onAcceptFriendRequest(notification)
              : null,
          onReject: notification.type == NotificationType.friendRequest 
              ? () => _onRejectFriendRequest(notification)
              : null,
          onMarkRead: () => _onMarkAsRead(notification),
        );
      },
    );
  }

  String _getEmptyMessage() {
    switch (_selectedTabIndex) {
      case 1:
        return 'No friend requests';
      case 2:
        return 'No updates';
      default:
        return 'No notifications';
    }
  }
}
