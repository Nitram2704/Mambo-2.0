import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/core/theme/app_theme.dart';
import 'package:vitalis_app/core/widgets/common_widgets.dart';

class TrainingExplorar extends StatefulWidget {
  final VoidCallback pop;
  final void Function(String) push;
  const TrainingExplorar({super.key, required this.pop, required this.push});
  @override
  State<TrainingExplorar> createState() => _TrainingExplorarState();
}

class _TrainingExplorarState extends State<TrainingExplorar> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  VoidCallback get _pop => widget.pop;
  void Function(String) get _push => widget.push;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: _pop,
        ),
        title: const Text('Explorar'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Buscar rutinas...',
              prefixIcon: Icon(Icons.search, color: AppColors.textSecondary, size: 20),
            ),
          ),
          const SizedBox(height: 24),
          const SectionTitle(text: 'POPULARES'),
          const SizedBox(height: 8),
          _popularCard('Full Body Principiante', '3 ejercicios · ~30 min'),
          const SizedBox(height: 8),
          _popularCard('Push Pull Legs', '9 ejercicios · ~60 min'),
          const SizedBox(height: 8),
          _popularCard('Core 10 minutos', '5 ejercicios · ~10 min'),
        ],
      ),
    );
  }

  Widget _popularCard(String title, String subtitle) {
    return AppCard(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.text)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          AppButton(
            text: 'Ver y editar',
            type: AppButtonType.secondary,
            width: 120,
            onPressed: () => _push('editar'),
          ),
        ],
      ),
    );
  }
}
