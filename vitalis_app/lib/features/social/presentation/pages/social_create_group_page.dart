import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/core/widgets/common_widgets.dart';
import 'package:vitalis_app/core/theme/app_theme.dart';

class SocialCreateGroupPage extends StatefulWidget {
  final VoidCallback onPop;

  const SocialCreateGroupPage({super.key, required this.onPop});

  @override
  State<SocialCreateGroupPage> createState() => _SocialCreateGroupPageState();
}

class _SocialCreateGroupPageState extends State<SocialCreateGroupPage> {
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  bool _isPublico = true;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear grupo'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onPop,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
        children: [
          TextField(
            controller: _nameCtrl,
            decoration: const InputDecoration(labelText: 'Nombre del grupo'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _descCtrl,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Descripción',
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 16),
          const Text('Privacidad',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.accent)),
          const SizedBox(height: 8),
          Row(
            children: [
              Chip(
                text: 'Público',
                selected: _isPublico,
                onTap: () => setState(() => _isPublico = true),
              ),
              const SizedBox(width: 8),
              Chip(
                text: 'Privado',
                selected: !_isPublico,
                onTap: () => setState(() => _isPublico = false),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const SectionTitle(text: 'MIEMBROS'),
          AppCard(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.person_add, color: AppColors.accent, size: 20),
                const SizedBox(width: 10),
                const Text('Añadir miembros',
                    style: TextStyle(
                        fontSize: 14, color: AppColors.textSecondary)),
                const Spacer(),
                const Text('0',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textTertiary)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          AppButton(
            text: 'Crear grupo',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
