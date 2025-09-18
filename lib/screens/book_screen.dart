// lib/screens/book_screen.dart
import 'package:flutter/material.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  final TextEditingController _search = TextEditingController();

  // Dummy venues
  final _venues = const [
    _Venue(
      title: 'Force Playing Fields',
      city: 'Houston Texas',
      leftImage: 'lib/assests/tennis1.jpeg', // replace with real asset
      leftTag: 'Upto 20% Off',
      rightTop: 'Multy Ground',
      rightBottom: 'Indoor Ground',
    ),
    _Venue(
      title: 'Hope Playing Fields',
      city: 'Houston Texas',
      leftImage: 'lib/assests/tennis2.jpeg', // replace with real asset
      leftTag: 'Upto 20% Off',
      rightTop: 'Single Ground',
      rightBottom: 'Outdoor Ground',
    ),
  ];

  // Filter state
  bool favOnly = false;
  bool offersOnly = false;
  String sportAvailability = 'Sport & Availability';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = theme.textTheme;

    return Container(
      color: const Color(0xFFFFF6EC),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        children: [
          // Search bar
          _SearchBar(
            controller: _search,
            hint: 'Search For Venues',
            onChanged: (_) {},
            onSubmitted: (_) {},
          ), // rounded with prefix and suffix icons [3][9]

          const SizedBox(height: 12),

          // Filter chip row (scrollable if overflow)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _IconChip(icon: Icons.tune, onTap: () {}),
                const SizedBox(width: 10),
                _DropChip(
                  label: sportAvailability,
                  onTap: () async {
                    // TODO open bottom sheet for sport/availability
                    setState(() => sportAvailability = 'Sport & Availability');
                  },
                ),
                const SizedBox(width: 10),
                _ToggleChip(
                  label: 'Favourites',
                  selected: favOnly,
                  onTap: () => setState(() => favOnly = !favOnly),
                ),
                const SizedBox(width: 10),
                _ToggleChip(
                  label: 'Offers',
                  selected: offersOnly,
                  onTap: () => setState(() => offersOnly = !offersOnly),
                ),
              ],
            ),
          ), // uses Material chip patterns for filters [10][21]

          const SizedBox(height: 16),

          // Tab-like “Venues (35)” indicator with underline
          _UnderlineTab(title: 'Venues (35)'),

          const SizedBox(height: 12),

          // Venue cards list
          ..._venues.map((v) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _VenueCard(venue: v),
              )),
        ],
      ),
    );
  }
}

/* ----------------- sub widgets ----------------- */

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  const _SearchBar({
    required this.controller,
    required this.hint,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        prefixIcon: const Icon(Icons.search, color: Colors.black54),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: Color(0xFFE6E1D9)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: Color(0xFFE6E1D9)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: Color(0xFFBDB5A6)),
        ),
      ),
    );
  }
}

class _IconChip extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _IconChip({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
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
          child: const Icon(Icons.tune, size: 18, color: Colors.black87),
        ),
      ),
    );
  }
}

class _DropChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _DropChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final txt = Theme.of(context).textTheme;
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
              Text(label, style: txt.labelLarge?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(width: 6),
              const Icon(Icons.keyboard_arrow_down, size: 18, color: Colors.black54),
            ],
          ),
        ),
      ),
    );
  }
}

class _ToggleChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _ToggleChip({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final txt = Theme.of(context).textTheme;
    return Material(
      color: selected ? const Color(0xFFFFE0B2) : Colors.white,
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
          child: Text(label, style: txt.labelLarge?.copyWith(fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}

class _UnderlineTab extends StatelessWidget {
  final String title;
  const _UnderlineTab({required this.title});

  @override
  Widget build(BuildContext context) {
    final txt = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: txt.titleMedium?.copyWith(fontWeight: FontWeight.w700, color: const Color(0xFFFB8C00))),
        const SizedBox(height: 6),
        Container(height: 2, width: 90, color: const Color(0xFFFB8C00)),
      ],
    );
  }
}

/* ---------- Venue card ---------- */

class _Venue {
  final String title;
  final String city;
  final String leftImage;
  final String leftTag;
  final String rightTop;
  final String rightBottom;
  const _Venue({
    required this.title,
    required this.city,
    required this.leftImage,
    required this.leftTag,
    required this.rightTop,
    required this.rightBottom,
  });
}

class _VenueCard extends StatelessWidget {
  final _Venue venue;
  const _VenueCard({required this.venue});

  @override
  Widget build(BuildContext context) {
    final txt = Theme.of(context).textTheme;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // image with rounded corners
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset(venue.leftImage, fit: BoxFit.cover),
              ),
            ), // Card composition pattern [20][11]

            const SizedBox(height: 12),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left text column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(venue.title, style: txt.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 2),
                      Text(venue.city, style: txt.bodyMedium?.copyWith(color: Colors.black54)),
                      const SizedBox(height: 12),
                      Text(venue.leftTag, style: txt.bodyMedium?.copyWith(color: const Color(0xFFFB8C00), fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                // Right tags
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(venue.rightTop, style: txt.bodyMedium),
                    const SizedBox(height: 12),
                    Text(venue.rightBottom, style: txt.bodyMedium),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
