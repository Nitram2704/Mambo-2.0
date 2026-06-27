import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/core/theme/app_theme.dart';
import 'package:vitalis_app/core/widgets/common_widgets.dart';

class TrainingCreate extends StatefulWidget {
  final VoidCallback pop;
  final void Function(String) push;
  const TrainingCreate({super.key, required this.pop, required this.push});
  @override
  State<TrainingCreate> createState() => _TrainingCreateState();
}

class _TrainingCreateState extends State<TrainingCreate> {
  final _titleController = TextEditingController();
  bool get _hasTitle => _titleController.text.trim().isNotEmpty;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  VoidCallback get _pop => widget.pop;
  void Function(String) get _push => widget.push;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: _pop,
          child: const Text('Cancelar',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
        ),
        title: const Text('Nueva Rutina'),
        actions: [
          TextButton(
            onPressed: _hasTitle ? () => _push('guardar') : null,
            child: Text('Guardar',
                style: TextStyle(
                  color: _hasTitle ? AppColors.accent : AppColors.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                )),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              onChanged: (_) => setState(() {}),
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.text),
              decoration: InputDecoration(
                hintText: 'Nombre de la rutina',
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: _hasTitle ? AppColors.accent : AppColors.border.withValues(alpha: 0.3)),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.border.withValues(alpha: 0.3)),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.accent, width: 2),
                ),
                filled: false,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            const SizedBox(height: 60),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.fitness_center_outlined,
                        size: 32, color: AppColors.accent),
                  ),
                  const SizedBox(height: 16),
                  const Text('Empieza agregando un ejercicio',
                      style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
                  const SizedBox(height: 16),
                  AppButton(
                    text: 'Agregar ejercicio',
                    icon: const Icon(Icons.add, size: 18),
                    type: AppButtonType.secondary,
                    onPressed: () => _push('ejercicios'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
