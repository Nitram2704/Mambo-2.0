import 'dart:math' as math;
import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/core/widgets/common_widgets.dart';
import 'package:vitalis_app/core/theme/app_theme.dart';
import 'package:vitalis_app/features/nutrition/domain/entities/meal_template.dart';

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
    return ClipRect(
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
    const strokeWidth = 8.0;
    final radius = size.height - strokeWidth;
    final center = Offset(size.width / 2, size.height);
    final rect = Rect.fromCircle(center: center, radius: radius);

    final bgPaint = Paint()
      ..color = AppColors.border.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final fgPaint = Paint()
      ..color = AppColors.accent
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, 0, -math.pi, false, bgPaint);
    canvas.drawArc(rect, 0, -math.pi * progress, false, fgPaint);
  }

  @override
  bool shouldRepaint(covariant GaugePainter oldDelegate) => oldDelegate.progress != progress;
}

class MealCard extends StatefulWidget {
  final MealTemplate template;
  final VoidCallback? onDeleted;
  final ValueChanged<MealTemplate>? onTap;

  const MealCard({
    super.key,
    required this.template,
    this.onDeleted,
    this.onTap,
  });

  @override
  State<MealCard> createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final t = widget.template;

    return Dismissible(
      key: ValueKey('meal_${t.type.name}_${t.time}'),
      direction: widget.onDeleted != null
          ? DismissDirection.endToStart
          : DismissDirection.none,
      confirmDismiss: (_) async {
        return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Eliminar comida'),
            content: Text('¿Eliminar ${t.type.displayName}?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Eliminar',
                    style: TextStyle(color: AppColors.error)),
              ),
            ],
          ),
        );
      },
      onDismissed: (_) => widget.onDeleted?.call(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.error,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 28),
      ),
      child: GestureDetector(
        onTap: () => setState(() => _expanded = !_expanded),
        child: AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(t.icon, color: AppColors.accent, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      t.type.displayName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text,
                      ),
                    ),
                  ),
                  Text(
                    '${t.totalKcal.round()} kcal',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.expand_more,
                        color: AppColors.textTertiary, size: 20),
                  ),
                ],
              ),
              if (_expanded) ...[
                const Divider(height: 24),
                if (t.items.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        children: [
                          Icon(Icons.restaurant_outlined,
                              color: AppColors.textTertiary.withOpacity(0.3),
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
                  )
                else
                  ...t.items.map((item) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                item.name,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppColors.text,
                                ),
                              ),
                            ),
                            Text(
                              '${item.kcal.round()} kcal',
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      )),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class MealTemplateSelector extends StatelessWidget {
  final List<MealTemplate> templates;
  final ValueChanged<MealTemplate> onSelected;

  const MealTemplateSelector({
    super.key,
    required this.templates,
    required this.onSelected,
  });

  static Future<void> show(
    BuildContext context, {
    required List<MealTemplate> templates,
    required ValueChanged<MealTemplate> onSelected,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => MealTemplateSelector(
        templates: templates,
        onSelected: onSelected,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.5,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Agregar Comida',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Selecciona el tipo de comida',
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 16),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: templates.length,
              itemBuilder: (_, i) {
                final t = templates[i];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.accent.withOpacity(0.1),
                    child: Icon(t.icon, color: AppColors.accent, size: 22),
                  ),
                  title: Text(
                    t.type.displayName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.text,
                    ),
                  ),
                  subtitle: Text(
                    '${t.time} · ${t.totalKcal.round()} kcal objetivo',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  trailing: const Icon(Icons.add_circle_outline,
                      color: AppColors.accent, size: 24),
                  onTap: () {
                    Navigator.pop(context);
                    onSelected(t);
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 16),
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
              color: AppColors.accent.withOpacity(0.8),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withOpacity(0.4),
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
      ..color = AppColors.accent.withOpacity(0.1)
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
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
