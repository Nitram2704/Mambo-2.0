import 'package:flutter/material.dart';
import 'package:vitalis_app/theme/app_theme.dart';
import 'package:vitalis_app/widgets/common_widgets.dart';
import 'package:vitalis_app/widgets/toast.dart';
import 'package:vitalis_app/widgets/phone_frame.dart';

class SleepScreens extends StatefulWidget {
  final int tab;
  final PhoneFrameState phoneFrame;
  const SleepScreens({super.key, required this.tab, required this.phoneFrame});
  @override
  State<SleepScreens> createState() => SleepScreensState();
}

class SleepScreensState extends State<SleepScreens> {
  final List<String> _stack = ['main'];

  void push(String view) {
    setState(() {
      _stack.add(view);
    });
  }

  void pop() {
    if (_stack.length > 1) setState(() {
      _stack.removeLast();
    });
  }

  @override
  void initState() {
    super.initState();
    Nav.register(tab, push, pop);
  }

  @override
  Widget build(BuildContext context) {
    final view = _stack.last;
    return KeyedSubtree(key: ValueKey(view), child: _buildScreen(view));
  }

  Widget _buildScreen(String view) {
    switch (view) {
      case 'main':
        return _SleepMain(push: push);
      case 'historial':
        return _SleepHistory(push: push, pop: pop);
      case 'objetivo':
        return _SleepGoal(pop: pop);
      case 'recordatorio':
        return _SleepReminder(pop: pop);
      case 'registrar':
        return _SleepRegister(pop: pop);
      default:
        return _SleepMain(push: push);
    }
  }
}

