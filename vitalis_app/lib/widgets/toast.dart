import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ToastOverlay extends StatefulWidget {
  const ToastOverlay({super.key});
  @override
  State<ToastOverlay> createState() => ToastOverlayState();
}

class ToastOverlayState extends State<ToastOverlay> with SingleTickerProviderStateMixin {
  static ToastOverlayState? of(BuildContext context) {
    return context.findAncestorStateOfType<ToastOverlayState>();
  }

  late AnimationController _controller;
  late Animation<double> _opacity;
  String _message = '';
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _opacity = Tween(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void show(String message) {
    setState(() { _message = message; _visible = true; });
    _controller.forward();
    Future.delayed(const Duration(seconds: 2, milliseconds: 400), () {
      if (mounted) {
        _controller.reverse().then((_) {
          if (mounted) setState(() { _visible = false; });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_visible) return const SizedBox.shrink();
    return Positioned(
      bottom: 80,
      left: 0,
      right: 0,
      child: FadeTransition(
        opacity: _opacity,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.elevated,
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(_message, style: const TextStyle(fontSize: 13, color: AppColors.text)),
          ),
        ),
      ),
    );
  }
}
