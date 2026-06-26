import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/theme/app_theme.dart';
import 'package:vitalis_app/widgets/common_widgets.dart';
import 'package:vitalis_app/widgets/toast.dart';
import 'package:vitalis_app/widgets/phone_frame.dart';

// ============================================================
// HomeScreens - Tab navigation stack (tab = 0)
// ============================================================

class HomeScreens extends StatefulWidget {
  final int tab;
  final PhoneFrameState phoneFrame;
  const HomeScreens({super.key, required this.tab, required this.phoneFrame});

  @override
  State<HomeScreens> createState() => HomeScreensState();
}

class HomeScreensState extends State<HomeScreens> {
  final List<String> _stack = ['main'];

  int get tab => widget.tab;

  void push(String view) {
    setState(() { _stack.add(view); });
  }

  void pop() {
    if (_stack.length > 1) setState(() { _stack.removeLast(); });
  }

  bool get canPop => _stack.length > 1;

  @override
  void initState() {
    super.initState();
    Nav.register(tab, push, pop);
  }

  @override
  Widget build(BuildContext context) {
    final view = _stack.last;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.1, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
          child: child,
        );
      },
      child: _buildScreen(view, view),
    );
  }

  Widget _buildScreen(String view, String key) {
    switch (view) {
      case 'main':
        return HomeMain(key: ValueKey(key), onNavigate: push);
      case 'profile':
        return HomeProfile(key: ValueKey(key), onNavigate: push);
      case 'editar-perfil':
        return EditProfile(
          key: ValueKey(key),
          onGoBack: pop,
          onSaved: (String name, String email, double peso, double altura, String username) {
            if (mounted) pop();
          },
        );
      default:
        return HomeMain(key: ValueKey(key), onNavigate: push);
    }
  }
}

// ============================================================
// HomeMain - Dashboard
// ============================================================

