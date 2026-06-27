import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/core/theme/app_theme.dart';
import 'package:vitalis_app/core/widgets/common_widgets.dart';
import 'package:vitalis_app/core/widgets/toast.dart';
import 'package:vitalis_app/features/sleep/presentation/widgets/sleep_widgets.dart';

class SleepRegisterPage extends StatefulWidget {
  final VoidCallback pop;
  const SleepRegisterPage({super.key, required this.pop});
  @override
  State<SleepRegisterPage> createState() => _SleepRegisterPageState();
}

class _SleepRegisterPageState extends State<SleepRegisterPage> {
  TimeOfDay _bedTime = const TimeOfDay(hour: 23, minute: 15);
  TimeOfDay _wakeTime = const TimeOfDay(hour: 6, minute: 30);
  String _quality = 'Bueno';
  final List<String> _qualities = ['Mal', 'Regular', 'Bueno', 'Excelente'];
  final TextEditingController _notesController = TextEditingController();

  Future<void> _pickTime(TimeOfDay current, ValueChanged<TimeOfDay> onChanged) async {
    final picked = await showTimePicker(context: context, initialTime: current);
    if (picked != null) onChanged(picked);
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.accent),
          onPressed: widget.pop,
        ),
        title: const Text('Registrar sueño'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          AppCard(
            child: Column(
              children: [
                TimeSelect(
                  label: 'Acostarse',
                  time: _bedTime,
                  onTap: () => _pickTime(_bedTime, (t) => setState(() => _bedTime = t)),
                ),
                const Divider(height: 1, color: Color(0x26B89066)),
                TimeSelect(
                  label: 'Despertar',
                  time: _wakeTime,
                  onTap: () => _pickTime(_wakeTime, (t) => setState(() => _wakeTime = t)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const SectionTitle(text: 'CALIDAD DEL SUEÑO'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _qualities.map((q) => Chip(
              text: q,
              selected: _quality == q,
              onTap: () => setState(() => _quality = q),
            )).toList(),
          ),
          const SizedBox(height: 12),
          const SectionTitle(text: 'NOTAS'),
          TextField(
            controller: _notesController,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: '¿Cómo te sientes?',
            ),
          ),
          const SizedBox(height: 20),
          AppButton(
            text: 'Guardar',
            onPressed: () {
              final toast = ToastOverlayState.of(context);
              if (toast != null) toast.show('Sueño registrado');
              widget.pop();
            },
          ),
        ],
      ),
    );
  }
}
