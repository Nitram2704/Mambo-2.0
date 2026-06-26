import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:vitalis_app/theme/app_theme.dart';
import 'package:vitalis_app/widgets/common_widgets.dart';
import 'package:vitalis_app/widgets/toast.dart';
import 'package:vitalis_app/widgets/phone_frame.dart';

class NutritionScreens extends StatefulWidget {
  final int tab;
  final PhoneFrameState phoneFrame;
  const NutritionScreens({super.key, required this.tab, required this.phoneFrame});
  @override
  State<NutritionScreens> createState() => NutritionScreensState();
}

class NutritionScreensState extends State<NutritionScreens> {
  final List<String> _stack = ['main'];
  void push(String view) { setState(() { _stack.add(view); }); }
  void pop() { if (_stack.length > 1) setState(() { _stack.removeLast(); }); }

  @override
  void initState() {
    super.initState();
    Nav.register(tab, push, pop);
  }

  @override
  Widget build(BuildContext context) {
    final view = _stack.last;
    return KeyedSubtree(key: ValueKey(view), child: _buildScreen(view));
  }

  Widget _buildScreen(String view) {
    switch (view) {
      case 'main':
        return _MainScreen(push: push, pop: pop);
      case 'historial':
        return _HistoryScreen(pop: pop);
      case 'registrar':
        return _RegisterScreen(push: push, pop: pop);
      case 'barcode':
        return _BarcodeScreen(pop: pop);
      case 'manual':
        return _ManualScreen(pop: pop);
      case 'buscar':
        return _SearchScreen(push: push, pop: pop);
      case 'seleccionar':
        return _SelectScreen(pop: pop);
      default:
        return _MainScreen(push: push, pop: pop);
    }
  }
}

