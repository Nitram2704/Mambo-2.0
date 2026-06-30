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
  
  // Controllers
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _ageController = TextEditingController();
  final _injuriesController = TextEditingController();
  
  final _repo = MockAuthRepository();

  int _currentStep = 1;
  final int _totalSteps = 5;

  // Step 2: Experience & Preferences
  String? _experienceLevel;
  final Set<String> _selectedStyles = {};

  // Step 3: Location & Equipment
  String? _location; // 'gym', 'bodyweight', 'home_outdoor'
  final Set<String> _selectedEquipment = {};

  // Step 4: Nutrition & Sleep
  // Nutrition
  String? _dietType;
  String? _mealsPerDay;
  String? _cookingTime;
  String? _waterVolume;
  String? _budget;
  // Sleep
  String? _sleepHours;
  String? _sleepQuality;
  String? _sleepReason;
  final Set<String> _selectedSleepDisruptors = {};
  String? _daytimeEnergy;

  // Step 5: Planning & Health
  String? _goal;
  final Set<String> _days = {};
  String _duration = '60 min';
  bool _loading = false;

  // Option lists
  final _experienceLevels = [
    'Principiante',
    'Intermedio',
    'Avanzado',
    'Atleta / Experto',
  ];

  final _trainingStyles = [
    'Fuerza / Hipertrofia',
    'Cardio / HIIT',
    'Calistenia',
    'Funcional / Crossfit',
    'Yoga / Movilidad',
  ];

  final _equipments = [
    'Mancuernas',
    'Bandas de resistencia',
    'Barra de dominadas',
    'Kettlebells',
    'Barra y discos',
    'Cuerda de saltar',
  ];

  final _dietTypes = [
    'Omnívoro',
    'Vegetariano',
    'Vegano',
    'Keto / LCHF',
    'Otro / Sin restricciones',
  ];

  final _mealsOptions = ['2 comidas', '3 comidas', '4 comidas', '5+ comidas'];

  final _cookingTimes = [
    'Rápido (<15 min)',
    'Medio (15-40 min)',
    'Dedicado (>40 min)',
  ];

  final _waterVolumes = [
    'Poco (<1.5 L)',
    'Moderado (1.5 - 2.5 L)',
    'Abundante (>2.5 L)',
  ];

  final _budgets = [
    'Económico (básico/accesible)',
    'Moderado (balanceado)',
    'Premium (orgánico/suplementos)',
  ];

  final _sleepHoursOptions = [
    'Menos de 6 horas',
    '6-7 horas',
    '7-8 horas',
    '8+ horas',
  ];

  final _sleepQualities = [
    'Buena (duermo profundo)',
    'Regular (despertares ocasionales)',
    'Mala (me cuesta conciliar o descansar)',
  ];

  final _sleepReasons = [
    'Responsabilidad (trabajo, familia, turnos)',
    'Dificultad personal (insomnio, ansiedad)',
    'Hábitos (pantallas, series hasta tarde)',
  ];

  final _sleepDisruptors = [
    'Estrés / Ansiedad',
    'Pantallas antes de dormir',
    'Cenas pesadas / cafeína',
    'Ruido / Luz en habitación',
    'Ninguno',
  ];

  final _daytimeEnergies = [
    'Energía constante todo el día',
    'Siento bajones por la tarde',
    'Me siento cansado/a constantemente',
  ];

  final _goals = [
    'Perder peso',
    'Ganar músculo',
    'Mantener forma',
    'Mejorar resistencia',
    'Tonificar',
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
    _heightController.dispose();
    _ageController.dispose();
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

  String? _validateHeight(String? value) {
    if (value == null || value.isEmpty) return 'Ingresa tu altura';
    final height = double.tryParse(value);
    if (height == null) return 'Altura inválida';
    if (height < 100 || height > 250) return 'Altura entre 100 y 250 cm';
    return null;
  }

  String? _validateAge(String? value) {
    if (value == null || value.isEmpty) return 'Ingresa tu edad';
    final age = int.tryParse(value);
    if (age == null) return 'Edad inválida';
    if (age < 12 || age > 100) return 'Edad entre 12 y 100 años';
    return null;
  }

  bool _validateCurrentStep() {
    if (_currentStep == 1) {
      return _formKey.currentState?.validate() ?? false;
    }
    if (_currentStep == 2) {
      if (_experienceLevel == null) {
        ToastOverlayState.of(context)?.show('Selecciona tu nivel de experiencia');
        return false;
      }
      if (_selectedStyles.isEmpty) {
        ToastOverlayState.of(context)?.show('Selecciona al menos un estilo');
        return false;
      }
    }
    if (_currentStep == 3) {
      if (_location == null) {
        ToastOverlayState.of(context)?.show('Selecciona dónde entrenas');
        return false;
      }
      if (_location == 'home_outdoor' && _selectedEquipment.isEmpty) {
        ToastOverlayState.of(context)?.show('Selecciona al menos un equipamiento');
        return false;
      }
    }
    if (_currentStep == 4) {
      // Nutrition validation
      if (_dietType == null) {
        ToastOverlayState.of(context)?.show('Selecciona tu tipo de dieta');
        return false;
      }
      if (_mealsPerDay == null) {
        ToastOverlayState.of(context)?.show('Selecciona el número de comidas');
        return false;
      }
      if (_cookingTime == null) {
        ToastOverlayState.of(context)?.show('Selecciona tu tiempo para cocinar');
        return false;
      }
      if (_waterVolume == null) {
        ToastOverlayState.of(context)?.show('Selecciona tu consumo de agua');
        return false;
      }
      if (_budget == null) {
        ToastOverlayState.of(context)?.show('Selecciona tu presupuesto');
        return false;
      }
      // Sleep validation
      if (_sleepHours == null) {
        ToastOverlayState.of(context)?.show('Selecciona tus horas de sueño');
        return false;
      }
      if (_sleepQuality == null) {
        ToastOverlayState.of(context)?.show('Selecciona la calidad de tu descanso');
        return false;
      }
      if (_sleepReason == null) {
        ToastOverlayState.of(context)?.show('Selecciona la causa de tu horario');
        return false;
      }
      if (_selectedSleepDisruptors.isEmpty) {
        ToastOverlayState.of(context)?.show('Selecciona al menos un factor de interrupción');
        return false;
      }
      if (_daytimeEnergy == null) {
        ToastOverlayState.of(context)?.show('Selecciona tu nivel de energía');
        return false;
      }
    }
    return true;
  }

  void _nextStep() {
    if (_validateCurrentStep()) {
      setState(() {
        if (_currentStep < _totalSteps) {
          _currentStep++;
        }
      });
    }
  }

  void _prevStep() {
    setState(() {
      if (_currentStep > 1) {
        _currentStep--;
      } else {
        widget.onBack();
      }
    });
  }

  Future<void> _handleGenerate() async {
    if (_goal == null) {
      ToastOverlayState.of(context)?.show('Selecciona un objetivo');
      return;
    }
    if (_days.isEmpty) {
      ToastOverlayState.of(context)?.show('Selecciona al menos un día');
      return;
    }

    setState(() => _loading = true);

    try {
      await _repo.savePlan({
        'weight': _weightController.text,
        'height': _heightController.text,
        'age': _ageController.text,
        'experienceLevel': _experienceLevel,
        'styles': _selectedStyles.toList(),
        'location': _location,
        'equipment': _location == 'home_outdoor' ? _selectedEquipment.toList() : [],
        // Nutrition
        'dietType': _dietType,
        'mealsPerDay': _mealsPerDay,
        'cookingTime': _cookingTime,
        'waterVolume': _waterVolume,
        'budget': _budget,
        // Sleep
        'sleepHours': _sleepHours,
        'sleepQuality': _sleepQuality,
        'sleepReason': _sleepReason,
        'sleepDisruptors': _selectedSleepDisruptors.toList(),
        'daytimeEnergy': _daytimeEnergy,
        // Schedule
        'goal': _goal,
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
          onPressed: _prevStep,
        ),
        title: Text(
          'Paso $_currentStep de $_totalSteps',
          style: const TextStyle(fontSize: 14, color: AppColors.textSecondary, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Progress indicator
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: LinearProgressIndicator(
                  value: _currentStep / _totalSteps,
                  backgroundColor: AppColors.surface,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accent),
                  minHeight: 4,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  children: [
                    if (_currentStep == 1) _buildStep1(),
                    if (_currentStep == 2) _buildStep2(),
                    if (_currentStep == 3) _buildStep3(),
                    if (_currentStep == 4) _buildStep4(),
                    if (_currentStep == 5) _buildStep5(),
                  ],
                ),
              ),
              // Footer Buttons
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: _currentStep == _totalSteps
                    ? AuthButton(
                        text: 'Generar mi plan',
                        loading: _loading,
                        onPressed: _handleGenerate,
                      )
                    : AuthButton(
                        text: 'Siguiente',
                        onPressed: _nextStep,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- STEP WIDGETS ---

  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Datos Físicos',
          style: GoogleFonts.cormorant(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Por favor, introduce tu información corporal básica.',
          style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 28),
        const SectionTitle(text: 'Edad'),
        const SizedBox(height: 8),
        AuthInputField(
          label: '',
          hint: '25',
          controller: _ageController,
          keyboardType: TextInputType.number,
          validator: _validateAge,
          suffix: const Padding(
            padding: EdgeInsets.only(right: 14),
            child: Text(
              'años',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),
          ),
        ),
        const SizedBox(height: 24),
        const SectionTitle(text: 'Altura'),
        const SizedBox(height: 8),
        AuthInputField(
          label: '',
          hint: '175',
          controller: _heightController,
          keyboardType: TextInputType.number,
          validator: _validateHeight,
          suffix: const Padding(
            padding: EdgeInsets.only(right: 14),
            child: Text(
              'cm',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
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
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Experiencia y Estilo',
          style: GoogleFonts.cormorant(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Cuéntanos sobre tu nivel y qué tipo de entrenamiento prefieres.',
          style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 28),
        const SectionTitle(text: 'Nivel de rendimiento'),
        const SizedBox(height: 8),
        ..._experienceLevels.map((lvl) {
          final isSelected = _experienceLevel == lvl;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: GestureDetector(
              onTap: () => setState(() => _experienceLevel = lvl),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.accent : AppColors.surface,
                  border: Border.all(
                    color: isSelected ? AppColors.accent : AppColors.border,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      lvl,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? AppColors.bg : AppColors.text,
                      ),
                    ),
                    if (isSelected)
                      const Icon(Icons.check_circle, color: AppColors.bg, size: 20),
                  ],
                ),
              ),
            ),
          );
        }),
        const SizedBox(height: 24),
        const SectionTitle(text: 'Estilos preferidos (puedes elegir varios)'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _trainingStyles.map((style) {
            final isSelected = _selectedStyles.contains(style);
            return Chip(
              text: style,
              selected: isSelected,
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedStyles.remove(style);
                  } else {
                    _selectedStyles.add(style);
                  }
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildStep3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lugar y Equipamiento',
          style: GoogleFonts.cormorant(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          '¿Dónde vas a entrenar y qué herramientas tienes a la mano?',
          style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 28),
        const SectionTitle(text: '¿Dónde entrenas?'),
        const SizedBox(height: 8),
        Row(
          children: [
            _locationButton('gym', 'Gym'),
            const SizedBox(width: 8),
            _locationButton('bodyweight', 'Peso corporal'),
            const SizedBox(width: 8),
            _locationButton('home_outdoor', 'En casa / aire libre'),
          ],
        ),
        if (_location == 'home_outdoor') ...[
          const SizedBox(height: 32),
          const SectionTitle(text: 'Equipamiento disponible (múltiple)'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _equipments.map((eq) {
              final isSelected = _selectedEquipment.contains(eq);
              return Chip(
                text: eq,
                selected: isSelected,
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _selectedEquipment.remove(eq);
                    } else {
                      _selectedEquipment.add(eq);
                    }
                  });
                },
              );
            }).toList(),
          ),
        ],
      ],
    );
  }

  Widget _locationButton(String val, String label) {
    final isSelected = _location == val;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() {
          _location = val;
          if (val != 'home_outdoor') {
            _selectedEquipment.clear();
          }
        }),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.accent : AppColors.surface,
            border: Border.all(
              color: isSelected ? AppColors.accent : AppColors.border,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isSelected ? AppColors.bg : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStep4() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nutrición y Sueño',
          style: GoogleFonts.cormorant(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Diagnóstico de tus hábitos diarios de alimentación y descanso.',
          style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
        
        // --- NUTRITION SECTION ---
        const SizedBox(height: 28),
        Text(
          'Alimentación',
          style: GoogleFonts.cormorant(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.accent,
          ),
        ),
        const Divider(color: AppColors.border, height: 16),
        const SizedBox(height: 8),
        
        const SectionTitle(text: 'Tipo de dieta'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _dietTypes.map((diet) {
            final isSelected = _dietType == diet;
            return Chip(
              text: diet,
              selected: isSelected,
              onTap: () => setState(() => _dietType = diet),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        
        const SectionTitle(text: 'Frecuencia de comidas al día'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _mealsOptions.map((opt) {
            final isSelected = _mealsPerDay == opt;
            return Chip(
              text: opt,
              selected: isSelected,
              onTap: () => setState(() => _mealsPerDay = opt),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        
        const SectionTitle(text: 'Tiempo disponible para cocinar'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _cookingTimes.map((opt) {
            final isSelected = _cookingTime == opt;
            return Chip(
              text: opt,
              selected: isSelected,
              onTap: () => setState(() => _cookingTime = opt),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        
        const SectionTitle(text: 'Consumo de agua diario'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _waterVolumes.map((opt) {
            final isSelected = _waterVolume == opt;
            return Chip(
              text: opt,
              selected: isSelected,
              onTap: () => setState(() => _waterVolume = opt),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        
        const SectionTitle(text: 'Presupuesto estimado para alimentación'),
        const SizedBox(height: 8),
        ..._budgets.map((opt) {
          final isSelected = _budget == opt;
          return Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: GestureDetector(
              onTap: () => setState(() => _budget = opt),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.accent : AppColors.surface,
                  border: Border.all(
                    color: isSelected ? AppColors.accent : AppColors.border,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      opt,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? AppColors.bg : AppColors.text,
                      ),
                    ),
                    if (isSelected)
                      const Icon(Icons.check_circle, color: AppColors.bg, size: 18),
                  ],
                ),
              ),
            ),
          );
        }),

        // --- SLEEP SECTION ---
        const SizedBox(height: 36),
        Text(
          'Sueño y Descanso',
          style: GoogleFonts.cormorant(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.accent,
          ),
        ),
        const Divider(color: AppColors.border, height: 16),
        const SizedBox(height: 8),
        
        const SectionTitle(text: 'Horas de sueño promedio al día'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _sleepHoursOptions.map((hours) {
            final isSelected = _sleepHours == hours;
            return Chip(
              text: hours,
              selected: isSelected,
              onTap: () => setState(() => _sleepHours = hours),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        
        const SectionTitle(text: 'Calidad de tu descanso habitual'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _sleepQualities.map((q) {
            final isSelected = _sleepQuality == q;
            return Chip(
              text: q.split(' ')[0], // short label (Buena, Regular, Mala)
              selected: isSelected,
              onTap: () => setState(() => _sleepQuality = q),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),

        const SectionTitle(text: '¿Cuál es el motivo de tu horario de sueño actual?'),
        const SizedBox(height: 8),
        ..._sleepReasons.map((reason) {
          final isSelected = _sleepReason == reason;
          return Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: GestureDetector(
              onTap: () => setState(() => _sleepReason = reason),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.accent : AppColors.surface,
                  border: Border.all(
                    color: isSelected ? AppColors.accent : AppColors.border,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        reason,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? AppColors.bg : AppColors.text,
                        ),
                      ),
                    ),
                    if (isSelected)
                      const Icon(Icons.check_circle, color: AppColors.bg, size: 18),
                  ],
                ),
              ),
            ),
          );
        }),
        const SizedBox(height: 20),

        const SectionTitle(text: 'Factores que suelen interrumpir tu sueño (múltiple)'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _sleepDisruptors.map((factor) {
            final isSelected = _selectedSleepDisruptors.contains(factor);
            return Chip(
              text: factor,
              selected: isSelected,
              onTap: () {
                setState(() {
                  if (factor == 'Ninguno') {
                    _selectedSleepDisruptors.clear();
                    _selectedSleepDisruptors.add('Ninguno');
                  } else {
                    _selectedSleepDisruptors.remove('Ninguno');
                    if (isSelected) {
                      _selectedSleepDisruptors.remove(factor);
                    } else {
                      _selectedSleepDisruptors.add(factor);
                    }
                  }
                });
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 20),

        const SectionTitle(text: 'Nivel de energía durante el día'),
        const SizedBox(height: 8),
        ..._daytimeEnergies.map((energy) {
          final isSelected = _daytimeEnergy == energy;
          return Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: GestureDetector(
              onTap: () => setState(() => _daytimeEnergy = energy),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.accent : AppColors.surface,
                  border: Border.all(
                    color: isSelected ? AppColors.accent : AppColors.border,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        energy,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? AppColors.bg : AppColors.text,
                        ),
                      ),
                    ),
                    if (isSelected)
                      const Icon(Icons.check_circle, color: AppColors.bg, size: 18),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildStep5() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Planificación y Salud',
          style: GoogleFonts.cormorant(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Define los detalles finales para crear tu plan de entrenamiento.',
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
      ],
    );
  }
}