class _SleepMain extends StatelessWidget {
  final void Function(String) push;
  const _SleepMain({required this.push});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sueño')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        children: [
          const SizedBox(height: 8),
          Row(
            children: [
              const RingProgress(progress: 0.9, text: '7:12'),
              const SizedBox(width: 16),
              const StatCard(value: '92', label: 'Puntaje'),
              const SizedBox(width: 8),
              const StatCard(value: '6d', label: 'Racha'),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Objetivo: 8:00 h',
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.2),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: AppCard(
                  onTap: () => push('registrar'),
                  padding: const EdgeInsets.all(14),
                  child: const Column(
                    children: [
                      Icon(Icons.bedtime_outlined, color: AppColors.accent, size: 28),
                      SizedBox(height: 8),
                      Text(
                        'Registrar\nsueño',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: AppColors.text, height: 1.3),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: AppCard(
                  onTap: () => push('recordatorio'),
                  padding: const EdgeInsets.all(14),
                  child: const Column(
                    children: [
                      Icon(Icons.notifications_outlined, color: AppColors.accent, size: 28),
                      SizedBox(height: 8),
                      Text(
                        'Generar\nrecordatorio',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: AppColors.text, height: 1.3),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: AppCard(
                  onTap: () => push('historial'),
                  padding: const EdgeInsets.all(14),
                  child: const Column(
                    children: [
                      Icon(Icons.history, color: AppColors.accent, size: 28),
                      SizedBox(height: 8),
                      Text(
                        'Historial',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: AppColors.text, height: 1.3),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: AppCard(
                  onTap: () => push('objetivo'),
                  padding: const EdgeInsets.all(14),
                  child: const Column(
                    children: [
                      Icon(Icons.track_changes, color: AppColors.accent, size: 28),
                      SizedBox(height: 8),
                      Text(
                        'Objetivo',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: AppColors.text, height: 1.3),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SleepHistory extends StatelessWidget {
  final void Function(String) push;
  final VoidCallback pop;
  const _SleepHistory({required this.push, required this.pop});

  @override
  Widget build(BuildContext context) {
    final records = [
      {
        'day': 'Hoy',
        'hours': '7:12',
        'progress': 0.9,
        'range': '23:15 \u2013 06:27',
        'pill': null as String?,
        'pillLabel': null as String?,
      },
      {
        'day': 'Ayer',
        'hours': '6:45',
        'progress': 0.84,
        'range': '00:30 \u2013 07:15',
        'pill': 'warning',
        'pillLabel': 'Poco',
      },
      {
        'day': 'Lun',
        'hours': '8:00',
        'progress': 1.0,
        'range': '22:30 \u2013 06:30',
        'pill': 'success',
        'pillLabel': 'Bien',
      },
      {
        'day': 'Dom',
        'hours': '5:30',
        'progress': 0.69,
        'range': '02:00 \u2013 07:30',
        'pill': 'error',
        'pillLabel': 'Muy poco',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.accent),
          onPressed: pop,
        ),
        title: const Text('Historial'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        children: [
          const SizedBox(height: 8),
          ...records.map((r) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        r['day'] as String,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.text,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${r['hours']} h',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.accent,
                        ),
                      ),
                      if (r['pill'] != null) ...[
                        const SizedBox(width: 6),
                        Pill(
                          text: r['pillLabel'] as String,
                          type: r['pill'] == 'warning'
                              ? PillType.warning
                              : r['pill'] == 'error'
                                  ? PillType.error
                                  : PillType.success,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                  ProgressBar(progress: r['progress'] as double),
                  const SizedBox(height: 6),
                  Text(
                    r['range'] as String,
                    style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
          )),
          const SizedBox(height: 8),
          AppButton(
            text: '+ Registrar noche',
            type: AppButtonType.secondary,
            onPressed: () => push('registrar'),
          ),
        ],
      ),
    );
  }
}

class _SleepGoal extends StatefulWidget {
  final VoidCallback pop;
  const _SleepGoal({required this.pop});
  @override
  State<_SleepGoal> createState() => _SleepGoalState();
}

class _SleepGoalState extends State<_SleepGoal> {
  int _hours = 8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.accent),
          onPressed: widget.pop,
        ),
        title: const Text('Objetivo de sue\u00f1o'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(
                  width: 160,
                  height: 160,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomPaint(
                        size: const Size(160, 160),
                        painter: _BigRingPainter(
                          progress: _hours / 12.0,
                          color: AppColors.accent,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${_hours.toString().padLeft(2, '0')}:00',
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                              color: AppColors.text,
                            ),
                          ),
                          const Text(
                            'horas',
                            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _RoundButton(
                      icon: Icons.remove,
                      onPressed: _hours > 4 ? () => setState(() => _hours--) : null,
                    ),
                    const SizedBox(width: 40),
                    _RoundButton(
                      icon: Icons.add,
                      onPressed: _hours < 12 ? () => setState(() => _hours++) : null,
                    ),
                  ],
                ),
                const SizedBox(height: 36),
                AppButton(
                  text: 'Guardar objetivo',
                  onPressed: () {
                    final toast = ToastOverlayState.of(context);
                    if (toast != null) toast.show('Objetivo guardado: $_hours h');
                    widget.pop();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  const _RoundButton({required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final isActive = onPressed != null;
    return Material(
      color: isActive ? AppColors.accent : AppColors.surface,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Container(
          width: 48,
          height: 48,
          alignment: Alignment.center,
          child: Icon(
            icon,
            color: isActive ? AppColors.bg : AppColors.textTertiary,
          ),
        ),
      ),
    );
  }
}

class _BigRingPainter extends CustomPainter {
  final double progress;
  final Color color;
  _BigRingPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 8;
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = AppColors.border.withOpacity(0.15)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 8,
    );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -1.5708,
      6.2832 * progress.clamp(0, 1),
      false,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 8
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => true;
}

class _SleepReminder extends StatefulWidget {
  final VoidCallback pop;
  const _SleepReminder({required this.pop});
  @override
  State<_SleepReminder> createState() => _SleepReminderState();
}

class _SleepReminderState extends State<_SleepReminder> {
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
                _TimeSelect(
                  label: 'Acostarse',
                  time: _bedTime,
                  onTap: () => _pickTime(_bedTime, (t) => setState(() => _bedTime = t)),
                ),
                const Divider(height: 1, color: Color(0x26B89066)),
                _TimeSelect(
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
          const SectionTitle(text: 'D\u00cdAS'),
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

class _TimeSelect extends StatelessWidget {
  final String label;
  final TimeOfDay time;
  final VoidCallback onTap;
  const _TimeSelect({required this.label, required this.time, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final display =
        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            Text(label, style: const TextStyle(fontSize: 14, color: AppColors.text)),
            const Spacer(),
            Text(
              display,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.accent),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.expand_more, color: AppColors.textSecondary, size: 20),
          ],
        ),
      ),
    );
  }
}

class _SleepRegister extends StatefulWidget {
  final VoidCallback pop;
  const _SleepRegister({required this.pop});
  @override
  State<_SleepRegister> createState() => _SleepRegisterState();
}

class _SleepRegisterState extends State<_SleepRegister> {
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
        title: const Text('Registrar sue\u00f1o'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          AppCard(
            child: Column(
              children: [
                _TimeSelect(
                  label: 'Acostarse',
                  time: _bedTime,
                  onTap: () => _pickTime(_bedTime, (t) => setState(() => _bedTime = t)),
                ),
                const Divider(height: 1, color: Color(0x26B89066)),
                _TimeSelect(
                  label: 'Despertar',
                  time: _wakeTime,
                  onTap: () => _pickTime(_wakeTime, (t) => setState(() => _wakeTime = t)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const SectionTitle(text: 'CALIDAD DEL SUE\u00d1O'),
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
              hintText: '\u00bfC\u00f3mo te sientes?',
            ),
          ),
          const SizedBox(height: 20),
          AppButton(
            text: 'Guardar',
            onPressed: () {
              final toast = ToastOverlayState.of(context);
              if (toast != null) toast.show('Sue\u00f1o registrado');
              widget.pop();
            },
          ),
        ],
      ),
    );
  }
}
