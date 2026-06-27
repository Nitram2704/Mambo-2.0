import 'package:flutter/material.dart' hide Chip;
import 'package:google_fonts/google_fonts.dart';
import 'package:vitalis_app/core/theme/app_theme.dart';
import 'package:vitalis_app/core/widgets/common_widgets.dart';
import 'package:vitalis_app/core/widgets/toast.dart';
import '../../data/mock_auth_repository.dart';
import '../widgets/auth_widgets.dart';

class AuthPlanPage extends StatefulWidget {
  final void Function(String) onNavigate;
  final VoidCallback onFinished;
  final VoidCallback onBack;

  const AuthPlanPage({
    super.key,
    required this.onNavigate,
    required this.onFinished,
    required this.onBack,
  });

  @override
  State<AuthPlanPage> createState() => _AuthPlanPageState();
}

class _AuthPlanPageState extends State<AuthPlanPage> {
  final _formKey = GlobalKey<FormState>();
  final _weightController = TextEditingController();
  final _injuriesController = TextEditingController();
  final _repo = MockAuthRepository();

  String? _goal;
  bool? _gym;
  String? _frequency;
  final Set<String> _days = {};
  String _duration = '60 min';
  bool _loading = false;

  final _goals = [
    'Perder peso',
    'Ganar músculo',
    'Mantener forma',
    'Mejorar resistencia',
    'Tonificar',
  ];

  final _frequencies = [
    '1-2 veces / semana',
    '3-4 veces / semana',
    '5+ veces / semana',
  ];

  final _durations = ['30 min', '45 min', '60 min', '90 min'];

  final _daysMap = {
    'L': 'Lunes',
    'M': 'Martes',
    'X': 'Miércoles',
    'J': 'Jueves',
    'V': 'Viernes',
    'S': 'Sábado',
    'D': 'Domingo',
  };

  @override
  void dispose() {
    _weightController.dispose();
    _injuriesController.dispose();
    super.dispose();
  }

  String? _validateWeight(String? value) {
    if (value == null || value.isEmpty) return 'Ingresa tu peso';
    final weight = double.tryParse(value);
    if (weight == null) return 'Peso inválido';
    if (weight < 20 || weight > 300) return 'Peso entre 20 y 300 kg';
    return null;
  }

  Future<void> _handleGenerate() async {
    if (_goal == null) {
      ToastOverlayState.of(context)?.show('Selecciona un objetivo');
      return;
    }
    if (_gym == null) {
      ToastOverlayState.of(context)?.show('Selecciona tu espacio de entrenamiento');
      return;
    }
    if (_frequency == null) {
      ToastOverlayState.of(context)?.show('Selecciona la frecuencia');
      return;
    }
    if (_days.isEmpty) {
      ToastOverlayState.of(context)?.show('Selecciona al menos un día');
      return;
    }

    setState(() => _loading = true);

    try {
      await _repo.savePlan({
        'goal': _goal,
        'weight': _weightController.text,
        'gym': _gym,
        'frequency': _frequency,
        'days': _days.toList(),
        'duration': _duration,
        'injuries': _injuriesController.text,
      });
      if (mounted) widget.onNavigate('welcome');
    } catch (_) {
      if (mounted) ToastOverlayState.of(context)?.show('Error al guardar plan');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: widget.onBack,
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            children: [
              const SizedBox(height: 16),
              Text(
                'Tu plan de entrenamiento',
                style: GoogleFonts.cormorant(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Cuéntanos sobre ti para crear la rutina ideal.',
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 28),
              const SectionTitle(text: 'Objetivo'),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _goal,
                    hint: const Text(
                      'Selecciona tu objetivo',
                      style: TextStyle(color: AppColors.textTertiary),
                    ),
                    dropdownColor: AppColors.surface,
                    style: const TextStyle(color: AppColors.text),
                    items: _goals.map((g) {
                      return DropdownMenuItem(value: g, child: Text(g));
                    }).toList(),
                    onChanged: (v) => setState(() => _goal = v),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const SectionTitle(text: 'Peso actual'),
              const SizedBox(height: 8),
              AuthInputField(
                label: '',
                hint: '70',
                controller: _weightController,
                keyboardType: TextInputType.number,
                validator: _validateWeight,
                suffix: const Padding(
                  padding: EdgeInsets.only(right: 14),
                  child: Text(
                    'kg',
                    style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const SectionTitle(text: '¿Dónde entrenas?'),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _gym = true),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: _gym == true ? AppColors.accent : AppColors.surface,
                          border: Border.all(
                            color: _gym == true ? AppColors.accent : AppColors.border,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Sí, voy al gimnasio',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: _gym == true ? AppColors.bg : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _gym = false),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: _gym == false ? AppColors.accent : AppColors.surface,
                          border: Border.all(
                            color: _gym == false ? AppColors.accent : AppColors.border,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'En casa / al aire libre',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: _gym == false ? AppColors.bg : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const SectionTitle(text: 'Frecuencia'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _frequencies.map((f) {
                  return Chip(
                    text: f,
                    selected: _frequency == f,
                    onTap: () => setState(() => _frequency = f),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  const SectionTitle(text: 'Días de entrenamiento'),
                  const Spacer(),
                  if (_days.isNotEmpty)
                    Text(
                      '${_days.length} seleccionados',
                      style: const TextStyle(fontSize: 12, color: AppColors.accent),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _daysMap.entries.map((e) {
                  return Chip(
                    text: e.key,
                    selected: _days.contains(e.key),
                    onTap: () {
                      setState(() {
                        if (_days.contains(e.key)) {
                          _days.remove(e.key);
                        } else {
                          _days.add(e.key);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              const SectionTitle(text: 'Duración por sesión'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _durations.map((d) {
                  return Chip(
                    text: d,
                    selected: _duration == d,
                    onTap: () => setState(() => _duration = d),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              const SectionTitle(text: 'Lesiones o limitaciones (opcional)'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _injuriesController,
                maxLines: 3,
                style: const TextStyle(color: AppColors.text, fontSize: 15),
                decoration: const InputDecoration(
                  hintText: 'Ej: dolor en la rodilla izquierda...',
                ),
              ),
              const SizedBox(height: 32),
              AuthButton(
                text: 'Generar mi plan',
                loading: _loading,
                onPressed: _handleGenerate,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
