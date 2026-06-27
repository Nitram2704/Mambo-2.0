import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/core/theme/app_theme.dart';
import 'package:vitalis_app/core/widgets/common_widgets.dart';

class TrainingOptions extends StatefulWidget {
  final VoidCallback pop;
  const TrainingOptions({super.key, required this.pop});
  @override
  State<TrainingOptions> createState() => _TrainingOptionsState();
}

class _TrainingOptionsState extends State<TrainingOptions> {
  bool _autoPause = true;
  bool _sound = false;
  bool _focus = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: widget.pop,
        ),
        title: const Text('Opciones'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ToggleRow(
              label: 'Pausa automática',
              value: _autoPause,
              onChanged: (v) => setState(() {
                _autoPause = v;
              }),
            ),
            ToggleRow(
              label: 'Sonido al completar',
              value: _sound,
              onChanged: (v) => setState(() {
                _sound = v;
              }),
            ),
            ToggleRow(
              label: 'Modo concentración',
              value: _focus,
              onChanged: (v) => setState(() {
                _focus = v;
              }),
            ),
          ],
        ),
      ),
    );
  }
}
