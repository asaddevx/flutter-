import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/app_localizations.dart';

class PhotoPickerDialog {
  static Future<String?> show(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Text(
                l10n.isUrdu ? 'تصویر منتخب کریں' : 'Select Photo',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.camera_alt_rounded, color: Colors.blue),
                ),
                title: Text(l10n.isUrdu ? 'کیمرہ' : 'Camera'),
                subtitle: Text(
                  l10n.isUrdu ? 'تصویر لینے کے لیے کیمرہ کھولیں' : 'Take a photo',
                  style: const TextStyle(fontSize: 12),
                ),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.photo_library_rounded, color: Colors.green),
                ),
                title: Text(l10n.isUrdu ? 'گیلری' : 'Gallery'),
                subtitle: Text(
                  l10n.isUrdu ? 'گیلری سے تصویر منتخب کریں' : 'Choose from gallery',
                  style: const TextStyle(fontSize: 12),
                ),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );

    if (source == null) return null;

    try {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      return image?.path;
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.isUrdu
                ? 'تصویر منتخب کرنے میں خرابی'
                : 'Error picking image'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return null;
    }
  }
}
