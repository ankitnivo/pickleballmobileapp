// lib/screens/enroll_as_coach.dart
import 'package:flutter/material.dart';
import '../widgets/file_upload.dart';
import '../models/coach_enrollment.dart';
import '../styles/app_theme.dart';

class EnrollAsCoachScreen extends StatefulWidget {
  const EnrollAsCoachScreen({super.key});

  @override
  State<EnrollAsCoachScreen> createState() => _EnrollAsCoachScreenState();
}

class _EnrollAsCoachScreenState extends State<EnrollAsCoachScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  late AnimationController _progressController;

  int _currentStep = 0;
  final int _totalSteps = 4;

  // Form controllers
  final _experienceController = TextEditingController();
  final _specializationController = TextEditingController();
  final _hourlyRateController = TextEditingController();
  final _bioController = TextEditingController();

  // Form keys
  final _profileFormKey = GlobalKey<FormState>();
  final _statsFormKey = GlobalKey<FormState>();

  // Data
  CertificationType? _certificationType;
  String _documentPath = '';
  String _documentFileName = '';
  Map<String, int> _profileStats = {
    'gamesPlayed': 0,
    'winRate': 0,
    'experience': 0,
  };

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _progressController.dispose();
    _experienceController.dispose();
    _specializationController.dispose();
    _hourlyRateController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _recheckValidity() {
    final bool isValidNow = _profileFormKey.currentState?.validate() ?? false;
    // Only rebuild if the step actually changed validity to avoid redundant setState
    if (isValidNow != (_currentStep == 2 && _canProceedToNext())) {
      setState(
        () {},
      ); // triggers _buildNavigationButtons to re-run _canProceedToNext()
    }
  }

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() => _currentStep++);
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _progressController.animateTo(_currentStep / (_totalSteps - 1));
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _progressController.animateTo(_currentStep / (_totalSteps - 1));
    }
  }

  bool _canProceedToNext() {
    switch (_currentStep) {
      case 0:
        return _certificationType != null;
      case 1:
        return _documentPath.isNotEmpty;
      case 2:
        return _profileFormKey.currentState?.validate() ?? false;
      case 3:
        return _statsFormKey.currentState?.validate() ?? false;
      default:
        return false;
    }
  }

  void _submitApplication() {
    setState(() {
      
    });
    // TODO: Submit to backend
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Application Submitted'),
        content: const Text(
          'Your coach application has been submitted successfully. '
          'We will review your application and get back to you within 2-3 business days.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Close enrollment screen
            },
            child: const Text('OK'),
          ),
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
          'Become a Coach',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // Progress indicator
          _buildProgressIndicator(),

          // Page content
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildCertificationStep(),
                _buildDocumentUploadStep(),
                _buildProfileInfoStep(),
                _buildStatsVerificationStep(),
              ],
            ),
          ),

          // Navigation buttons
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(_totalSteps, (index) {
              final isCompleted = index < _currentStep;
              final isCurrent = index == _currentStep;

              return Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted
                      ? AppColors.primary
                      : isCurrent
                      ? AppColors.primary
                      : Colors.grey.shade300,
                ),
                child: Center(
                  child: isCompleted
                      ? const Icon(Icons.check, color: Colors.white, size: 20)
                      : Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: isCurrent
                                ? Colors.white
                                : Colors.grey.shade600,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              );
            }),
          ),
          const SizedBox(height: AppSpacing.sm),
          AnimatedBuilder(
            animation: _progressController,
            builder: (context, child) {
              return LinearProgressIndicator(
                value: _progressController.value,
                backgroundColor: Colors.grey.shade300,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.primary,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCertificationStep() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Are you a certified coach?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          const Text(
            'This helps us understand your qualification level and provide appropriate verification.',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          _buildCertificationOption(
            type: CertificationType.certified,
            title: 'Yes, I am certified',
            description:
                'I have official coaching certifications from recognized organizations',
            icon: Icons.verified,
          ),
          const SizedBox(height: AppSpacing.lg),

          _buildCertificationOption(
            type: CertificationType.notCertified,
            title: 'No, but I have experience',
            description:
                'I have practical coaching experience but no formal certification',
            icon: Icons.sports_tennis,
          ),
        ],
      ),
    );
  }

  Widget _buildCertificationOption({
    required CertificationType type,
    required String title,
    required String description,
    required IconData icon,
  }) {
    final isSelected = _certificationType == type;

    return InkWell(
      onTap: () => setState(() => _certificationType = type),
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(AppRadius.md),
          color: isSelected
              ? AppColors.primary.withOpacity(0.05)
              : Colors.white,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected ? AppColors.primary : Colors.grey.shade600,
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: AppColors.primary, size: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentUploadStep() {
    final isDocument = _certificationType == CertificationType.certified;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isDocument ? 'Upload Certificate' : 'Upload Profile Image',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            isDocument
                ? 'Please upload your coaching certification document (PDF, DOC, or image).'
                : 'Upload a professional photo of yourself for your coach profile.',
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          FileUploadWidget(
            title: isDocument ? 'Certification Document' : 'Profile Image',
            description: isDocument
                ? 'Accepted formats: PDF, DOC, DOCX, JPG, PNG (Max 10MB)'
                : 'Accepted formats: JPG, PNG (Max 5MB)',
            isDocument: isDocument,
            selectedFilePath: _documentPath.isNotEmpty ? _documentPath : null,
            onFileSelected: (path, fileName) {
              setState(() {
                _documentPath = path;
                _documentFileName = fileName;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfoStep() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Form(
        key: _profileFormKey,
        autovalidateMode:
            AutovalidateMode.onUserInteraction, // validate while typing [docs]
        onChanged: (){setState(() {
        });}, // toggle button as fields change
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ... header text
            TextFormField(
              controller: _experienceController,
              decoration: InputDecoration(
                labelText: 'Years of Experience',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (_) =>
                  _recheckValidity(), // extra safety for immediate update
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'Please enter your experience';
                final n = int.tryParse(value);
                if (n == null || n < 0) return 'Enter a valid number';
                return null;
              },
            ),
            const SizedBox(height: AppSpacing.lg),
            TextFormField(
              controller: _specializationController,
              decoration: InputDecoration(
                labelText: 'Specialization',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
              ),
              onChanged: (_) => _recheckValidity(),
              validator: (v) => (v == null || v.isEmpty)
                  ? 'Please enter your specialization'
                  : null,
            ),
            const SizedBox(height: AppSpacing.lg),
            TextFormField(
              controller: _hourlyRateController,
              decoration: InputDecoration(
                labelText: 'Hourly Rate (\$)',
                prefixText: '\$ ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (_) => _recheckValidity(),
              validator: (v) {
                if (v == null || v.isEmpty)
                  return 'Please enter your hourly rate';
                final rate = double.tryParse(v);
                if (rate == null || rate <= 0)
                  return 'Please enter a valid rate';
                return null;
              },
            ),
            const SizedBox(height: AppSpacing.lg),
            TextFormField(
              controller: _bioController,
              maxLines: 4,
              maxLength: 500,
              decoration: InputDecoration(
                labelText: 'Bio',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
              ),
              onChanged: (_) => _recheckValidity(),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Please write a brief bio';
                if (v.length < 50) return 'Bio must be at least 50 characters';
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsVerificationStep() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Form(
        key: _statsFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Verify Your Stats',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            const Text(
              'Help us verify your playing experience and skill level.',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            _buildStatField(
              'Games Played',
              'Total number of games you\'ve played',
              'gamesPlayed',
            ),
            const SizedBox(height: AppSpacing.lg),

            _buildStatField(
              'Win Rate (%)',
              'Your approximate win rate percentage',
              'winRate',
              suffix: '%',
            ),
            const SizedBox(height: AppSpacing.lg),

            _buildStatField(
              'Playing Experience (Years)',
              'Years you\'ve been playing',
              'experience',
            ),

            const SizedBox(height: AppSpacing.xl),

            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(AppRadius.sm),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue.shade600),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      'Your stats will be verified against your game history and may be adjusted during the review process.',
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatField(
    String label,
    String hint,
    String key, {
    String? suffix,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        suffixText: suffix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
      ),
      keyboardType: TextInputType.number,
      onChanged: (value) {
        final intValue = int.tryParse(value) ?? 0;
        setState(() {
          _profileStats[key] = intValue;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        final intValue = int.tryParse(value);
        if (intValue == null || intValue < 0) {
          return 'Please enter a valid number';
        }
        if (key == 'winRate' && intValue > 100) {
          return 'Win rate cannot exceed 100%';
        }
        return null;
      },
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: _previousStep,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textPrimary,
                  side: BorderSide(color: Colors.grey.shade400),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  minimumSize: const Size.fromHeight(48),
                ),
                child: const Text('Back'),
              ),
            ),

          if (_currentStep > 0) const SizedBox(width: AppSpacing.md),

          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _canProceedToNext()
                  ? (_currentStep == _totalSteps - 1
                        ? _submitApplication
                        : _nextStep)
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                minimumSize: const Size.fromHeight(48),
              ),
              child: Text(
                _currentStep == _totalSteps - 1
                    ? 'Submit Application'
                    : 'Continue',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