class HomeMain extends StatelessWidget {
  final void Function(String) onNavigate;
  const HomeMain({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            _Greeting(onProfileTap: () => onNavigate('profile')),
            const SizedBox(height: 24),
            _buildStatsRow(
              StatCard(value: '3', label: 'Entrenos hoy'),
              StatCard(value: '7.2', label: 'Horas sue\u00f1o'),
            ),
            const SizedBox(height: 8),
            _buildStatsRow(
              StatCard(value: '1,842', label: 'kcal'),
              StatCard(value: '2', label: 'Eventos'),
            ),
            const SizedBox(height: 16),
            _buildStreakCard(context),
            const SizedBox(height: 24),
            const SectionTitle(text: 'Acceso r\u00e1pido'),
            const SizedBox(height: 4),
            _buildQuickAccessGrid(context),
            const SizedBox(height: 24),
            const SectionTitle(text: 'Actividad reciente'),
            const SizedBox(height: 4),
            _buildRecentActivity(context),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow(Widget left, Widget right) {
    return Row(
      children: [
        left,
        const SizedBox(width: 8),
        right,
      ],
    );
  }

  Widget _buildStreakCard(BuildContext context) {
    const days = ['Lun', 'Mar', 'Mi\u00e9', 'Jue', 'Vie', 'S\u00e1b', 'Dom'];
    return AppCard(
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.star, color: AppColors.accent, size: 20),
              const SizedBox(width: 8),
              Text(
                '7 d\u00edas de racha',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.text,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (i) {
              return Column(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check, color: Color(0xFF0F0F0F), size: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    days[i],
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              );
            }),
          ),
          const SizedBox(height: 16),
          Container(height: 1, color: AppColors.border.withValues(alpha: 0.15)),
          const SizedBox(height: 12),
          Row(
            children: [
              _streakStat('24', 'd\u00edas activos\neste mes'),
              const SizedBox(width: 24),
              _streakStat('85%', 'constancia\nsemanal'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _streakStat(String value, String label) {
    return Expanded(
      child: Row(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: AppColors.accent,
              height: 1.1,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccessGrid(BuildContext context) {
    final cards = [
      _QuickCardData('Entrenamiento', '3 rutinas activas', Icons.fitness_center),
      _QuickCardData('Sue\u00f1o', 'Objetivo: 8h', Icons.bedtime),
      _QuickCardData('Alimentaci\u00f3n', '1,842/2,200 kcal', Icons.restaurant),
      _QuickCardData('Social', '2 grupos, 1 evento', Icons.people),
    ];
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _QuickAccessCard(data: cards[0], context: context)),
            const SizedBox(width: 8),
            Expanded(child: _QuickAccessCard(data: cards[1], context: context)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _QuickAccessCard(data: cards[2], context: context)),
            const SizedBox(width: 8),
            Expanded(child: _QuickAccessCard(data: cards[3], context: context)),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentActivity(BuildContext context) {
    final activities = [
      _ActivityData('Cardio matinal', '45 min', 'Hace 2h', Icons.favorite_border),
      _ActivityData('Estiramientos', '20 min', 'Hace 5h', Icons.accessibility_new),
      _ActivityData('Registro de comidas', 'Completo', 'Hace 1h', Icons.restaurant),
    ];
    return Column(
      children: activities.map((a) => _ActivityCard(data: a)).toList(),
    );
  }
}

class _Greeting extends StatelessWidget {
  final VoidCallback onProfileTap;
  const _Greeting({required this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onProfileTap,
          child: const AvatarCircle(letters: 'V', size: 48),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '\u00a1Hola de nuevo!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.text,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              'Tu progreso hoy',
              style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
            ),
          ],
        ),
      ],
    );
  }
}

class _QuickCardData {
  final String title;
  final String subtitle;
  final IconData icon;
  const _QuickCardData(this.title, this.subtitle, this.icon);
}

class _QuickAccessCard extends StatelessWidget {
  final _QuickCardData data;
  final BuildContext context;
  const _QuickAccessCard({required this.data, required this.context});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(14),
      onTap: () {
        ToastOverlayState.of(context)?.show('Pr\u00f3ximamente');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(data.icon, color: AppColors.accent, size: 20),
          ),
          const SizedBox(height: 10),
          Text(
            data.title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            data.subtitle,
            style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _ActivityData {
  final String title;
  final String value;
  final String time;
  final IconData icon;
  const _ActivityData(this.title, this.value, this.time, this.icon);
}

class _ActivityCard extends StatelessWidget {
  final _ActivityData data;
  const _ActivityCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: AppCard(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.surfaceHover,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(data.icon, color: AppColors.accent, size: 16),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    data.time,
                    style: const TextStyle(fontSize: 11, color: AppColors.textTertiary),
                  ),
                ],
              ),
            ),
            Text(
              data.value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.accent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// HomeProfile - Profile view
// ============================================================

class HomeProfile extends StatelessWidget {
  final void Function(String) onNavigate;
  const HomeProfile({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 8),
            _ProfileHeader(onEdit: () => onNavigate('editar-perfil')),
            const SizedBox(height: 24),
            const _ProfileStats(),
            const SizedBox(height: 24),
            const _Achievements(),
            const SizedBox(height: 24),
            const _Preferences(),
            const SizedBox(height: 24),
            _logoutButton(context),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final VoidCallback onEdit;
  const _ProfileHeader({required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            const AvatarCircle(letters: 'V', size: 72),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.bg, width: 2),
                ),
                child: const Icon(Icons.star, color: Color(0xFF0F0F0F), size: 12),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          'Valentina R.',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          '@vale.fit',
          style: TextStyle(fontSize: 13, color: AppColors.accent),
        ),
        const SizedBox(height: 4),
        Text(
          'Miembro desde junio 2025 \u00b7 Plan: Tonificaci\u00f3n',
          style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 12),
        InkWell(
          onTap: onEdit,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.edit, color: AppColors.accent, size: 14),
                const SizedBox(width: 6),
                const Text(
                  'Editar perfil',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.accent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ProfileStats extends StatelessWidget {
  const _ProfileStats();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          Row(
            children: [
              _profileStatItem('Peso', '63 kg'),
              _profileStatItem('Altura', '1.68 m'),
            ],
          ),
          const SizedBox(height: 8),
          Container(height: 1, color: AppColors.border.withValues(alpha: 0.15)),
          const SizedBox(height: 8),
          Row(
            children: [
              _profileStatItem('Entrenos', '143'),
              _profileStatItem('Completitud', '87%'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _profileStatItem(String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.accent,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _Achievements extends StatelessWidget {
  const _Achievements();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(text: 'Logros'),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(child: _achievementCard('Racha', '7', Icons.local_fire_department, false)),
            const SizedBox(width: 8),
            Expanded(child: _achievementCard('Amigos', '50', Icons.lock, true)),
            const SizedBox(width: 8),
            Expanded(child: _achievementCard('Entrenos', '100', Icons.lock, true)),
          ],
        ),
      ],
    );
  }

  Widget _achievementCard(String title, String value, IconData icon, bool locked) {
    return AppCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Icon(
            icon,
            color: locked ? AppColors.textTertiary : AppColors.accent,
            size: 22,
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: locked ? AppColors.textTertiary : AppColors.text,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: locked ? AppColors.textTertiary : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _Preferences extends StatelessWidget {
  const _Preferences();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(text: 'Preferencias'),
        ToggleRow(
          label: 'Recordatorios',
          subLabel: 'Recibe notificaciones de rutinas',
          value: true,
          onChanged: (_) {},
        ),
        ToggleRow(
          label: 'Perfil p\u00fablico',
          subLabel: 'Visible para otros usuarios',
          value: true,
          onChanged: (_) {},
        ),
        ToggleRow(
          label: 'Modo oscuro',
          subLabel: 'Tema oscuro del sistema',
          value: true,
          onChanged: (_) {},
        ),
        ToggleRow(
          label: 'Sonido',
          subLabel: 'Efectos de sonido en la app',
          value: false,
          onChanged: (_) {},
        ),
      ],
    );
  }
}

Widget _logoutButton(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    child: TextButton(
      onPressed: () {
        ToastOverlayState.of(context)?.show('Cerrando sesi\u00f3n...');
      },
      style: TextButton.styleFrom(
        foregroundColor: AppColors.accentRose,
        side: BorderSide(color: AppColors.accentRose.withValues(alpha: 0.4)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.logout, size: 16, color: AppColors.accentRose),
          const SizedBox(width: 8),
          const Text(
            'Cerrar sesi\u00f3n',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.accentRose,
            ),
          ),
        ],
      ),
    ),
  );
}

// ============================================================
// EditProfile - Edit profile form
// ============================================================

class EditProfile extends StatefulWidget {
  final VoidCallback onGoBack;
  final void Function(String name, String email, double peso, double altura, String username) onSaved;
  const EditProfile({
    super.key,
    required this.onGoBack,
    required this.onSaved,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _nameController = TextEditingController(text: 'Valentina R.');
  final _emailController = TextEditingController(text: 'vale.fit@email.com');
  final _usernameController = TextEditingController(text: '@vale.fit');
  final _pesoController = TextEditingController(text: '63');
  final _alturaController = TextEditingController(text: '1.68');
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _adulto = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _pesoController.dispose();
    _alturaController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _save() {
    widget.onSaved(
      _nameController.text,
      _emailController.text,
      double.tryParse(_pesoController.text.replaceAll(',', '.')) ?? 0,
      double.tryParse(_alturaController.text.replaceAll(',', '.')) ?? 0,
      _usernameController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 8),
            _buildTopBar(context),
            const SizedBox(height: 24),
            _buildAvatarSection(),
            const SizedBox(height: 28),
            _buildFormFields(),
            const SizedBox(height: 24),
            _buildPasswordSection(),
            const SizedBox(height: 28),
            AppButton(
              text: 'Guardar cambios',
              type: AppButtonType.primary,
              onPressed: _save,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: widget.onGoBack,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.textSecondary,
            padding: const EdgeInsets.symmetric(horizontal: 8),
          ),
          child: const Text(
            'Cancelar',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
        const Spacer(),
        const Text(
          'Editar perfil',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.text,
            letterSpacing: -0.01,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: _save,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Guardar',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F0F0F),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAvatarSection() {
    return Center(
      child: Stack(
        children: [
          const AvatarCircle(letters: 'V', size: 72),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: AppColors.accent,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.bg, width: 2),
              ),
              child: const Icon(Icons.camera_alt, color: Color(0xFF0F0F0F), size: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        _buildField('Nombre', _nameController),
        const SizedBox(height: 14),
        _buildField('Email', _emailController),
        const SizedBox(height: 14),
        _buildAgeSelector(),
        const SizedBox(height: 14),
        _buildField('Peso (kg)', _pesoController),
        const SizedBox(height: 14),
        _buildField('Altura (m)', _alturaController),
        const SizedBox(height: 14),
        _buildField('Usuario', _usernameController),
      ],
    );
  }

  Widget _buildField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      style: const TextStyle(color: AppColors.text, fontSize: 14),
    );
  }

  Widget _buildAgeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Text(
            'Edad',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Row(
          children: [
            Chip(
              text: 'Adulto',
              selected: _adulto,
              onTap: () => setState(() { _adulto = true; }),
            ),
            const SizedBox(width: 10),
            Chip(
              text: 'Adolescente',
              selected: !_adulto,
              onTap: () => setState(() { _adulto = false; }),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPasswordSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(text: 'Cambiar contrase\u00f1a'),
        const SizedBox(height: 4),
        _buildField('Contrase\u00f1a actual', _currentPasswordController),
        const SizedBox(height: 14),
        _buildField('Nueva contrase\u00f1a', _newPasswordController),
        const SizedBox(height: 14),
        _buildField('Confirmar contrase\u00f1a', _confirmPasswordController),
      ],
    );
  }
}
