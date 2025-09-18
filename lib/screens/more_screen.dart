// lib/screens/more_screen.dart
import 'package:flutter/material.dart';
import 'package:pickleballmobileapp/screens/profile_screen.dart';
import 'package:pickleballmobileapp/styles/app_theme.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = theme.textTheme;

    return Container(
      color: AppColors.cream,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          // Profile header card
          _ProfileCard(
            name: 'Ankit Ratnani',
            subtitle: 'View your full profile',
            onTap: () {Navigator.push(context,
              MaterialPageRoute(builder: (context)=>ProfileScreen()));
            }, // TODO
          ), // List content built with ListTile semantics for consistency. [17]

          const SizedBox(height: 12),

          // First section
          _SectionCard(children: [
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
          ]),

          const SizedBox(height: 16),

          // Second section
          _SectionCard(children: [
            _SettingTile(
              icon: Icons.local_offer_outlined,
              title: 'Offers',
              onTap: () {},
            ),
            _SettingTile(
              icon: Icons.article_outlined,
              title: 'Blogs',
              onTap: () {},
            ),
            _SettingTile(
              icon: Icons.card_giftcard_outlined,
              title: 'Invite & Earn',
              trailingBadge: 'EARN 50 KARMA',
              onTap: () {},
            ),
            _SettingTile(
              icon: Icons.support_agent_outlined,
              title: 'Help & Support',
              onTap: () {},
            ),
            _SettingTile(
              icon: Icons.logout_rounded,
              title: 'Logout',
              onTap: () {},
            ),
          ]),
        ],
      ),
    );
  }
}

/* ---------- widgets ---------- */

class _ProfileCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final VoidCallback onTap;
  const _ProfileCard({required this.name, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Image.asset('lib/assests/avatar.jpeg',height: 100,width: 100,),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: t.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: t.bodyMedium?.copyWith(color: Colors.black54)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.black45),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final List<Widget> children;
  const _SectionCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: Column(
        children: children
            .expand((w) sync* {
              yield w;
              if (w != children.last) yield const Divider(height: 1, thickness: 0.5, color: Color(0xFFE7ECE9));
            })
            .toList(),
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final String? trailingBadge;
  final VoidCallback onTap;

  const _SettingTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailingBadge,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: const Color(0xFFE6F2EC),
        child: Icon(icon, color: Colors.orange),
      ),
      title: Text(title, style: t.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
      subtitle: subtitle == null ? null : Text(subtitle!, style: t.bodyMedium?.copyWith(color: Colors.black54)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingBadge != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF0B3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                trailingBadge!,
                style: t.labelLarge?.copyWith(color: Colors.black87, fontWeight: FontWeight.w800),
              ),
            ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, color: Colors.black45),
        ],
      ),
      onTap: onTap,
    ); // ListTile trailing/leading API fits this UI pattern. [17][11][14]
  }
}
