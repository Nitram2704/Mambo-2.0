import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final Widget? icon;
  final double? width;
  final bool loading;
  final bool disabled;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = AppButtonType.primary,
    this.icon,
    this.width,
    this.loading = false,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = disabled || loading;
    Color bg, fg, border;
    switch (type) {
      case AppButtonType.primary:
        bg = AppColors.accent; fg = AppColors.bg; border = Colors.transparent;
      case AppButtonType.secondary:
        bg = AppColors.surface; fg = AppColors.text; border = AppColors.border;
      case AppButtonType.ghost:
        bg = Colors.transparent; fg = AppColors.accent; border = Colors.transparent;
    }

    return SizedBox(
      width: width ?? double.infinity,
      child: AnimatedOpacity(
        opacity: isDisabled ? 0.5 : 1,
        duration: const Duration(milliseconds: 200),
        child: TextButton(
          onPressed: isDisabled ? null : onPressed,
          style: TextButton.styleFrom(
            backgroundColor: bg,
            foregroundColor: fg,
            side: border == Colors.transparent ? null : BorderSide(color: border),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          child: loading
              ? SizedBox(width: 20, height: 20, child: CircularProgressIndicator(
                  strokeWidth: 2, color: type == AppButtonType.secondary ? AppColors.text : AppColors.bg,
                ))
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) ...[icon!, const SizedBox(width: 8)],
                    Text(text),
                  ],
                ),
        ),
      ),
    );
  }
}

enum AppButtonType { primary, secondary, ghost }

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;
  final VoidCallback? onTap;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.borderColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: borderColor ?? AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
    if (onTap != null) {
      return InkWell(onTap: onTap, borderRadius: BorderRadius.circular(8), child: card);
    }
    return card;
  }
}

class StatCard extends StatelessWidget {
  final String value;
  final String label;
  final Widget? leading;

  const StatCard({super.key, required this.value, required this.label, this.leading});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(8),
        ),
        child: leading != null
            ? Row(children: [leading!, const SizedBox(width: 8), Expanded(child: _content())])
            : Column(children: [
                Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.accent, height: 1.1)),
                const SizedBox(height: 2),
                Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
              ]),
      ),
    );
  }

  Widget _content() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.accent, height: 1.1)),
      Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
    ],
  );
}

class AppToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const AppToggle({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 44,
        height: 24,
        decoration: BoxDecoration(
          color: value ? AppColors.accent : AppColors.border.withOpacity(0.25),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(2),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              color: Color(0xFFE8E4DF),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}

class ToggleRow extends StatelessWidget {
  final String label;
  final String? subLabel;
  final bool value;
  final ValueChanged<bool> onChanged;

  const ToggleRow({
    super.key,
    required this.label,
    this.subLabel,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0x1FB89066))),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 14, color: AppColors.text)),
                if (subLabel != null)
                  Text(subLabel!, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          AppToggle(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String text;

  const SectionTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(text, style: const TextStyle(
        fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.accent,
        letterSpacing: 0.05,
      )),
    );
  }
}

class Chip extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback? onTap;

  const Chip({super.key, required this.text, this.selected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.accent : AppColors.surface,
          border: Border.all(color: selected ? AppColors.accent : AppColors.border),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(text, style: TextStyle(
          fontSize: 13, fontWeight: FontWeight.w600,
          color: selected ? AppColors.bg : AppColors.textSecondary,
        )),
      ),
    );
  }
}

class Pill extends StatelessWidget {
  final String text;
  final PillType type;

  const Pill({super.key, required this.text, this.type = PillType.success});

  @override
  Widget build(BuildContext context) {
    Color bg, fg;
    switch (type) {
      case PillType.success:
        bg = AppColors.accent.withOpacity(0.2); fg = AppColors.accent;
      case PillType.warning:
        bg = AppColors.border.withOpacity(0.25); fg = AppColors.border;
      case PillType.error:
        bg = AppColors.accentRose.withOpacity(0.25); fg = AppColors.accentRose;
      case PillType.info:
        bg = AppColors.textSecondary.withOpacity(0.2); fg = AppColors.text;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
      child: Text(text, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: fg)),
    );
  }
}

enum PillType { success, warning, error, info }

