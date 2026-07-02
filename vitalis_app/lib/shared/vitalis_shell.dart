import 'package:flutter/material.dart';
import 'package:vitalis_app/core/theme/app_theme.dart';
import 'package:vitalis_app/features/home/presentation/home_screen.dart';
import 'package:vitalis_app/features/training/presentation/training_screen.dart';
import 'package:vitalis_app/features/sleep/presentation/sleep_screen.dart';
import 'package:vitalis_app/features/nutrition/presentation/nutrition_screen.dart';
import 'package:vitalis_app/features/social/presentation/social_screen.dart';
import 'package:vitalis_app/core/widgets/toast.dart';
import 'package:vitalis_app/features/chat/presentation/widgets/draggable_chat_bubble.dart';
import 'package:vitalis_app/features/chat/presentation/widgets/chat_window_overlay.dart';
import 'nav.dart';

class VitalisShell extends StatefulWidget {
  const VitalisShell({super.key});

  @override
  State<VitalisShell> createState() => VitalisShellState();
}

class VitalisShellState extends State<VitalisShell> {
  int currentTab = 0;
  bool _isChatOpen = false;

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
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.bg,
          body: IndexedStack(
            index: currentTab,
            children: const [
              HomeScreens(tab: 0),
              TrainingScreens(tab: 1),
              SleepScreens(tab: 2),
              NutritionScreens(tab: 3),
              SocialScreens(tab: 4),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF0F0F0F),
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(children: List.generate(5, (i) => _navItem(i))),
              ),
            ),
          ),
          floatingActionButton: const ToastOverlay(),
        ),
        if (_isChatOpen)
          ChatWindowOverlay(
            onClose: () => setState(() {
              _isChatOpen = false;
            }),
          ),
        DraggableChatBubble(
          isOpen: _isChatOpen,
          onTap: () {
            setState(() {
              _isChatOpen = !_isChatOpen;
            });
          },
        ),
      ],
    );
  }

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
              Icon(_navIcons[index], color: color, size: 22),
              const SizedBox(height: 2),
              Text(
                _navLabels[index],
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static const _navIcons = [
    Icons.home,
    Icons.fitness_center,
    Icons.bedtime,
    Icons.restaurant,
    Icons.people,
  ];

  static const _navLabels = [
    'Inicio',
    'Entreno',
    'Sueño',
    'Comida',
    'Social',
  ];
}
