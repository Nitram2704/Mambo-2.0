import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/shared/nav.dart';
import 'package:vitalis_app/features/sleep/presentation/pages/sleep_main_page.dart';
import 'package:vitalis_app/features/sleep/presentation/pages/sleep_history_page.dart';
import 'package:vitalis_app/features/sleep/presentation/pages/sleep_goal_page.dart';
import 'package:vitalis_app/features/sleep/presentation/pages/sleep_reminder_page.dart';
import 'package:vitalis_app/features/sleep/presentation/pages/sleep_register_page.dart';

class SleepScreens extends StatefulWidget {
  final int tab;
  const SleepScreens({super.key, required this.tab});
  @override
  State<SleepScreens> createState() => SleepScreensState();
}

class SleepScreensState extends State<SleepScreens> {
  final List<String> _stack = ['main'];
  int get tab => widget.tab;

  void push(String view) {
    setState(() {
      _stack.add(view);
    });
  }

  void pop() {
    if (_stack.length > 1) {
      setState(() {
        _stack.removeLast();
      });
    }
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
        return SleepMainPage(push: push);
      case 'historial':
        return SleepHistoryPage(push: push, pop: pop);
      case 'objetivo':
        return SleepGoalPage(pop: pop);
      case 'recordatorio':
        return SleepReminderPage(pop: pop);
      case 'registrar':
        return SleepRegisterPage(pop: pop);
      default:
        return SleepMainPage(push: push);
    }
  }
}
