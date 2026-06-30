import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/core/theme/app_theme.dart';
import 'package:vitalis_app/core/widgets/common_widgets.dart';

class _SerieRow {
  final int number;
  final String kg;
  final String reps;
  const _SerieRow({required this.number, required this.kg, required this.reps});
}

class TrainingEditor extends StatefulWidget {
  final VoidCallback pop;
  final void Function(String) push;
  const TrainingEditor({super.key, required this.pop, required this.push});
  @override
  State<TrainingEditor> createState() => _TrainingEditorState();
}

class _TrainingEditorState extends State<TrainingEditor> {
  final _titleController = TextEditingController(text: 'Push intensivo');
  final _notesController = TextEditingController();
  bool _restTimer = true;
  late List<_SerieRow> _series;

  @override
  void initState() {
    super.initState();
    _series = List.generate(3, (i) => _SerieRow(number: i + 1, kg: '', reps: ''));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  VoidCallback get _pop => widget.pop;
  void Function(String) get _push => widget.push;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: _pop,
          child: const Text('Cancelar',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
        ),
        title: const Text('Editar Rutina'),
        actions: [
          TextButton(
            onPressed: _pop,
            child: const Text('Guardar',
                style: TextStyle(
                    color: AppColors.accent, fontSize: 14, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          _titleField(),
          const SizedBox(height: 20),
          _exerciseCard(),
          const SizedBox(height: 12),
          _addExerciseButton(),
          const SizedBox(height: 12),
          ToggleRow(
            label: 'Descanso automático',
            subLabel: '2:30 entre series',
            value: _restTimer,
            onChanged: (v) => setState(() {
              _restTimer = v;
            }),
          ),
        ],
      ),
    );
  }

  Widget _titleField() {
    return TextField(
      controller: _titleController,
      style: const TextStyle(
          fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.text),
      decoration: const InputDecoration(
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0x4DB89066))),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0x4DB89066))),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.accent, width: 2)),
        filled: false,
        contentPadding: EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }

  void _updateKg(int index, String value) {
    setState(() {
      _series[index] = _SerieRow(number: _series[index].number, kg: value, reps: _series[index].reps);
    });
  }

  void _updateReps(int index, String value) {
    setState(() {
      _series[index] = _SerieRow(number: _series[index].number, kg: _series[index].kg, reps: value);
    });
  }

  Widget _exerciseCard() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(Icons.fitness_center, size: 18, color: AppColors.accent),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text('Aperturas (Máquina)',
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.text)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _notesController,
            style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
            decoration: const InputDecoration(
              hintText: 'Notas del ejercicio...',
              border: InputBorder.none,
              filled: false,
              contentPadding: EdgeInsets.zero,
              isDense: true,
            ),
          ),
          const SizedBox(height: 16),
          _seriesTableHeader(),
          ..._series.asMap().entries.map((e) => _serieRow(e.key, e.value)),
          const SizedBox(height: 8),
          _addSeriesButton(),
        ],
      ),
    );
  }

  Widget _seriesTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0x26B89066))),
      ),
      child: const Row(
        children: [
          SizedBox(
            width: 40,
            child: Text('Serie',
                style: TextStyle(
                    fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
          ),
          Expanded(
            child: Text('KG',
                style: TextStyle(
                    fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
          ),
          Expanded(
            child: Text('REPS',
                style: TextStyle(
                    fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _serieRow(int index, _SerieRow serie) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0x1AB89066))),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text('${serie.number}',
                style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          ),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 13, color: AppColors.text),
              decoration: const InputDecoration(
                filled: false,
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: (v) => _updateKg(index, v),
            ),
          ),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 13, color: AppColors.text),
              decoration: const InputDecoration(
                filled: false,
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: (v) => _updateReps(index, v),
            ),
          ),
        ],
      ),
    );
  }

  Widget _addSeriesButton() {
    return TextButton.icon(
      onPressed: () {
        setState(() {
          _series.add(_SerieRow(number: _series.length + 1, kg: '', reps: ''));
        });
      },
      icon: const Icon(Icons.add, size: 16, color: AppColors.accent),
      label: const Text('Agregar Serie',
          style: TextStyle(color: AppColors.accent, fontSize: 13)),
    );
  }

  Widget _addExerciseButton() {
    return TextButton.icon(
      onPressed: () => _push('ejercicios'),
      icon: const Icon(Icons.add, size: 18, color: AppColors.accent),
      label: const Text('Agregar ejercicio',
          style: TextStyle(color: AppColors.accent, fontSize: 14)),
    );
  }
}