class _MainScreen extends StatefulWidget {
  final void Function(String) push;
  final VoidCallback pop;
  const _MainScreen({required this.push, required this.pop});
  @override
  State<_MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<_MainScreen> {
  int _selectedDay = 4;
  int _mealPage = 0;
  final _pageController = PageController();

  final _days = <(String, String, bool)>[
    ('L', '22', false),
    ('M', '23', false),
    ('M', '24', false),
    ('J', '25', false),
    ('V', '26', false),
    ('S', '27', true),
    ('D', '28', false),
  ];

  final _meals = ['Desayuno', 'Media Mañana', 'Almuerzo', 'Cena'];
  final _mealIcons = <IconData>[
    Icons.wb_sunny_outlined,
    Icons.free_breakfast_outlined,
    Icons.restaurant_outlined,
    Icons.nights_stay_outlined,
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
            children: [
              _topBar(),
              const SizedBox(height: 16),
              _dayStrip(),
              const SizedBox(height: 16),
              _promoBanner(),
              const SizedBox(height: 16),
              _macroCard(),
              const SizedBox(height: 16),
              _terminarDiaButton(),
              const SizedBox(height: 24),
              _mealSection(),
            ],
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton(
              onPressed: () => widget.push('registrar'),
              backgroundColor: AppColors.accent,
              foregroundColor: AppColors.bg,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.add, size: 28),
            ),
          ),
        ],
      ),
    );
  }

  Widget _topBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.auto_awesome,
                color: AppColors.textSecondary, size: 22),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.water_drop_outlined,
                color: AppColors.textSecondary, size: 22),
            onPressed: () {},
          ),
          const Spacer(),
          const Pill(text: 'Jue 26', type: PillType.info),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.more_horiz,
                color: AppColors.textSecondary, size: 22),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _dayStrip() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _days.asMap().entries.map((e) {
          final i = e.key;
          final d = e.value;
          final selected = i == _selectedDay;
          return GestureDetector(
            onTap: () => setState(() { _selectedDay = i; }),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 44,
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: selected ? AppColors.accent : Colors.transparent,
                border: Border.all(
                  color: selected
                      ? AppColors.accent
                      : AppColors.border.withOpacity(0.3),
                ),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(d.$1,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: selected
                            ? AppColors.bg
                            : AppColors.textSecondary,
                      )),
                  const SizedBox(height: 2),
                  Text(d.$2,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: selected ? AppColors.bg : AppColors.text,
                      )),
                  if (d.$3)
                    Container(
                      width: 4,
                      height: 4,
                      margin: const EdgeInsets.only(top: 2),
                      decoration: const BoxDecoration(
                        color: AppColors.accent,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _promoBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accent.withOpacity(0.15),
            AppColors.accent.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: AppColors.accent.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.auto_awesome,
              color: AppColors.accent, size: 32),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Ahorra 75% en Premium!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.accent,
                    )),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.timer_outlined,
                        color: AppColors.textSecondary, size: 14),
                    const SizedBox(width: 4),
                    const Text('24:15:30',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        )),
                  ],
                ),
              ],
            ),
          ),
          AppButton(
            text: 'Obtener',
            type: AppButtonType.primary,
            width: 100,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _macroCard() {
    return AppCard(
      child: Column(
        children: [
          Row(
            children: [
              const Text('0 / 2,539 kcal',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.text,
                  )),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: const Icon(Icons.edit,
                    color: AppColors.accent, size: 18),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: _CurvedGauge(
              progress: 0,
              value: '0',
              label: 'kcal',
            ),
          ),
          const SizedBox(height: 16),
          _macroRow('Proteínas', 0, 146),
          const SizedBox(height: 10),
          _macroRow('Carbohidratos', 0, 298),
          const SizedBox(height: 10),
          _macroRow('Grasas', 0, 85),
        ],
      ),
    );
  }

  Widget _macroRow(String label, int current, int total) {
    final p = total > 0 ? current / total : 0.0;
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(label,
              style: const TextStyle(
                  fontSize: 12, color: AppColors.textSecondary)),
        ),
        const SizedBox(width: 8),
        Expanded(child: ProgressBar(progress: p)),
        const SizedBox(width: 8),
        Text('$current/${total}g',
            style: const TextStyle(
                fontSize: 11, color: AppColors.textSecondary)),
      ],
    );
  }

  Widget _terminarDiaButton() {
    return AppButton(
      text: 'Terminar Día',
      type: AppButtonType.secondary,
      onPressed: () {},
    );
  }

  Widget _mealSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(text: 'Comidas'),
        SizedBox(
          height: 200,
          child: PageView(
            controller: _pageController,
            onPageChanged: (i) => setState(() { _mealPage = i; }),
            children: _meals.asMap().entries.map((e) {
              return _MealCard(
                name: e.value,
                icon: _mealIcons[e.key],
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_meals.length, (i) {
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: i == _mealPage
                    ? AppColors.accent
                    : AppColors.border.withOpacity(0.3),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _CurvedGauge extends StatelessWidget {
  final double progress;
  final String value;
  final String label;
  const _CurvedGauge({
    required this.progress,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _GaugePainter(progress: progress.clamp(0, 1)),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(value,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                )),
            Text(label,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                )),
          ],
        ),
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double progress;
  _GaugePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(2, 0, size.width - 4, size.height * 2);

    final bgPaint = Paint()
      ..color = AppColors.border.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    final fgPaint = Paint()
      ..color = AppColors.accent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, math.pi, -math.pi, false, bgPaint);
    canvas.drawArc(rect, math.pi, -math.pi * progress, false, fgPaint);
  }

  @override
  bool shouldRepaint(covariant _GaugePainter old) => old.progress != progress;
}

class _MealCard extends StatelessWidget {
  final String name;
  final IconData icon;
  const _MealCard({required this.name, required this.icon});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.accent, size: 20),
              const SizedBox(width: 8),
              Text(name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  )),
              const Spacer(),
              const Text('0 kcal',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  )),
            ],
          ),
          const Divider(height: 24),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.restaurant_outlined,
                      color: AppColors.textTertiary.withOpacity(0.3),
                      size: 32),
                  const SizedBox(height: 8),
                  const Text('No hay alimentos registrados',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textTertiary,
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HistoryScreen extends StatelessWidget {
  final VoidCallback pop;
  const _HistoryScreen({required this.pop});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: pop,
        ),
        title: const Text('Historial'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _historyCard('Hoy', 1842, PillType.success, [
            ('Proteínas', 92),
            ('Carbohidratos', 210),
            ('Grasas', 65),
          ]),
          const SizedBox(height: 12),
          _historyCard('Ayer', 2560, PillType.warning, [
            ('Proteínas', 78),
            ('Carbohidratos', 320),
            ('Grasas', 95),
          ]),
          const SizedBox(height: 12),
          _historyCard('Lun', 2180, PillType.success, [
            ('Proteínas', 105),
            ('Carbohidratos', 240),
            ('Grasas', 72),
          ]),
        ],
      ),
    );
  }

  Widget _historyCard(
      String label, int kcal, PillType type, List<(String, int)> macros) {
    return AppCard(
      child: Column(
        children: [
          Row(
            children: [
              Text(label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  )),
              const Spacer(),
              Text('$kcal kcal',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.text,
                  )),
              const SizedBox(width: 8),
              Pill(
                text: kcal <= 2000 ? 'Meta cumplida' : 'Excedido',
                type: type,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: macros
                .map((m) => Expanded(child: _macroStat(m.$1, m.$2)))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _macroStat(String label, int grams) {
    return Column(
      children: [
        Text('$grams',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.accent,
            )),
        const SizedBox(height: 2),
        const Text('g',
            style: TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
            )),
        const SizedBox(height: 2),
        Text(label,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
            )),
      ],
    );
  }
}

class _RegisterScreen extends StatelessWidget {
  final void Function(String) push;
  final VoidCallback pop;
  const _RegisterScreen({required this.push, required this.pop});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: pop,
        ),
        title: const Text('Registrar alimento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _optionCard(
              icon: Icons.camera_alt_outlined,
              title: 'Foto',
              desc: 'Toma una foto a tu comida',
              onTap: () {},
            ),
            const SizedBox(height: 12),
            _optionCard(
              icon: Icons.qr_code_scanner_outlined,
              title: 'Código de barras',
              desc: 'Escanea el código de barras del producto',
              onTap: () => push('barcode'),
            ),
            const SizedBox(height: 12),
            _optionCard(
              icon: Icons.edit_note_outlined,
              title: 'Manual',
              desc: 'Ingresa los datos manualmente',
              onTap: () => push('manual'),
            ),
            const SizedBox(height: 12),
            _optionCard(
              icon: Icons.storage_outlined,
              title: 'Base de datos',
              desc: 'Busca en nuestra base de datos',
              onTap: () => push('buscar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _optionCard({
    required IconData icon,
    required String title,
    required String desc,
    required VoidCallback onTap,
  }) {
    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.accent, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.text,
                    )),
                const SizedBox(height: 2),
                Text(desc,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    )),
              ],
            ),
          ),
          const Icon(Icons.chevron_right,
              color: AppColors.textTertiary, size: 20),
        ],
      ),
    );
  }
}

