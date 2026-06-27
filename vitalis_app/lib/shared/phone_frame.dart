import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vitalis_app/core/theme/app_theme.dart';
import 'package:vitalis_app/features/home/presentation/home_screen.dart';
import 'package:vitalis_app/features/training/presentation/training_screen.dart';
import 'package:vitalis_app/features/sleep/presentation/sleep_screen.dart';
import 'package:vitalis_app/features/nutrition/presentation/nutrition_screen.dart';
import 'package:vitalis_app/features/social/presentation/social_screen.dart';
import 'package:vitalis_app/core/widgets/toast.dart';
import 'nav.dart';

class PhoneFrame extends StatefulWidget {
  const PhoneFrame({super.key});

  @override
  State<PhoneFrame> createState() => PhoneFrameState();
}

class PhoneFrameState extends State<PhoneFrame> {
  int currentTab = 0;

  @override
  void initState() {
    super.initState();
    Nav.init(this);
  }

  void switchTab(int index) {
    if (index == currentTab) return;
    setState(() { currentTab = index; });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF0A0A0A),
      child: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 393, maxHeight: 852),
            decoration: BoxDecoration(
              color: AppColors.bg,
              borderRadius: BorderRadius.circular(44),
              boxShadow: [
                BoxShadow(color: AppColors.border.withValues(alpha: 0.3), blurRadius: 1),
                BoxShadow(color: Colors.black.withValues(alpha: 0.7), blurRadius: 80, offset: const Offset(0, 24)),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(44),
              child: Material(
                color: AppColors.bg,
                child: Column(
                  children: [
                    _statusBar(),
                    Expanded(
                      child: IndexedStack(
                        index: currentTab,
                        children: const [
                          HomeScreens(tab: 0),
                          TrainingScreens(tab: 1),
                          SleepScreens(tab: 2),
                          NutritionScreens(tab: 3),
                          SocialScreens(tab: 4),
                        ],
                      ),
                    ),
                    _bottomNav(),
                    const ToastOverlay(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _statusBar() {
    return Container(
      padding: const EdgeInsets.only(top: 14, left: 24, right: 24, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('9:41', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.text)),
          Row(
            children: [
              _signalIcon(),
              const SizedBox(width: 4),
              _wifiIcon(),
              const SizedBox(width: 4),
              _batteryIcon(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _signalIcon() => _sizedSvg(14, 10, (c) => CustomPaint(size: const Size(14, 10), painter: _SignalPainter(color: c)));
  Widget _wifiIcon() => _sizedSvg(14, 10, (c) => CustomPaint(size: const Size(14, 10), painter: _WifiPainter(color: c)));
  Widget _batteryIcon() => _sizedSvg(22, 10, (c) => CustomPaint(size: const Size(22, 10), painter: _BatteryPainter(color: c)));

  Widget _sizedSvg(double w, double h, Widget Function(Color c) builder) {
    return SizedBox(width: w, height: h, child: builder(AppColors.textSecondary));
  }

  Widget _bottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xF50F0F0F),
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(children: List.generate(5, (i) => _navItem(i))),
        ),
      ),
    );
  }

  static final String _cormorantFamily = GoogleFonts.cormorant().fontFamily ?? 'serif';

  Widget _navItem(int index) {
    final active = index == currentTab;
    final color = active ? AppColors.accent : AppColors.textSecondary;
    return Expanded(
      child: InkWell(
        onTap: () => switchTab(index),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _navIcon(index, color),
              const SizedBox(height: 2),
              Text(
                ['Inicio', 'Entreno', 'Sueño', 'Comida', 'Social'][index],
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: color, fontFamily: _cormorantFamily),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navIcon(int index, Color color) {
    return SizedBox(width: 24, height: 24, child: CustomPaint(painter: _NavIconPainter(index: index, color: color)));
  }
}

// Custom Painters
class _SignalPainter extends CustomPainter {
  final Color color;
  _SignalPainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = color..style = PaintingStyle.stroke..strokeWidth = 1.2;
    final path = Path()
      ..moveTo(1, 8)..lineTo(1, 6)
      ..moveTo(3.5, 8)..lineTo(3.5, 4.5)
      ..moveTo(6, 8)..lineTo(6, 3)
      ..moveTo(8.5, 8)..lineTo(8.5, 1.5)
      ..moveTo(11, 8)..lineTo(11, 3)
      ..moveTo(13.5, 8)..lineTo(13.5, 4.5);
    canvas.drawPath(path, p);
  }
  @override bool shouldRepaint(covariant CustomPainter old) => false;
}

class _WifiPainter extends CustomPainter {
  final Color color;
  _WifiPainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = color..style = PaintingStyle.stroke..strokeWidth = 1.2;
    final path = Path()
      ..moveTo(1, 4)..quadraticBezierTo(3.5, 1.5, 7, 2.5)
      ..moveTo(2.5, 6)..quadraticBezierTo(5, 4, 7, 4.5);
    canvas.drawPath(path, p);
    canvas.drawCircle(const Offset(7, 8), 1, Paint()..color = color..style = PaintingStyle.fill);
  }
  @override bool shouldRepaint(covariant CustomPainter old) => false;
}

class _BatteryPainter extends CustomPainter {
  final Color color;
  _BatteryPainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = color..style = PaintingStyle.stroke..strokeWidth = 1.2;
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(0.5, 1, 18, 8), const Radius.circular(2)), p);
    canvas.drawRect(Rect.fromLTWH(19, 3.5, 2.5, 3), Paint()..color = color);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(2.5, 2.5, 7, 5), const Radius.circular(1)),
      Paint()..color = color..style = PaintingStyle.fill);
  }
  @override bool shouldRepaint(covariant CustomPainter old) => false;
}

class _NavIconPainter extends CustomPainter {
  final int index;
  final Color color;
  _NavIconPainter({required this.index, required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = color..style = PaintingStyle.fill;
    final s = Paint()..color = color..style = PaintingStyle.stroke..strokeWidth = 1.5;
    switch (index) {
      case 0:
        canvas.drawPath(Path()
          ..moveTo(4, 10)..lineTo(12, 3)..lineTo(20, 10)
          ..lineTo(20, 20)..lineTo(4, 20)..close(), s);
        canvas.drawRect(Rect.fromLTWH(8, 13, 8, 7), p);
      case 1:
        canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(4, 8, 16, 6), const Radius.circular(1.5)), s);
        canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(2, 5, 3, 12), const Radius.circular(1)), p);
        canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(19, 5, 3, 12), const Radius.circular(1)), p);
      case 2:
        canvas.drawPath(Path()
          ..moveTo(4, 12)..lineTo(4, 5)..lineTo(20, 5)..lineTo(20, 12)..close(), s);
        canvas.drawRect(Rect.fromLTWH(6, 13, 4, 3), p);
        canvas.drawRect(Rect.fromLTWH(14, 13, 4, 3), p);
      case 3:
        final path = Path()
          ..moveTo(12, 2)..cubicTo(8, 6, 5, 10, 5, 16)
          ..cubicTo(5, 19.7, 8.1, 22, 12, 22)
          ..cubicTo(15.9, 22, 19, 19.7, 19, 16)
          ..cubicTo(19, 10, 16, 6, 12, 2);
        canvas.drawPath(path, s);
        canvas.drawLine(const Offset(12, 6), const Offset(12, 4), p);
      case 4:
        canvas.drawCircle(const Offset(8, 8), 3.5, s);
        canvas.drawCircle(const Offset(16, 8), 3.5, s);
        canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(4, 16, 8, 4), const Radius.circular(2)), p);
        canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(12, 16, 8, 4), const Radius.circular(2)), p);
    }
  }
  @override bool shouldRepaint(covariant CustomPainter old) => false;
}
