// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Container(
      color: const Color(0xFFFFF6EC),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          SizedBox(height: 25,),
          // Top actions row (back, share, edit)
          Row(
            children: [
              _IconButtonCircle(icon: Icons.arrow_back_ios_new_rounded, onTap: () {Navigator.pop(context);}),
              const Spacer(),
              _IconButtonCircle(icon: Icons.ios_share_rounded, onTap: () {}),
              const SizedBox(width: 8),
              _IconButtonCircle(icon: Icons.edit_rounded, onTap: () {}),
            ],
          ), // Basic layout with Rows/Icons per Flutter layout guide. [4]

          const SizedBox(height: 12),

          // Profile summary card with stats
          _ProfileSummaryCard(
            name: 'Ankit Ratnani',
            subtitle: 'No activities yet',
            stats: const [
              _StatItem(value: '100', label: 'Games'),
              _StatItem(value: '120', label: 'Playpals'),
              _StatItem(value: '50', label: 'Groups'),
            ],
          ), // Card composition per Material Card API. [3]

          const SizedBox(height: 12),

          // Upcoming Matches section
          _SectionCard(
            title: 'Upcoming Matches',
            child: SizedBox(
              height: 200,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                itemCount: 2,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (_, i) => _UpcomingMatchTile(
                  image: i == 0 ? 'lib/assests/tennis1.jpeg' : 'lib/assests/tennis2.jpeg',
                  title: i == 0 ? 'Force Playing Fields' : 'Hope Playing Fields',
                  city: 'Houston Texas',
                  players: 'NO. Players',
                  time: 'Time: 6:30 PM',
                ),
              ),
            ),
          ), // Horizontal list pattern from Flutter cookbook. [14]

          const SizedBox(height: 12),

          // My Stats card
          _StatsCard(
            rating: '3.2',
            ratingStar: true,
            weeksLabel: '2',
            totalMatches: '100',
            won: '35',
            lost: '35',
            draw: '30',
            pieData: const [
              _PieSlice(0.35, Color(0xFFEF9A9A)), // won
              _PieSlice(0.32, Color(0xFF80CBC4)), // lost
              _PieSlice(0.33, Color(0xFFFFCC80)), // draw
            ],
          ), // Simple custom pie painting for visual match. [4]
        ],
      ),
    );
  }
}

/* -------------- Top icon button ---------------- */

class _IconButtonCircle extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _IconButtonCircle({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 1,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(icon, size: 18, color: Colors.black87),
        ),
      ),
    );
  }
}

/* -------------- Profile summary card -------------- */

class _StatItem {
  final String value;
  final String label;
  const _StatItem({required this.value, required this.label});
}

class _ProfileSummaryCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final List<_StatItem> stats;

  const _ProfileSummaryCard({
    required this.name,
    required this.subtitle,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset('lib/assests/avatar.jpeg',height: 100,width: 100,),
                const SizedBox(width: 12),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: stats
                        .map((s) => Column(
                              children: [
                                Text(s.value, style: t.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
                                Text(s.label, style: t.bodySmall?.copyWith(color: Colors.black54)),
                              ],
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('James Dune', style: t.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 2),
                  Text('No activities yet', style: t.bodyMedium?.copyWith(color: Colors.black54)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* -------------- Section card wrapper -------------- */

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: t.titleMedium?.copyWith(fontWeight: FontWeight.w900)),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

/* -------------- Upcoming match tile -------------- */

class _UpcomingMatchTile extends StatelessWidget {
  final String image;
  final String title;
  final String city;
  final String players;
  final String time;

  const _UpcomingMatchTile({
    required this.image,
    required this.title,
    required this.city,
    required this.players,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return Container(
      width: 180,
      decoration: BoxDecoration(
        color: const Color(0xFFF9F6F2),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.asset(image, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: t.labelLarge?.copyWith(fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Expanded(child: Text(city, style: t.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis)),
                    Text(players, style: t.bodySmall),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(child: Text('Arena/Locn', style: t.bodySmall?.copyWith(color: Colors.black54))),
                    Text(time, style: t.bodySmall?.copyWith(color: Colors.black87)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/* -------------- Stats card with pie + summary -------------- */

class _PieSlice {
  final double value; // 0..1
  final Color color;
  const _PieSlice(this.value, this.color);
}

class _StatsCard extends StatelessWidget {
  final String rating;
  final bool ratingStar;
  final String weeksLabel;
  final String totalMatches;
  final String won;
  final String lost;
  final String draw;
  final List<_PieSlice> pieData;

  const _StatsCard({
    required this.rating,
    required this.ratingStar,
    required this.weeksLabel,
    required this.totalMatches,
    required this.won,
    required this.lost,
    required this.draw,
    required this.pieData,
  });

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header line
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('My Stats', style: t.titleMedium?.copyWith(fontWeight: FontWeight.w900)),
                      const SizedBox(height: 2),
                      Text('Weeks Performance', style: t.bodySmall?.copyWith(color: Colors.black54)),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(rating, style: t.displaySmall?.copyWith(fontSize: 32, fontWeight: FontWeight.w900)),
                    if (ratingStar) ...[
                      const SizedBox(width: 4),
                      const Icon(Icons.star, size: 16, color: Color(0xFFFFC107)),
                    ],
                  ],
                ),
              ],
            ),

            const SizedBox(height: 10),
            const Divider(height: 1),

            const SizedBox(height: 10),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pie chart
                SizedBox(
                  height: 120,
                  width: 120,
                  child: _PieChart(pieData),
                ),

                const SizedBox(width: 16),

                // Right summary grid
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Total Matches', style: t.labelLarge?.copyWith(color: Colors.black54)),
                      const SizedBox(height: 2),
                      Text(totalMatches, style: t.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _StatMini(label: 'Won', value: won),
                          _StatMini(label: 'Lost', value: lost),
                          _StatMini(label: 'Draw', value: draw),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatMini extends StatelessWidget {
  final String label;
  final String value;
  const _StatMini({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(label, style: t.bodySmall?.copyWith(color: Colors.black54)),
        const SizedBox(height: 4),
        Text(value, style: t.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
      ],
    );
  }
}

/* -------------- Minimal pie chart painter -------------- */

class _PieChart extends StatelessWidget {
  final List<_PieSlice> data;
  const _PieChart(this.data);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _PiePainter(data),
    );
  }
}

class _PiePainter extends CustomPainter {
  final List<_PieSlice> data;
  _PiePainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final radius = math.min(size.width, size.height) / 2;
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()..style = PaintingStyle.fill;

    double start = -math.pi / 2;
    for (final s in data) {
      final sweep = s.value * 2 * math.pi;
      paint.color = s.color;
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), start, sweep, true, paint);
      start += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant _PiePainter oldDelegate) => oldDelegate.data != data;
}
