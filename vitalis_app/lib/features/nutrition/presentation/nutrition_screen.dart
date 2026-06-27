import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/shared/nav.dart';
import '../data/mock_nutrition_repository.dart';
import 'pages/nutrition_main_page.dart';
import 'pages/nutrition_history_page.dart';
import 'pages/nutrition_register_page.dart';
import 'pages/nutrition_barcode_page.dart';
import 'pages/nutrition_manual_page.dart';
import 'pages/nutrition_search_page.dart';
import 'pages/nutrition_select_page.dart';

class NutritionScreens extends StatefulWidget {
  final int tab;
  const NutritionScreens({super.key, required this.tab});
  @override
  State<NutritionScreens> createState() => NutritionScreensState();
}

class NutritionScreensState extends State<NutritionScreens> {
  final List<String> _stack = ['main'];
  final _repo = MockNutritionRepository();

  int get tab => widget.tab;

  void push(String view) {
    setState(() { _stack.add(view); });
  }

  void pop() {
    if (_stack.length > 1) setState(() { _stack.removeLast(); });
  }

  @override
  void initState() {
    super.initState();
    Nav.register(tab, push, pop);
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
      case 'main':
        return NutritionMainPage(
          key: ValueKey(key),
          onNavigate: push,
        );
      case 'historial':
        return NutritionHistoryPage(
          key: ValueKey(key),
          history: _repo.getHistory(),
          onGoBack: pop,
        );
      case 'registrar':
        return NutritionRegisterPage(
          key: ValueKey(key),
          onNavigate: push,
          onGoBack: pop,
        );
      case 'barcode':
        return NutritionBarcodePage(
          key: ValueKey(key),
          onGoBack: pop,
        );
      case 'manual':
        return NutritionManualPage(
          key: ValueKey(key),
          onGoBack: pop,
        );
      case 'buscar':
        return NutritionSearchPage(
          key: ValueKey(key),
          foods: _repo.getFoods(),
          onNavigate: push,
          onGoBack: pop,
        );
      case 'seleccionar':
        return NutritionSelectPage(
          key: ValueKey(key),
          onGoBack: pop,
        );
      default:
        return NutritionMainPage(
          key: ValueKey(key),
          onNavigate: push,
        );
    }
  }
}
