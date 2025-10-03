// lib/screens/more_screen.dart
import 'package:flutter/material.dart';
import 'package:pickleballmobileapp/screens/enroll_as_coach_screen.dart';
import 'package:pickleballmobileapp/screens/profile_screen.dart';
import 'package:pickleballmobileapp/styles/app_theme.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  // Mock user coach status - replace with actual user state management
  final bool isCoach = false;
  final bool isCoachVerified = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.cream,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          // Enhanced Profile header card
          _buildProfileCard(context),
          const SizedBox(height: 16),

          // Coach features grid (only visible if user is a coach)
          if (isCoach) ...[
            _buildCoachDashboardHeader(),
            const SizedBox(height: 12),
            _buildCoachFeaturesGrid(context),
            const SizedBox(height: 20),
          ],

          // User features section
          _buildSectionTitle('Your Account'),
          const SizedBox(height: 8),
          _buildUserFeaturesSection(),
          const SizedBox(height: 20),

          // App features section
          _buildSectionTitle('App Features'),
          const SizedBox(height: 8),
          _buildAppFeaturesSection(context),
        ],
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.8),
            AppColors.primary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Enhanced avatar with verification badge
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: Image.asset(
                          'lib/assests/avatar.jpeg',
                          height: 70,
                          width: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    if (isCoach && isCoachVerified)
                      Positioned(
                        bottom: -2,
                        right: -2,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.verified,
                            color: Colors.blue,
                            size: 22,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Ankit Ratnani',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (isCoach && !isCoachVerified)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'PENDING',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isCoach
                            ? (isCoachVerified
                                ? 'Verified Coach'
                                : 'Coach (Pending Verification)')
                            : 'View your full profile',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                          fontWeight:
                              isCoach && isCoachVerified ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.white.withOpacity(0.8),
                  size: 28,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCoachDashboardHeader() {
    return Row(
      children: [
        Icon(
          Icons.dashboard_outlined,
          color: AppColors.primary,
          size: 24,
        ),
        const SizedBox(width: 8),
        const Text(
          'Coach Dashboard',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'PRO',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCoachFeaturesGrid(BuildContext context) {
    final coachFeatures = [
      CoachFeature(
        icon: Icons.school_outlined,
        title: 'My Students',
        subtitle: '12 Active',
        color: Colors.blue,
        onTap: () {},
      ),
      CoachFeature(
        icon: Icons.person_add_outlined,
        title: 'Add Student',
        subtitle: 'Invite New',
        color: Colors.green,
        onTap: () {},
      ),
      CoachFeature(
        icon: Icons.trending_up_outlined,
        title: 'Progress',
        subtitle: 'Track Growth',
        color: Colors.purple,
        onTap: () {},
      ),
      CoachFeature(
        icon: Icons.schedule_outlined,
        title: 'Schedule',
        subtitle: '8 Sessions',
        color: Colors.orange,
        onTap: () {},
      ),
      CoachFeature(
        icon: Icons.event_note_outlined,
        title: 'My Events',
        subtitle: '3 Upcoming',
        color: Colors.red,
        onTap: () {},
      ),
      CoachFeature(
        icon: Icons.analytics_outlined,
        title: 'Analytics',
        subtitle: 'View Stats',
        color: Colors.indigo,
        onTap: () {},
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.1,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: coachFeatures.length,
      itemBuilder: (context, index) {
        return _buildCoachFeatureCard(coachFeatures[index]);
      },
    );
  }

  Widget _buildCoachFeatureCard(CoachFeature feature) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: feature.color.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: feature.onTap,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: feature.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    feature.icon,
                    color: feature.color,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  feature.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  feature.subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.arrow_forward_ios,
                      color: feature.color.withOpacity(0.6),
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildUserFeaturesSection() {
    return _SectionCard(children: [
      _SettingTile(
        icon: Icons.receipt_long_rounded,
        title: 'My Bookings',
        subtitle: 'View Transactions & Receipts',
        onTap: () {},
      ),
      _SettingTile(
        icon: Icons.groups_2_rounded,
        title: 'Playpals',
        subtitle: 'View & Manage Players',
        onTap: () {},
      ),
      _SettingTile(
        icon: Icons.account_balance_wallet_rounded,
        title: 'Passbook',
        subtitle: 'Manage Karma, Playo credits, etc',
        onTap: () {},
      ),
      _SettingTile(
        icon: Icons.shield_outlined,
        title: 'Preference and Privacy',
        subtitle: 'Sports, Locations, Notifications, etc',
        onTap: () {},
      ),
    ]);
  }

  Widget _buildAppFeaturesSection(BuildContext context) {
    return _SectionCard(children: [
      // Conditional coach enrollment
      if (!isCoach)
        _SettingTile(
          icon: Icons.sports,
          title: 'Enroll as a Coach',
          subtitle: 'Start coaching and earn money',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => EnrollAsCoachScreen()),
            );
          },
        ),
      _SettingTile(
        icon: Icons.article_outlined,
        title: 'Blogs',
        subtitle: 'Read latest sports articles',
        onTap: () {},
      ),
      _SettingTile(
        icon: Icons.card_giftcard_outlined,
        title: 'Invite & Earn',
        subtitle: 'Refer friends and get rewards',
        trailingBadge: 'EARN 50 KARMA',
        onTap: () {},
      ),
      _SettingTile(
        icon: Icons.support_agent_outlined,
        title: 'Help & Support',
        subtitle: 'Get help or contact us',
        onTap: () {},
      ),
      _SettingTile(
        icon: Icons.logout_rounded,
        title: 'Logout',
        subtitle: 'Sign out of your account',
        textColor: Colors.red,
        onTap: () {},
      ),
    ]);
  }
}

// Coach feature model
class CoachFeature {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  CoachFeature({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });
}

// Enhanced section card
class _SectionCard extends StatelessWidget {
  final List<Widget> children;

  const _SectionCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: children
            .expand((w) sync* {
              yield w;
              if (w != children.last) {
                yield Divider(
                  height: 1,
                  thickness: 0.5,
                  color: Colors.grey.shade200,
                  indent: 68,
                );
              }
            })
            .toList(),
      ),
    );
  }
}

// Enhanced setting tile
class _SettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final String? trailingBadge;
  final Color? textColor;
  final VoidCallback onTap;

  const _SettingTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailingBadge,
    this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: (textColor ?? AppColors.primary).withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: textColor ?? AppColors.primary,
          size: 24,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16,
          color: textColor ?? AppColors.textPrimary,
        ),
      ),
      subtitle: subtitle == null
          ? null
          : Text(
              subtitle!,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
            ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingBadge != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.amber.shade300, Colors.orange.shade400],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                trailingBadge!,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                ),
              ),
            ),
          const SizedBox(width: 8),
          Icon(
            Icons.chevron_right,
            color: Colors.grey.shade400,
            size: 20,
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
