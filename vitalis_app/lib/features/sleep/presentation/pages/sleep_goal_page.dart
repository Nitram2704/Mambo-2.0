import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/core/theme/app_theme.dart';
import 'package:vitalis_app/core/widgets/common_widgets.dart';
import 'package:vitalis_app/core/widgets/toast.dart';
import 'package:vitalis_app/features/sleep/presentation/widgets/sleep_widgets.dart';

class SleepGoalPage extends StatefulWidget {
  final VoidCallback pop;
  const SleepGoalPage({super.key, required this.pop});
  @override
  State<SleepGoalPage> createState() => _SleepGoalPageState();
}

class _SleepGoalPageState extends State<SleepGoalPage> {
  int _hours = 8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.accent),
          onPressed: widget.pop,
        ),
        title: const Text('Objetivo de sueño'),
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
                        painter: BigRingPainter(
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
                    RoundButton(
                      icon: Icons.remove,
                      onPressed: _hours > 4 ? () => setState(() => _hours--) : null,
                    ),
                    const SizedBox(width: 40),
                    RoundButton(
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