class _BarcodeScreen extends StatefulWidget {
  final VoidCallback pop;
  const _BarcodeScreen({required this.pop});
  @override
  State<_BarcodeScreen> createState() => _BarcodeScreenState();
}

class _BarcodeScreenState extends State<_BarcodeScreen> {
  int _selectedChip = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: widget.pop,
        ),
        title: const Text('Código de barras'),
      ),
      body: Column(
        children: [
          const Spacer(),
          Center(
            child: Container(
              width: 250,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.accent.withOpacity(0.5),
                  width: 2,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    CustomPaint(
                      size: const Size(250, 180),
                      painter: _ScannerGridPainter(),
                    ),
                    _PulsingLine(),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Chip(
                  text: 'Auto-detectar',
                  selected: _selectedChip == 0,
                  onTap: () => setState(() { _selectedChip = 0; }),
                ),
                const SizedBox(width: 12),
                Chip(
                  text: 'Ingresar manual',
                  selected: _selectedChip == 1,
                  onTap: () => setState(() { _selectedChip = 1; }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PulsingLine extends StatefulWidget {
  @override
  State<_PulsingLine> createState() => _PulsingLineState();
}

class _PulsingLineState extends State<_PulsingLine>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Positioned(
          top: _controller.value * (180 - 4),
          left: 0,
          right: 0,
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.8),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withOpacity(0.4),
                  blurRadius: 8,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ScannerGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.accent.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (double x = 0; x < size.width; x += 20) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 20) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    final cornerPaint = Paint()
      ..color = AppColors.accent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    const cornerLen = 20.0;
    canvas.drawLine(
        Offset(0, cornerLen), Offset(0, 0), cornerPaint);
    canvas.drawLine(
        Offset(0, 0), Offset(cornerLen, 0), cornerPaint);
    canvas.drawLine(
        Offset(size.width - cornerLen, 0), Offset(size.width, 0), cornerPaint);
    canvas.drawLine(
        Offset(size.width, 0), Offset(size.width, cornerLen), cornerPaint);
    canvas.drawLine(Offset(size.width, size.height - cornerLen),
        Offset(size.width, size.height), cornerPaint);
    canvas.drawLine(Offset(size.width, size.height),
        Offset(size.width - cornerLen, size.height), cornerPaint);
    canvas.drawLine(
        Offset(cornerLen, size.height), Offset(0, size.height), cornerPaint);
    canvas.drawLine(
        Offset(0, size.height), Offset(0, size.height - cornerLen), cornerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

class _ManualScreen extends StatefulWidget {
  final VoidCallback pop;
  const _ManualScreen({required this.pop});
  @override
  State<_ManualScreen> createState() => _ManualScreenState();
}

class _ManualScreenState extends State<_ManualScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _portionController = TextEditingController(text: '100');
  final _proteinController = TextEditingController();
  final _carbsController = TextEditingController();
  final _fatController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _caloriesController.dispose();
    _portionController.dispose();
    _proteinController.dispose();
    _carbsController.dispose();
    _fatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: widget.pop,
        ),
        title: const Text('Manual'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildField(
              'Nombre',
              _nameController,
              hint: 'Ej: Pollo a la plancha',
            ),
            const SizedBox(height: 16),
            _buildField(
              'Calorías',
              _caloriesController,
              hint: 'Ej: 165',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            _buildField(
              'Porción (g)',
              _portionController,
              hint: '100',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            _buildField(
              'Proteínas (g)',
              _proteinController,
              hint: 'Ej: 31',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            _buildField(
              'Carbohidratos (g)',
              _carbsController,
              hint: 'Ej: 0',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            _buildField(
              'Grasas (g)',
              _fatController,
              hint: 'Ej: 3.6',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            AppButton(
              text: 'Registrar',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ToastOverlayState.of(context)?.show('Alimento registrado');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller, {
    String? hint,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
      ),
      style: const TextStyle(color: AppColors.text, fontSize: 15),
    );
  }
}

class _SearchScreen extends StatefulWidget {
  final void Function(String) push;
  final VoidCallback pop;
  const _SearchScreen({required this.push, required this.pop});
  @override
  State<_SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<_SearchScreen> {
  final _searchController = TextEditingController();

  final _foods = <(String, int)>[
    ('Pollo pechuga', 165),
    ('Arroz blanco', 130),
    ('Huevo', 155),
    ('Aguacate', 160),
    ('Batido proteína', 120),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: widget.pop,
        ),
        title: const Text('Buscar'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Buscar alimentos...',
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.textSecondary,
                  size: 20,
                ),
              ),
              style: const TextStyle(color: AppColors.text, fontSize: 15),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _foods.length,
              separatorBuilder: (_, __) => const SizedBox(height: 4),
              itemBuilder: (_, i) {
                final food = _foods[i];
                return ListItem(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.accent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.restaurant_outlined,
                        color: AppColors.accent, size: 20),
                  ),
                  title: food.$1,
                  trailing: '${food.$2} kcal',
                  onTap: () => widget.push('seleccionar'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectScreen extends StatefulWidget {
  final VoidCallback pop;
  const _SelectScreen({required this.pop});
  @override
  State<_SelectScreen> createState() => _SelectScreenState();
}

class _SelectScreenState extends State<_SelectScreen> {
  final _portionController = TextEditingController(text: '100');
  double _portionGrams = 100;

  final _food = (
    name: 'Pollo pechuga',
    kcal: 165,
    protein: 31.0,
    carbs: 0.0,
    fat: 3.6,
  );

  @override
  void dispose() {
    _portionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final factor = _portionGrams / 100;

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: widget.pop,
        ),
        title: const Text('Seleccionar'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppCard(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.accent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.restaurant_outlined,
                          color: AppColors.accent, size: 24),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_food.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.text,
                              )),
                          const SizedBox(height: 2),
                          Text('${_food.kcal} kcal',
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _macroChip('Proteínas', '${_food.protein}g'),
                    const SizedBox(width: 8),
                    _macroChip('Carbohidratos', '${_food.carbs}g'),
                    const SizedBox(width: 8),
                    _macroChip('Grasas', '${_food.fat}g'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const SectionTitle(text: 'Porción'),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _portionController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Cantidad',
                  ),
                  style: const TextStyle(
                      color: AppColors.text, fontSize: 15),
                  onChanged: (v) {
                    setState(() {
                      _portionGrams = double.tryParse(v) ?? 0;
                    });
                  },
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('g',
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.textSecondary,
                    )),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: StatCard(
                  value: '${(_food.kcal * factor).round()}',
                  label: 'kcal',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: StatCard(
                  value:
                      '${(_food.protein * factor).toStringAsFixed(1)}',
                  label: 'Proteínas (g)',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: StatCard(
                  value:
                      '${(_food.carbs * factor).toStringAsFixed(1)}',
                  label: 'Carbohidratos (g)',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: StatCard(
                  value: '${(_food.fat * factor).toStringAsFixed(1)}',
                  label: 'Grasas (g)',
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          AppButton(
            text: 'Añadir a comida',
            onPressed: () {
              ToastOverlayState.of(context)
                  ?.show('Añadido a la comida');
            },
          ),
        ],
      ),
    );
  }

  Widget _macroChip(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          children: [
            Text(value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.accent,
                )),
            Text(label,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.textSecondary,
                )),
          ],
        ),
      ),
    );
  }
}
