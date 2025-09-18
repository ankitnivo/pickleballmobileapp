// lib/screens/play_page.dart
import 'package:flutter/material.dart';

class PlayPage extends StatefulWidget {
  const PlayPage({super.key});

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> with SingleTickerProviderStateMixin {
  // Top tabs
  final List<String> _tabs = const ['Calendar', 'Recommended', 'My Sports', 'Other Sports'];
  int _tabIndex = 1; // “Recommended” as in screenshot

  // Category chip
  final List<String> _sports = const ['Pickleball'];
  int _sportIndex = 0;

  // Date chips
  late final List<DateTime> _dates;
  int _dateIndex = 0;

  // Filters
  String _time = 'Time';
  String _skill = 'Skill Level';
  bool _filtersApplied = false;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _dates = List.generate(9, (i) => now.add(Duration(days: i)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = theme.textTheme;

    return Container(
      color: const Color(0xFFFFF6EC), // cream background similar to screenshot
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        children: [
          // Top segmented tabs
          _TopTabs(
            tabs: _tabs,
            index: _tabIndex,
            onChanged: (i) => setState(() => _tabIndex = i),
          ),

          const SizedBox(height: 8),

          // Category chip row
          // _ChipRow.single(
          //   children: List.generate(_sports.length, (i) {
          //     final selected = i == _sportIndex;
          //     return ChoiceChip(
          //       label: Text(_sports[i]),
          //       selected: selected,
          //       onSelected: (_) => setState(() => _sportIndex = i),
          //       visualDensity: VisualDensity.compact,
          //       shape: StadiumBorder(
          //         side: BorderSide(color: selected ? const Color(0xFFFB8C00) : const Color(0xFFFFE0B2)),
          //       ),
          //       selectedColor: const Color(0xFFFFE0B2),
          //       labelStyle: text.labelLarge?.copyWith(
          //         color: Colors.black87,
          //         fontWeight: FontWeight.w600,
          //       ),
          //       backgroundColor: const Color(0xFFFFF0DC),
          //     );
          //   }),
          // ),

          // const SizedBox(height: 8),

          // Horizontal date scroller
          SizedBox(
            height: 60,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _dates.length,
              padding: const EdgeInsets.symmetric(horizontal: 2),
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, i) {
                final d = _dates[i];
                final selected = i == _dateIndex;
                final dayNum = d.day.toString().padLeft(2, '0');
                final weekday = _weekdayShort(d.weekday);
                return GestureDetector(
                  onTap: () => setState(() => _dateIndex = i),
                  child: Container(
                    width: 64,
                    decoration: BoxDecoration(
                      color: selected ? Colors.white : const Color(0xFFFFF0DC),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: selected
                          ? [BoxShadow(color: Colors.black12, blurRadius: 6, offset: const Offset(0, 2))]
                          : null,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(dayNum, style: text.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                        const SizedBox(height: 4),
                        Text(weekday, style: text.bodySmall?.copyWith(color: Colors.black54)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          // Filter row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _FilterChipButton(
                  label: _filtersApplied ? 'Filter • 1' : 'Filter',
                  icon: Icons.tune,
                  onTap: () {
                    // TODO: open filter bottom sheet
                    setState(() => _filtersApplied = !_filtersApplied);
                  },
                ),
                const SizedBox(width: 12),
                _FilterChipButton(
                  label: _time,
                  icon: Icons.access_time,
                  onTap: () async {
                    // TODO: show time picker/sheet
                    setState(() => _time = _time == 'Time' ? 'Evening' : 'Time');
                  },
                ),
                const SizedBox(width: 12),
                _FilterChipButton(
                  label: _skill,
                  icon: Icons.bar_chart,
                  onTap: () async {
                    // TODO: show skill picker
                    setState(() => _skill = _skill == 'Skill Level' ? 'Amateur - Advanced' : 'Skill Level');
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Event card
          _EventCard(
            titleLeading: 'Doubles • Regular',
            goingText: '1/7 Going',
            price: '\$21.00',
            organizer: 'GameTime By Playo',
            metric: '377.93K Joy',
            dateTimeLine: 'Fri 12 Sep, 6:00 PM',
            locationLine: 'Houston, Texas',
            badgeText: 'BOOKED',
            skillPill: 'Amateur - Advanced',
            onBookmark: () {},
            onTap: () {},
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  String _weekdayShort(int weekday) {
    const map = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    return map[(weekday - 1) % 7];
  }
}

/* ---------- Widgets ---------- */

// Top tabs styled like segmented buttons
class _TopTabs extends StatelessWidget {
  final List<String> tabs;
  final int index;
  final ValueChanged<int> onChanged;

  const _TopTabs({required this.tabs, required this.index, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xFFFFA726), // orange bar in screenshot
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: List.generate(tabs.length, (i) {
          final selected = i == index;
          return Expanded(
            child: InkWell(
              onTap: () => onChanged(i),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: selected ? Colors.black : Colors.transparent,
                      width: 3,
                    ),
                  ),
                ),
                child: Text(
                  tabs[i],
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: selected? Colors.black: Colors.white,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    fontSize: 12
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// Wrap of chips with small spacing
class _ChipRow extends StatelessWidget {
  final List<Widget> children;

  const _ChipRow.single({required this.children});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: children,
    );
  }
}

// Filter chip-like buttons with icon and down arrow
class _FilterChipButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _FilterChipButton({required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
            border: Border.all(color: const Color(0xFFE6E1D9)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: Colors.black87),
              const SizedBox(width: 8),
              Text(label, style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(width: 4),
              const Icon(Icons.keyboard_arrow_down, size: 18, color: Colors.black54),
            ],
          ),
        ),
      ),
    );
  }
}

// Event card UI
class _EventCard extends StatelessWidget {
  final String titleLeading;      // e.g., "Doubles • Regular"
  final String goingText;         // e.g., "1/7 Going"
  final String price;             // e.g., "$21.00"
  final String organizer;         // e.g., "GameTime By Playo"
  final String metric;            // e.g., "377.93K Joy"
  final String dateTimeLine;      // e.g., "Fri 12 Sep, 6:00 PM"
  final String locationLine;      // e.g., "Houston, Texas"
  final String skillPill;         // e.g., "Amateur - Advanced"
  final String badgeText;         // e.g., "BOOKED"
  final VoidCallback onTap;
  final VoidCallback onBookmark;

  const _EventCard({
    required this.titleLeading,
    required this.goingText,
    required this.price,
    required this.organizer,
    required this.metric,
    required this.dateTimeLine,
    required this.locationLine,
    required this.skillPill,
    required this.badgeText,
    required this.onTap,
    required this.onBookmark,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row: avatar icon + “1/7 Going” + price
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left circular icon
                  Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFF59D),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.lightbulb_outline, color: Color(0xFFF57F17)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(titleLeading, style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black54)),
                        const SizedBox(height: 6),
                        Text(goingText, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(price, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 4),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(Icons.bookmark_border),
                        onPressed: onBookmark,
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Organizer + metric
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '$organizer  |  $metric',
                      style: theme.textTheme.bodySmall?.copyWith(color: Colors.black54),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // DateTime line
              Row(
                children: [
                  const Icon(Icons.event, size: 18, color: Colors.black87),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(dateTimeLine, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Location line
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 18, color: Colors.black87),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(locationLine, style: theme.textTheme.bodyMedium),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Skill pill + BOOKED badge
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 34,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F2ED),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFE6E1D9)),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        skillPill,
                        style: theme.textTheme.labelLarge?.copyWith(color: Colors.black87, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2ECC71),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      badgeText,
                      style: theme.textTheme.labelLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
