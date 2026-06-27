import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/shared/nav.dart';
import '../data/mock_home_repository.dart';
import 'pages/home_main_page.dart';
import 'pages/home_profile_page.dart';
import 'pages/home_edit_profile_page.dart';

class HomeScreens extends StatefulWidget {
  final int tab;
  const HomeScreens({super.key, required this.tab});

  @override
  State<HomeScreens> createState() => HomeScreensState();
}

class HomeScreensState extends State<HomeScreens> {
  final List<String> _stack = ['main'];
  final _repo = MockHomeRepository();

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
        return HomeMainPage(
          key: ValueKey(key),
          user: _repo.getUser(),
          activities: _repo.getRecentActivities(),
          onNavigate: push,
        );
      case 'profile':
        return HomeProfilePage(
          key: ValueKey(key),
          user: _repo.getUser(),
          onNavigate: push,
        );
      case 'editar-perfil':
        return HomeEditProfilePage(
          key: ValueKey(key),
          user: _repo.getUser(),
          onGoBack: pop,
          onSaved: (name, email, peso, altura, username) {
            if (mounted) pop();
          },
        );
      default:
        return HomeMainPage(
          key: ValueKey(key),
          user: _repo.getUser(),
          activities: _repo.getRecentActivities(),
          onNavigate: push,
        );
    }
  }
}
