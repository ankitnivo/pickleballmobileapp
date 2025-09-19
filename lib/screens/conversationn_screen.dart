// lib/screens/conversations_screen.dart
import 'package:flutter/material.dart';
import 'package:pickleballmobileapp/models/message_models.dart';
import 'package:pickleballmobileapp/screens/chat_screen.dart';
import 'package:pickleballmobileapp/widgets/search_bar.dart';
import '../widgets/conversation_item.dart';
import '../styles/app_theme.dart';

class ConversationsScreen extends StatefulWidget {
  const ConversationsScreen({super.key});

  @override
  State<ConversationsScreen> createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Conversation> _conversations = [];
  List<Conversation> _filteredConversations = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _loadConversations();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _loadConversations() {
    // Mock data - replace with actual data from your backend/database
    _conversations = [
      Conversation(
        id: '1',
        user:  ChatUser(
          id: '1',
          name: 'Sarah Johnson',
          imageUrl: 'lib/assests/avatar.jpeg',
          isOnline: true,
          lastSeen: DateTime.now(),
        ),
        lastMessage: 'Hey! Are you free for tennis this weekend?',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        unreadCount: 2,
        isRead: false,
      ),
      Conversation(
        id: '2',
        user:  ChatUser(
          id: '2',
          name: 'Mike Chen',
          imageUrl: 'lib/assests/avatar.jpeg',
          isOnline: false,
          lastSeen: DateTime.now().subtract(const Duration(hours: 2)), 
        ),
        lastMessage: 'Great game yesterday! Same time next week?',
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        unreadCount: 0,
        isRead: true,
      ),
      Conversation(
        id: '3',
        user:  ChatUser(
          id: '3',
          name: 'Emma Wilson',
          imageUrl: 'lib/assests/avatar.jpeg',
          isOnline: true,
          lastSeen: DateTime.now(),
        ),
        lastMessage: 'The court is booked for 3 PM tomorrow 🎾',
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        unreadCount: 1,
        isRead: false,
      ),
      Conversation(
        id: '4',
        user: ChatUser(
          id: '4',
          name: 'David Park',
          imageUrl: 'lib/assests/avatar.jpeg',
          isOnline: false,
          lastSeen: DateTime.now().subtract(const Duration(hours: 1)),
        ),
        lastMessage: 'Thanks for the coaching session!',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        unreadCount: 0,
        isRead: true,
      ),
      Conversation(
        id: '5',
        user:  ChatUser(
          id: '5',
          name: 'Lisa Rodriguez',
          imageUrl: 'lib/assests/avatar.jpeg',
          isOnline: true,
          lastSeen: DateTime.now(),
        ),
        lastMessage: 'Can we reschedule to Friday?',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        unreadCount: 3,
        isRead: false,
      ),
    ];

    _filteredConversations = List.from(_conversations);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      _isSearching = query.isNotEmpty;
      if (_isSearching) {
        _filteredConversations = _conversations.where((conversation) {
          return conversation.user.name.toLowerCase().contains(query) ||
              conversation.lastMessage.toLowerCase().contains(query);
        }).toList();
      } else {
        _filteredConversations = List.from(_conversations);
      }
    });
  }

  void _onConversationTap(Conversation conversation) {
    // Navigate to chat detail screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatDetailScreen(
          conversation: conversation,
        ),
      ),
    );
  }

  void _onClearSearch() {
    setState(() {
      _isSearching = false;
      _filteredConversations = List.from(_conversations);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.cream,
        elevation: 0,
        title: Row(
          children: [
            const CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage('lib/assests/avatar.jpeg'),
            ),
            const SizedBox(width: AppSpacing.md),
            const Text(
              'Chats',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Add new chat functionality
            },
            icon: const Icon(Icons.add_comment_outlined, color: AppColors.textPrimary),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            child: ChatSearchBar(
              controller: _searchController,
              onChanged: (value) => _onSearchChanged(),
              onClear: _onClearSearch,
            ),
          ),

          // Active status indicator
          if (!_isSearching) _buildActiveFriends(),

          // Conversations list
          Expanded(
            child: _buildConversationsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveFriends() {
    final onlineFriends = _conversations
        .where((conv) => conv.user.isOnline)
        .take(5)
        .toList();

    if (onlineFriends.isEmpty) return const SizedBox.shrink();

    return Container(
      height: 80,
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        itemCount: onlineFriends.length,
        itemBuilder: (context, index) {
          final friend = onlineFriends[index].user;
          return Padding(
            padding: const EdgeInsets.only(right: AppSpacing.md),
            child: GestureDetector(
              onTap: () => _onConversationTap(onlineFriends[index]),
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundImage: AssetImage(friend.imageUrl),
                      ),
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
                  const SizedBox(height: 4),
                  Text(
                    friend.name.split(' ').first,
                    style: const TextStyle(fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildConversationsList() {
    if (_filteredConversations.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _isSearching ? Icons.search_off : Icons.chat_bubble_outline,
              size: 64,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              _isSearching ? 'No conversations found' : 'No conversations yet',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              _isSearching ? 'Try a different search term' : 'Start a new conversation',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      itemCount: _filteredConversations.length,
      separatorBuilder: (context, index) => Divider(
        height: 1,
        indent: 68,
        color: Colors.grey.shade300,
      ),
      itemBuilder: (context, index) {
        final conversation = _filteredConversations[index];
        return ConversationItem(
          conversation: conversation,
          onTap: () => _onConversationTap(conversation),
        );
      },
    );
  }
}
