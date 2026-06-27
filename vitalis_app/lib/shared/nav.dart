import 'package:flutter/material.dart';

typedef ShowProfileFn = void Function(
    String name, String initials, String username,
    int level, int streak, int logros, int grupos);

class Nav {
  static dynamic _shell;
  static final Map<int, dynamic Function(String)> _pushers = {};
  static final Map<int, VoidCallback> _pops = {};
  static ShowProfileFn? _showProfile;

  static void init(dynamic state) => _shell = state;

  static void register(int tab, dynamic Function(String) pusher, VoidCallback popper) {
    _pushers[tab] = pusher;
    _pops[tab] = popper;
  }

  static void registerSocialProfile(ShowProfileFn fn) => _showProfile = fn;

  static void push(int tab, String screen) {
    _pushers[tab]?.call(screen);
  }

  static void pop(int tab) {
    _pops[tab]?.call();
  }

  static void switchTab(int tab) {
    _shell?.switchTab(tab);
  }

  static void switchTabAndPush(int tab, String screen) {
    _shell?.switchTab(tab);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pushers[tab]?.call(screen);
    });
  }

  static void showSocialProfile(
    String name, String initials, String username,
    int level, int streak, int logros, int grupos,
  ) {
    if (_showProfile == null) return;
    _shell?.switchTab(4);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showProfile?.call(name, initials, username, level, streak, logros, grupos);
    });
  }
}
