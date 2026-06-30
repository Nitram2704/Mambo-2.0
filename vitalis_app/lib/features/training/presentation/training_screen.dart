import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/shared/nav.dart';

import 'pages/training_list_page.dart';
import 'pages/training_create_page.dart';
import 'pages/training_exercises_page.dart';
import 'pages/training_saved_page.dart';
import 'pages/training_explore_page.dart';
import 'pages/training_editor_page.dart';
import 'pages/training_start_page.dart';
import 'pages/training_active_page.dart';
import 'pages/training_data_page.dart';
import 'pages/training_options_page.dart';
import 'pages/training_finish_page.dart';

class TrainingScreens extends StatefulWidget {
  final int tab;
  const TrainingScreens({super.key, required this.tab});

  @override
  State<TrainingScreens> createState() => TrainingScreensState();
}

class TrainingScreensState extends State<TrainingScreens> {
  List<String> _stack = ['lista'];
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

  void popToRoot() {
    setState(() {
      _stack = ['lista'];
    });
  }

  @override
  void initState() {
    super.initState();
    Nav.register(tab, push, pop);
  }

  @override
  Widget build(BuildContext context) {
    final view = _stack.last;
    return KeyedSubtree(
      key: ValueKey(view),
      child: _buildScreen(view),
    );
  }

  Widget _buildScreen(String view) {
    switch (view) {
      case 'lista':
        return TrainingList(push: push);
      case 'crear':
        return TrainingCreate(pop: pop, push: push);
      case 'ejercicios':
        return TrainingExercises(pop: pop, push: push);
      case 'guardar':
        return TrainingSaved(popToRoot: popToRoot, push: push);
      case 'explorar':
        return TrainingExplorar(pop: pop, push: push);
      case 'editar':
        return TrainingEditor(pop: pop, push: push);
      case 'iniciar':
        return TrainingStart(pop: pop, push: push);
      case 'ejercicio-activo':
        return TrainingActive(push: push);
      case 'data':
        return TrainingData(pop: pop);
      case 'opciones':
        return TrainingOptions(pop: pop);
      case 'terminar':
        return TrainingFinish(popToRoot: popToRoot);
      default:
        return TrainingList(push: push);
    }
  }
}
