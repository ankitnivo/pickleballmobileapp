// lib/widgets/coach/file_upload_widget.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import '../../styles/app_theme.dart';

class FileUploadWidget extends StatefulWidget {
  final String title;
  final String description;
  final bool isDocument; // true for PDF/DOC, false for images
  final Function(String path, String fileName) onFileSelected;
  final String? selectedFilePath;

  const FileUploadWidget({
    super.key,
    required this.title,
    required this.description,
    required this.isDocument,
    required this.onFileSelected,
    this.selectedFilePath,
  });

  @override
  State<FileUploadWidget> createState() => _FileUploadWidgetState();
}

class _FileUploadWidgetState extends State<FileUploadWidget> {
  String? _fileName;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    if (widget.selectedFilePath != null) {
      _fileName = widget.selectedFilePath!.split('/').last;
    }
  }

  Future<void> _pickFile() async {
    setState(() => _isUploading = true);
    
    try {
      if (widget.isDocument) {
        // Pick document (PDF, DOC, etc.)
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
        );

        if (result != null && result.files.single.path != null) {
          final file = result.files.single;
          widget.onFileSelected(file.path!, file.name);
          setState(() => _fileName = file.name);
        }
      } else {
        // Pick image
        final ImagePicker picker = ImagePicker();
        final XFile? image = await picker.pickImage(
          source: ImageSource.gallery,
          maxWidth: 1920,
          maxHeight: 1920,
          imageQuality: 85,
        );

        if (image != null) {
          widget.onFileSelected(image.path, image.name);
          setState(() => _fileName = image.name);
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking file: $e')),
      );
    } finally {
      setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              widget.description,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            
            if (_fileName != null) ...[
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Row(
                  children: [
                    Icon(
                      widget.isDocument ? Icons.description : Icons.image,
                      color: Colors.green.shade600,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        _fileName!,
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() => _fileName = null);
                        widget.onFileSelected('', '');
                      },
                      icon: Icon(Icons.close, color: Colors.green.shade600),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
            ],

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _isUploading ? null : _pickFile,
                icon: _isUploading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Icon(widget.isDocument ? Icons.upload_file : Icons.photo_camera),
                label: Text(_isUploading 
                    ? 'Uploading...' 
                    : _fileName != null 
                        ? 'Change File' 
                        : 'Select File'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
