import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/core/theme/app_theme.dart';
import 'package:vitalis_app/core/widgets/common_widgets.dart';
import 'package:vitalis_app/features/sleep/data/mock_sleep_repository.dart';

class SleepHistoryPage extends StatelessWidget {
  final void Function(String) push;
  final VoidCallback pop;
  const SleepHistoryPage({super.key, required this.push, required this.pop});

  @override
  Widget build(BuildContext context) {
    final records = MockSleepRepository().getSleepRecords();

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
                        r.day,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.text,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${r.hours} h',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.accent,
                        ),
                      ),
                      if (r.pill != null) ...[
                        const SizedBox(width: 6),
                        Pill(
                          text: r.pillLabel!,
                          type: r.pill == 'warning'
                              ? PillType.warning
                              : r.pill == 'error'
                                  ? PillType.error
                                  : PillType.success,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                  ProgressBar(progress: r.progress),
                  const SizedBox(height: 6),
                  Text(
                    r.range,
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
