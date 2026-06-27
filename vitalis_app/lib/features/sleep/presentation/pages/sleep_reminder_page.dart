import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/core/theme/app_theme.dart';
import 'package:vitalis_app/core/widgets/common_widgets.dart';
import 'package:vitalis_app/core/widgets/toast.dart';
import 'package:vitalis_app/features/sleep/presentation/widgets/sleep_widgets.dart';

class SleepReminderPage extends StatefulWidget {
  final VoidCallback pop;
  const SleepReminderPage({super.key, required this.pop});
  @override
  State<SleepReminderPage> createState() => _SleepReminderPageState();
}

class _SleepReminderPageState extends State<SleepReminderPage> {
  TimeOfDay _bedTime = const TimeOfDay(hour: 22, minute: 0);
  TimeOfDay _wakeTime = const TimeOfDay(hour: 6, minute: 30);
  bool _dailyReminder = true;
  bool _relaxingSound = false;
  final List<String> _days = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];
  final Set<String> _selectedDays = {'L', 'M', 'X', 'J', 'V', 'S'};

  Future<void> _pickTime(TimeOfDay current, ValueChanged<TimeOfDay> onChanged) async {
    final picked = await showTimePicker(context: context, initialTime: current);
    if (picked != null) onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.accent),
          onPressed: widget.pop,
        ),
        title: const Text('Recordatorio'),
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
          const SizedBox(height: 16),
          AppCard(
            child: Column(
              children: [
                ToggleRow(
                  label: 'Recordatorio diario',
                  value: _dailyReminder,
                  onChanged: (v) => setState(() => _dailyReminder = v),
                ),
                ToggleRow(
                  label: 'Sonido relajante',
                  value: _relaxingSound,
                  onChanged: (v) => setState(() => _relaxingSound = v),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const SectionTitle(text: 'DÍAS'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _days.map((d) => Chip(
              text: d,
              selected: _selectedDays.contains(d),
              onTap: () => setState(() {
                if (_selectedDays.contains(d)) {
                  _selectedDays.remove(d);
                } else {
                  _selectedDays.add(d);
                }
              }),
            )).toList(),
          ),
          const SizedBox(height: 20),
          AppButton(
            text: 'Guardar recordatorio',
            onPressed: () {
              final toast = ToastOverlayState.of(context);
              if (toast != null) toast.show('Recordatorio guardado');
              widget.pop();
            },
          ),
        ],
      ),
    );
  }
}
