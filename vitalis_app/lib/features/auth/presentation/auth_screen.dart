import 'package:flutter/material.dart' hide Chip;

import 'pages/auth_inicio_page.dart';
import 'pages/auth_login_page.dart';
import 'pages/auth_register_page.dart';
import 'pages/auth_plan_page.dart';
import 'pages/auth_welcome_page.dart';

class AuthScreens extends StatefulWidget {
  final VoidCallback onFinished;

  const AuthScreens({super.key, required this.onFinished});

  @override
  State<AuthScreens> createState() => AuthScreensState();
}

class AuthScreensState extends State<AuthScreens> {
  final List<String> _stack = ['inicio'];

  void push(String view) {
    setState(() => _stack.add(view));
  }

  void pop() {
    if (_stack.length > 1) setState(() => _stack.removeLast());
  }

  @override
  Widget build(BuildContext context) {
    final view = _stack.last;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.1, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
          child: child,
        );
      },
      child: _buildScreen(view, view),
    );
  }

  Widget _buildScreen(String view, String key) {
    switch (view) {
      case 'inicio':
        return AuthInicioPage(
          key: ValueKey(key),
          onNavigate: push,
          onFinished: widget.onFinished,
        );
      case 'login':
        return AuthLoginPage(
          key: ValueKey(key),
          onNavigate: push,
          onBack: pop,
        );
      case 'register':
        return AuthRegisterPage(
          key: ValueKey(key),
          onNavigate: push,
          onBack: pop,
        );
      case 'plan':
        return AuthPlanPage(
          key: ValueKey(key),
          onNavigate: push,
          onFinished: widget.onFinished,
          onBack: pop,
        );
      case 'welcome':
        return AuthWelcomePage(
          key: ValueKey(key),
          onFinished: widget.onFinished,
        );
      default:
        return AuthInicioPage(
          key: const ValueKey('inicio'),
          onNavigate: push,
          onFinished: widget.onFinished,
        );
    }
  }
}
