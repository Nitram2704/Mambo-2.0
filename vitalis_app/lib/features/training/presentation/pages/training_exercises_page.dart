import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/core/theme/app_theme.dart';
import 'package:vitalis_app/core/widgets/common_widgets.dart';

class TrainingExercises extends StatefulWidget {
  final VoidCallback pop;
  final void Function(String) push;
  const TrainingExercises({super.key, required this.pop, required this.push});
  @override
  State<TrainingExercises> createState() => _TrainingExercisesState();
}

class _TrainingExercisesState extends State<TrainingExercises> {
  final _searchController = TextEditingController();
  final Set<String> _selected = {};
  String _equipFilter = 'Todo Equipamiento';
  String _muscleFilter = 'Todos Músculos';

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
        title: const Text('Agregar Ejercicios'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
              children: [
                _searchField(),
                const SizedBox(height: 12),
                _filterChips(),
                const SizedBox(height: 16),
                _exerciseList(),
              ],
            ),
          ),
          _bottomCta(),
        ],
      ),
    );
  }

  Widget _searchField() {
    return TextField(
      controller: _searchController,
      decoration: const InputDecoration(
        hintText: 'Buscar ejercicio...',
        prefixIcon: Icon(Icons.search, color: AppColors.textSecondary, size: 20),
      ),
    );
  }

  Widget _filterChips() {
    final equip = ['Todo Equipamiento', 'Mancuerna', 'Máquina', 'Cable'];
    final muscle = ['Todos Músculos', 'Pecho', 'Hombros', 'Tríceps', 'Pierna'];
    return SizedBox(
      height: 36,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ...equip.map((c) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Chip(
                  text: c,
                  selected: _equipFilter == c,
                  onTap: () => setState(() {
                    _equipFilter = c;
                  }),
                ),
              )),
          ...muscle.map((c) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Chip(
                  text: c,
                  selected: _muscleFilter == c,
                  onTap: () => setState(() {
                    _muscleFilter = c;
                  }),
                ),
              )),
        ],
      ),
    );
  }

  Widget _exerciseList() {
    final exercises = [
      ('Aperturas', 'Máquina'),
      ('Press de Banca Inclinado', 'Mancuerna'),
      ('Press de Banca en Declive', 'Máquina'),
      ('Press de Hombros', 'Máquina de Discos'),
      ('Elevación Laterales', 'Mancuerna'),
      ('Extensión de Tríceps', 'Cable'),
      ('Tríceps con Polea', ''),
      ('Aducción de Caderas', ''),
    ];
    return Column(children: exercises.map((e) => _exerciseRow(e.$1, e.$2)).toList());
  }

  Widget _exerciseRow(String name, String equipment) {
    final isSelected = _selected.contains(name);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0x26B89066))),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border.withOpacity(0.3)),
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.fitness_center, size: 18, color: AppColors.textSecondary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.text)),
                if (equipment.isNotEmpty)
                  Text(equipment,
                      style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                if (isSelected) {
                  _selected.remove(name);
                } else {
                  _selected.add(name);
                }
              });
            },
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.accent : Colors.transparent,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                    color: isSelected ? AppColors.accent : AppColors.border),
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 16, color: AppColors.bg)
                  : const Icon(Icons.add, size: 16, color: AppColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomCta() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      decoration: const BoxDecoration(
        color: AppColors.bg,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: AppButton(
        text: _selected.isEmpty
            ? 'Selecciona ejercicios'
            : 'Agrega ${_selected.length} ejercicio(s)',
        disabled: _selected.isEmpty,
        onPressed: () => _push('guardar'),
      ),
    );
  }
}
