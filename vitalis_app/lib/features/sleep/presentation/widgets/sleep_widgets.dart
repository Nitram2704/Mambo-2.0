import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/core/theme/app_theme.dart';

class RoundButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  const RoundButton({super.key, required this.icon, this.onPressed});

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

class BigRingPainter extends CustomPainter {
  final double progress;
  final Color color;
  BigRingPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 8;
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = AppColors.border.withValues(alpha: 0.15)
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

class TimeSelect extends StatelessWidget {
  final String label;
  final TimeOfDay time;
  final VoidCallback onTap;
  const TimeSelect({super.key, required this.label, required this.time, required this.onTap});

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
