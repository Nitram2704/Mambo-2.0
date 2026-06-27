import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/core/widgets/common_widgets.dart';
import 'package:vitalis_app/core/theme/app_theme.dart';

class SocialEvidencePage extends StatefulWidget {
  final VoidCallback onPop;

  const SocialEvidencePage({super.key, required this.onPop});

  @override
  State<SocialEvidencePage> createState() => _SocialEvidencePageState();
}

class _SocialEvidencePageState extends State<SocialEvidencePage> {
  final _notesCtrl = TextEditingController();

  @override
  void dispose() {
    _notesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subir evidencia'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onPop,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.border,
                width: 1.5,
              ),
            ),
            child: const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.cloud_upload_outlined,
                      color: AppColors.textTertiary, size: 36),
                  SizedBox(height: 8),
                  Text('Toca para subir imagen',
                      style: TextStyle(
                          fontSize: 14, color: AppColors.textSecondary)),
                  Text('PNG, JPG máx 5MB',
                      style: TextStyle(
                          fontSize: 11, color: AppColors.textTertiary)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _notesCtrl,
            maxLines: 5,
            decoration: const InputDecoration(
              labelText: 'Notas',
              alignLabelWithHint: true,
              hintText: 'Describe tu resultado...',
            ),
          ),
          const SizedBox(height: 20),
          AppButton(
            text: 'Subir evidencia',
            icon: const Icon(Icons.upload, size: 18),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
