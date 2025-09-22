// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:pickleballmobileapp/screens/conversationn_screen.dart';
import 'package:pickleballmobileapp/screens/nav_page.dart';
import 'package:pickleballmobileapp/widgets/feature_card.dart';
import 'package:pickleballmobileapp/widgets/icon_tile.dart';
import 'package:pickleballmobileapp/widgets/media_card.dart';
import 'package:pickleballmobileapp/widgets/promo_card.dart';
import '../styles/app_theme.dart';
import '../utils/responsive_helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = ResponsiveHelper.getResponsivePadding(context);

    return ListView(
      padding: EdgeInsets.all(padding),
      children: [
        _buildFeatureCardsRow(context),
        const SizedBox(height: AppSpacing.xxl),

        // Train with us card
        MediaCard(
          imagePath: 'lib/assests/ball_image.jpg',
          title: 'Train With us',
          subtitle:
              'Connect with certified coaches\nnearby to level up your game',
          onTap: () => _handleTraining(context),
        ),
        const SizedBox(height: AppSpacing.md),

        // Promo card
        PromoCard(
          headline: 'No Pickleball Slots?',
          subtitle:
              'We\'re Hosting a Sesh this Weekend\nSo Bring On Your Best Shot!',
          ctaText: 'Wanna Play?',
          onCtaTap: () => _handlePromo(context),
        ),
        const SizedBox(height: AppSpacing.md),

        // Groups card
        IconTile(
          icon: Icons.groups_2_outlined,
          title: 'Groups',
          subtitle: 'Connect, Compete and Discuss',
          onTap: () => _handleGroups(context),
        ),
        const SizedBox(height: AppSpacing.md),

        // Bottom action tiles
        _buildActionTilesRow(context),
      ],
    );
  }

  Widget _buildFeatureCardsRow(context) {
    return Row(
      children: [
        Expanded(
          child: FeatureCard(
            imagePath: 'lib/assests/tennis1.jpeg',
            title: 'New Event',
            subtitle: 'Find Players and join their activities',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NavPage(currentPage: 1,)),
              );
            },
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: FeatureCard(
            imagePath: 'lib/assests/tennis2.jpeg',
            title: 'Find',
            subtitle: 'Book your venues\n nearby',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NavPage(currentPage: 2,)),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActionTilesRow(context) {
    return Row(
      children: [
        Expanded(
          child: IconTile(
            icon: Icons.receipt_long_outlined,
            title: 'Bookings',
            subtitle: 'Game\n History',
            onTap: () => print('Bookings tapped'),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: IconTile(
            icon: Icons.people_outline,
            title: 'Playpals',
            subtitle: 'Manage\n Players',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> ConversationsScreen())),
          ),
        ),
      ],
    );
  }

  // Event handlers (content-specific)
  void _handleTraining(BuildContext context) {
    // Navigate to training
  }

  void _handlePromo(BuildContext context) {
    // Handle promo action
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NavPage(currentPage: 2,)),
    );
  }

  void _handleGroups(BuildContext context) {
    // Navigate to groups
  }
}
