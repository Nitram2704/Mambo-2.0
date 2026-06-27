import 'dart:math' as math;
import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/core/widgets/common_widgets.dart';
import 'package:vitalis_app/core/theme/app_theme.dart';

class CurvedGauge extends StatelessWidget {
  final double progress;
  final String value;
  final String label;
  const CurvedGauge({
    super.key,
    required this.progress,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: CustomPaint(
        painter: GaugePainter(progress: progress.clamp(0, 1)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(value,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: AppColors.text,
                  )),
              Text(label,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class GaugePainter extends CustomPainter {
  final double progress;
  GaugePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final radius = size.width / 2 - 8;
    final rect = Rect.fromCircle(center: Offset(centerX, size.height), radius: radius);

    final bgPaint = Paint()
      ..color = AppColors.border.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    final fgPaint = Paint()
      ..color = AppColors.accent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, math.pi, -math.pi, false, bgPaint);
    canvas.drawArc(rect, math.pi, -math.pi * progress, false, fgPaint);
  }

  @override
  bool shouldRepaint(covariant GaugePainter old) => old.progress != progress;
}

class MealCard extends StatelessWidget {
  final String name;
  final IconData icon;
  const MealCard({super.key, required this.name, required this.icon});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.accent, size: 20),
              const SizedBox(width: 8),
              Text(name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  )),
              const Spacer(),
              const Text('0 kcal',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  )),
            ],
          ),
          const Divider(height: 24),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.restaurant_outlined,
                      color: AppColors.textTertiary.withValues(alpha: 0.3),
                      size: 32),
                  const SizedBox(height: 8),
                  const Text('No hay alimentos registrados',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textTertiary,
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PulsingLine extends StatefulWidget {
  const PulsingLine({super.key});
  @override
  State<PulsingLine> createState() => _PulsingLineState();
}

class _PulsingLineState extends State<PulsingLine>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Positioned(
          top: _controller.value * (180 - 4),
          left: 0,
          right: 0,
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.8),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.4),
                  blurRadius: 8,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ScannerGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.accent.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (double x = 0; x < size.width; x += 20) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 20) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    final cornerPaint = Paint()
      ..color = AppColors.accent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    const cornerLen = 20.0;
    canvas.drawLine(
        Offset(0, cornerLen), Offset(0, 0), cornerPaint);
    canvas.drawLine(
        Offset(0, 0), Offset(cornerLen, 0), cornerPaint);
    canvas.drawLine(
        Offset(size.width - cornerLen, 0), Offset(size.width, 0), cornerPaint);
    canvas.drawLine(
        Offset(size.width, 0), Offset(size.width, cornerLen), cornerPaint);
    canvas.drawLine(Offset(size.width, size.height - cornerLen),
        Offset(size.width, size.height), cornerPaint);
    canvas.drawLine(Offset(size.width, size.height),
        Offset(size.width - cornerLen, size.height), cornerPaint);
    canvas.drawLine(
        Offset(cornerLen, size.height), Offset(0, size.height), cornerPaint);
    canvas.drawLine(
        Offset(0, size.height), Offset(0, size.height - cornerLen), cornerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
