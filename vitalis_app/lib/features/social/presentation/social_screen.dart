import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/shared/nav.dart';
import 'pages/social_main_page.dart';
import 'pages/social_profile_page.dart';
import 'pages/social_create_group_page.dart';
import 'pages/social_create_event_page.dart';
import 'pages/social_event_page.dart';
import 'pages/social_evidence_page.dart';

class SocialScreens extends StatefulWidget {
  final int tab;
  const SocialScreens({super.key, required this.tab});

  @override
  State<SocialScreens> createState() => SocialScreensState();
}

class SocialScreensState extends State<SocialScreens> {
  final List<String> _stack = ['main'];

  String _profileName = '';
  String _profileInitials = '';
  String _profileUsername = '';
  int _profileLevel = 0;
  int _profileStreak = 0;
  int _profileLogros = 0;
  int _profileGrupos = 0;

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

  void showProfile(String name, String initials, String username,
      int level, int streak, int logros, int grupos) {
    setState(() {
      _profileName = name;
      _profileInitials = initials;
      _profileUsername = username;
      _profileLevel = level;
      _profileStreak = streak;
      _profileLogros = logros;
      _profileGrupos = grupos;
      _stack.add('perfil');
    });
  }

  @override
  void initState() {
    super.initState();
    Nav.register(tab, push, pop);
    Nav.registerSocialProfile(showProfile);
  }

  @override
  Widget build(BuildContext context) {
    final view = _stack.last;
    return KeyedSubtree(key: ValueKey(view), child: _buildScreen(view));
  }

  Widget _buildScreen(String view) {
    switch (view) {
      case 'main':
        return SocialMainPage(
          onNavigate: push,
          onShowProfile: showProfile,
        );
      case 'perfil':
        return SocialProfilePage(
          name: _profileName,
          initials: _profileInitials,
          username: _profileUsername,
          level: _profileLevel,
          streak: _profileStreak,
          logros: _profileLogros,
          grupos: _profileGrupos,
          onPop: pop,
        );
      case 'crear-grupo':
        return SocialCreateGroupPage(onPop: pop);
      case 'crear-evento':
        return SocialCreateEventPage(onPop: pop);
      case 'evento':
        return SocialEventPage(onPop: pop, onNavigate: push);
      case 'evidencia':
        return SocialEvidencePage(onPop: pop);
      default:
        return SocialMainPage(
          onNavigate: push,
          onShowProfile: showProfile,
        );
    }
  }
}