class ProgressBar extends StatelessWidget {
  final double progress;

  const ProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      decoration: BoxDecoration(
        color: AppColors.border.withOpacity(0.2),
        borderRadius: BorderRadius.circular(2),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress.clamp(0, 1),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
}

class RingProgress extends StatelessWidget {
  final double progress;
  final String text;

  const RingProgress({super.key, required this.progress, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 80, height: 80, child: Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: const Size(80, 80),
          painter: _RingPainter(progress: progress, color: AppColors.accent),
        ),
        Text(text, style: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.text,
        )),
      ],
    ));
  }
}

class _RingPainter extends CustomPainter {
  final double progress; final Color color;
  _RingPainter({required this.progress, required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 6;
    canvas.drawCircle(center, radius, Paint()
      ..color = AppColors.border.withOpacity(0.15)
      ..style = PaintingStyle.stroke..strokeWidth = 5);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
      -1.5708, 6.2832 * progress.clamp(0, 1), false, Paint()
      ..color = color..style = PaintingStyle.stroke..strokeWidth = 5
      ..strokeCap = StrokeCap.round);
  }
  @override bool shouldRepaint(covariant CustomPainter old) => true;
}

class ListItem extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String? subtitle;
  final String? trailing;
  final VoidCallback? onTap;

  const ListItem({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0x26B89066))),
        ),
        child: Row(
          children: [
            if (leading != null) ...[leading!, const SizedBox(width: 12)],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.text)),
                  if (subtitle != null)
                    Text(subtitle!, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                ],
              ),
            ),
            if (trailing != null)
              Text(trailing!, style: const TextStyle(fontSize: 12, color: AppColors.textTertiary)),
          ],
        ),
      ),
    );
  }
}

class AvatarCircle extends StatelessWidget {
  final String letters;
  final double size;
  final Color? bgColor;
  final Color? textColor;

  const AvatarCircle({
    super.key,
    required this.letters,
    this.size = 40,
    this.bgColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final pairs = [
      const [Color(0xFFD4A574), Color(0xFF0F0F0F)],
      const [Color(0x26D4A574), Color(0xFFD4A574)],
      const [Color(0x0FE8B4B8), Color(0xFFB89066)],
      const [Color(0xFFB89066), Color(0xFF0F0F0F)],
      const [Color(0x409A9590), Color(0xFF0F0F0F)],
    ];
    final idx = letters.codeUnits.fold(0, (a, b) => a + b) % pairs.length;
    final c = bgColor ?? pairs[idx][0];
    final t = textColor ?? pairs[idx][1];
    return Container(
      width: size, height: size,
      decoration: BoxDecoration(
        color: c, shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.border.withOpacity(0.12),
            blurRadius: 10, offset: const Offset(0, 2),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(letters.toUpperCase(), style: TextStyle(
        fontSize: size * 0.4, fontWeight: FontWeight.w700, color: t,
      )),
    );
  }
}

class SkeletonLine extends StatefulWidget {
  final double widthFactor;
  const SkeletonLine({super.key, this.widthFactor = 1});
  @override
  State<SkeletonLine> createState() => _SkeletonLineState();
}

class _SkeletonLineState extends State<SkeletonLine> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1, milliseconds: 500))
      ..repeat();
  }
  @override
  void dispose() { _controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => Container(
        height: 14,
        width: widget.widthFactor < 1 ? null : double.infinity,
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: [
              AppColors.surface,
              AppColors.surfaceHover,
              AppColors.surface,
            ],
            transform: GradientRotation(_controller.value * 6.2832),
          ),
        ),
      ),
    );
  }
}

class SkeletonBlock extends StatefulWidget {
  final double height;
  const SkeletonBlock({super.key, this.height = 60});
  @override
  State<SkeletonBlock> createState() => _SkeletonBlockState();
}

class _SkeletonBlockState extends State<SkeletonBlock> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1, milliseconds: 500))
      ..repeat();
  }
  @override
  void dispose() { _controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => Container(
        height: widget.height,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: [
              AppColors.surface,
              AppColors.surfaceHover,
              AppColors.surface,
            ],
            transform: GradientRotation(_controller.value * 6.2832),
          ),
        ),
      ),
    );
  }
}
