import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/core/widgets/common_widgets.dart';
import 'package:vitalis_app/core/theme/app_theme.dart';

class SocialCreateEventPage extends StatefulWidget {
  final VoidCallback onPop;

  const SocialCreateEventPage({super.key, required this.onPop});

  @override
  State<SocialCreateEventPage> createState() => _SocialCreateEventPageState();
}

class _SocialCreateEventPageState extends State<SocialCreateEventPage> {
  final _nameCtrl = TextEditingController();
  final _dateCtrl = TextEditingController();
  final _timeCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  String _selectedType = 'Entrenamiento';

  @override
  void dispose() {
    _nameCtrl.dispose();
    _dateCtrl.dispose();
    _timeCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear evento'),
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
            decoration: const InputDecoration(labelText: 'Nombre del evento'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _dateCtrl,
            decoration: const InputDecoration(
              labelText: 'Fecha',
              hintText: 'DD/MM/AAAA',
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _timeCtrl,
            decoration: const InputDecoration(
              labelText: 'Hora',
              hintText: 'HH:MM',
            ),
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
          const Text('Tipo',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.accent)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: ['Entrenamiento', 'Nutrición', 'Social']
                .map((t) => Chip(
                      text: t,
                      selected: _selectedType == t,
                      onTap: () => setState(() => _selectedType = t),
                    ))
                .toList(),
          ),
          const SizedBox(height: 20),
          AppButton(
            text: 'Crear evento',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
