// lib/screens/location_picker_screen.dart
import 'package:flutter/material.dart';
import '../styles/app_theme.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  final TextEditingController _searchCtrl = TextEditingController();

  // Mock state
  String _selectedAddress = 'Unknown';
  double _lat = 29.7604;   // Houston default
  double _lng = -95.3698;

  // Mock recent locations
  final List<_RecentLoc> _recents = const [
    _RecentLoc('Home', '123 Main St, Houston, TX', 29.76, -95.36),
    _RecentLoc('Work', '200 Market St, Houston, TX', 29.75, -95.37),
    _RecentLoc('Tennis Club', '45 Court Ave, Houston, TX', 29.77, -95.35),
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _useCurrentLocation() async {
    // TODO: integrate geolocator to fetch current GPS and reverse geocode
    setState(() {
      _selectedAddress = 'Current location (mock)';
      _lat = 29.7604;
      _lng = -95.3698;
    });
    _showConfirmSheet();
  }

  void _onSearchTapped() async {
    // TODO: open autocomplete modal (Google Places / OSM)
    // After selection, update state and call _showConfirmSheet();
  }

  void _onDragPinEnd(double lat, double lng) {
    // TODO: reverse geocode to address
    setState(() {
      _lat = lat;
      _lng = lng;
      _selectedAddress = 'Pinned at ($_lat, $_lng)';
    });
  }

  void _showConfirmSheet() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets.add(
            const EdgeInsets.fromLTRB(16, 12, 16, 24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Icon(Icons.place_outlined, color: AppColors.primary),
                  SizedBox(width: 8),
                  Text('Confirm location', style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(height: 12),
              Text(_selectedAddress, style: const TextStyle(
                fontSize: 14, color: AppColors.textPrimary, height: 1.35)),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context, {
                      'address': _selectedAddress,
                      'lat': _lat, 'lng': _lng,
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                  ),
                  child: const Text('Use this location'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return GestureDetector(
      onTap: _onSearchTapped,
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.grey.shade600),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Search for a place, address…',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
            ),
            Icon(Icons.place_outlined, color: Colors.grey.shade600),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentLocationButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: OutlinedButton.icon(
        onPressed: _useCurrentLocation,
        icon: const Icon(Icons.my_location_rounded),
        label: const Text('Use current location'),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          side: BorderSide(color: Colors.grey.shade400),
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
          minimumSize: const Size.fromHeight(48),
        ),
      ),
    );
  }

  Widget _buildMapPreview() {
    // Placeholder map UI; swap with GoogleMap/OSM later
    return Container(
      height: 280,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        image: const DecorationImage(
          image: AssetImage('assets/images/map_placeholder.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Center pin
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.location_pin, size: 42, color: AppColors.primary),
              SizedBox(height: 4),
            ],
          ),
          // Bottom action
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: ElevatedButton.icon(
              onPressed: _showConfirmSheet,
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Set this location'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                minimumSize: const Size.fromHeight(46),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecents() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          const Text('Recent', style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          ..._recents.map((r) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFF1EFEA),
                  child: Icon(Icons.history, color: AppColors.primary),
                ),
                title: Text(r.label, style: const TextStyle(
                  fontWeight: FontWeight.w600)),
                subtitle: Text(r.address, maxLines: 1, overflow: TextOverflow.ellipsis),
                onTap: () {
                  setState(() {
                    _lat = r.lat; _lng = r.lng;
                    _selectedAddress = r.address;
                  });
                  _showConfirmSheet();
                },
              )),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.cream,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Select location',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 8),
          _buildSearchBar(),
          _buildCurrentLocationButton(),
          _buildMapPreview(),
          _buildRecents(),
        ],
      ),
    );
  }
}

class _RecentLoc {
  final String label;
  final String address;
  final double lat;
  final double lng;
  const _RecentLoc(this.label, this.address, this.lat, this.lng);
}
