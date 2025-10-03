// lib/models/coach_enrollment.dart
enum CertificationType { certified, notCertified }
enum CoachStatus { pending, approved, rejected }
enum DocumentType { certificate, image }

class CoachEnrollment {
  final String userId;
  final CertificationType certificationType;
  final String? documentPath;
  final DocumentType? documentType;
  final Map<String, dynamic> profileStats;
  final String experience;
  final String specialization;
  final double hourlyRate;
  final String bio;
  final CoachStatus status;
  final DateTime createdAt;

  const CoachEnrollment({
    required this.userId,
    required this.certificationType,
    this.documentPath,
    this.documentType,
    required this.profileStats,
    required this.experience,
    required this.specialization,
    required this.hourlyRate,
    required this.bio,
    this.status = CoachStatus.pending,
    required this.createdAt,
  });
}
