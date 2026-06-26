import 'package:flutter/material.dart';
import 'package:vitalis_app/theme/app_theme.dart';
import 'package:vitalis_app/widgets/common_widgets.dart';
import 'package:vitalis_app/widgets/phone_frame.dart';

class SocialScreens extends StatefulWidget {
  final int tab;
  final PhoneFrameState phoneFrame;
  const SocialScreens({super.key, required this.tab, required this.phoneFrame});
  @override
  State<SocialScreens> createState() => SocialScreensState();
}

class SocialScreensState extends State<SocialScreens> {
  final List<String> _stack = ['main'];

  String _profileName = '';
  String _profileInitials = '';
  String _profileUsername = '';
  int _profileLevel = 0;
  int _profileStreak = 0;
  int _profileLogros = 0;
  int _profileGrupos = 0;

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

  void showProfile(String name, String initials, String username,
      int level, int streak, int logros, int grupos) {
    setState(() {
      _profileName = name;
      _profileInitials = initials;
      _profileUsername = username;
      _profileLevel = level;
      _profileStreak = streak;
      _profileLogros = logros;
      _profileGrupos = grupos;
      _stack.add('perfil');
    });
  }

  @override
  void initState() {
    super.initState();
    Nav.register(tab, push, pop);
    Nav.registerSocialProfile(showProfile);
  }

  @override
  Widget build(BuildContext context) {
    final view = _stack.last;
    return KeyedSubtree(key: ValueKey(view), child: _buildScreen(view));
  }

  Widget _buildScreen(String view) {
    switch (view) {
      case 'main':
        return _SocialMain(parent: this);
      case 'perfil':
        return _SocialProfile(
          parent: this,
          name: _profileName,
          initials: _profileInitials,
          username: _profileUsername,
          level: _profileLevel,
          streak: _profileStreak,
          logros: _profileLogros,
          grupos: _profileGrupos,
        );
      case 'crear-grupo':
        return _SocialCreateGroup(parent: this);
      case 'crear-evento':
        return _SocialCreateEvent(parent: this);
      case 'evento':
        return _SocialEvent(parent: this);
      case 'evidencia':
        return _SocialEvidence(parent: this);
      default:
        return _SocialMain(parent: this);
    }
  }
}

class _SocialMain extends StatelessWidget {
  final SocialScreensState parent;
  const _SocialMain({required this.parent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Social')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 80),
        children: [
          _UserCard(onTap: () {}),
          const SectionTitle(text: 'ACTIVIDAD RECIENTE'),
          _ActivityCard(
            name: 'María Pérez',
            initials: 'MP',
            action: 'Completó Reto 30 días',
            time: 'hace 2h',
            onTap: () => parent.showProfile('María Pérez', 'MP', '@mariaperez', 12, 7, 5, 3),
          ),
          const SizedBox(height: 8),
          _ActivityCard(
            name: 'Carlos López',
            initials: 'CL',
            action: 'Nuevo récord press banca 80 kg',
            time: 'hace 5h',
            onTap: () => parent.showProfile('Carlos López', 'CL', '@carloslopez', 18, 14, 9, 5),
          ),
          const SizedBox(height: 8),
          _ActivityCard(
            name: 'Ana García',
            initials: 'AG',
            action: 'Subió evidencia',
            time: 'hace 1d',
            onTap: () => parent.showProfile('Ana García', 'AG', '@anagarcia', 8, 3, 4, 2),
          ),
          const SectionTitle(text: 'GRUPOS'),
          _GroupCard(
            name: 'Reto 30 días',
            memberCount: 23,
            subtitle: null,
            onTap: () {},
          ),
          _GroupCard(
            name: 'Running Club',
            memberCount: 15,
            subtitle: 'Evento mañana',
            onTap: () {},
          ),
          _GroupCard(
            name: 'Yoga & Meditación',
            memberCount: 8,
            subtitle: null,
            onTap: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => parent.push('crear-grupo'),
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.bg,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  final VoidCallback onTap;
  const _UserCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const AvatarCircle(letters: 'JD', size: 52),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Juan David',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.text)),
                const SizedBox(height: 2),
                Text('12 grupos \u00b7 8 eventos este mes',
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final String name;
  final String initials;
  final String action;
  final String time;
  final VoidCallback onTap;

  const _ActivityCard({
    required this.name,
    required this.initials,
    required this.action,
    required this.time,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          AvatarCircle(letters: initials, size: 36),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text)),
                const SizedBox(height: 1),
                Text(action,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          Text(time,
              style: const TextStyle(
                  fontSize: 11, color: AppColors.textTertiary)),
        ],
      ),
    );
  }
}

class _GroupCard extends StatelessWidget {
  final String name;
  final int memberCount;
  final String? subtitle;
  final VoidCallback onTap;

  const _GroupCard({
    required this.name,
    required this.memberCount,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListItem(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: const Icon(Icons.group, color: AppColors.accent, size: 20),
      ),
      title: name,
      subtitle: subtitle != null ? '$memberCount miembros \u00b7 $subtitle' : '$memberCount miembros',
      onTap: onTap,
    );
  }
}

class _SocialProfile extends StatelessWidget {
  final SocialScreensState parent;
  final String name;
  final String initials;
  final String username;
  final int level;
  final int streak;
  final int logros;
  final int grupos;

  const _SocialProfile({
    required this.parent,
    required this.name,
    required this.initials,
    required this.username,
    required this.level,
    required this.streak,
    required this.logros,
    required this.grupos,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: parent.pop,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
        children: [
          Center(
            child: Column(
              children: [
                AvatarCircle(letters: initials, size: 80),
                const SizedBox(height: 12),
                Text(name,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.text)),
                Text(username,
                    style: const TextStyle(
                        fontSize: 14, color: AppColors.textSecondary)),
                const SizedBox(height: 4),
                const Text('Miembro desde 2024',
                    style: TextStyle(
                        fontSize: 12, color: AppColors.textTertiary)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              StatCard(value: '$level', label: 'Nivel'),
              const SizedBox(width: 8),
              StatCard(value: '$streak', label: 'Racha actual'),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              StatCard(value: '$logros', label: 'Logros'),
              const SizedBox(width: 8),
              StatCard(value: '$grupos', label: 'Grupos'),
            ],
          ),
          const SectionTitle(text: 'ACTIVIDAD RECIENTE'),
          _ProfileActivityItem(
            title: 'Press banca 80 kg',
            trailing: const _RecordBadge(),
          ),
          _ProfileActivityItem(
            title: 'Reto 30 d\u00edas D\u00eda 24/30',
            trailing: const Pill(text: 'En curso', type: PillType.info),
          ),
          _ProfileActivityItem(
            title: 'Carrera 5K 26:34',
            trailing: const Text('26:34',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.accent)),
          ),
          const SizedBox(height: 20),
          AppButton(
            text: 'Agregar amigo',
            icon: const Icon(Icons.person_add, size: 18),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _ProfileActivityItem extends StatelessWidget {
  final String title;
  final Widget trailing;

  const _ProfileActivityItem({required this.title, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0x26B89066))),
      ),
      child: Row(
        children: [
          const Icon(Icons.fitness_center,
              color: AppColors.textSecondary, size: 16),
          const SizedBox(width: 10),
          Expanded(
            child: Text(title,
                style: const TextStyle(
                    fontSize: 14, color: AppColors.text)),
          ),
          trailing,
        ],
      ),
    );
  }
}

class _RecordBadge extends StatelessWidget {
  const _RecordBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text('R\u00e9cord',
          style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.accent)),
    );
  }
}

class _SocialCreateGroup extends StatefulWidget {
  final SocialScreensState parent;
  const _SocialCreateGroup({required this.parent});

  @override
  State<_SocialCreateGroup> createState() => _SocialCreateGroupState();
}

class _SocialCreateGroupState extends State<_SocialCreateGroup> {
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  bool _isPublico = true;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear grupo'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.parent.pop,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
        children: [
          TextField(
            controller: _nameCtrl,
            decoration: const InputDecoration(labelText: 'Nombre del grupo'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _descCtrl,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Descripci\u00f3n',
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 16),
          const Text('Privacidad',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.accent)),
          const SizedBox(height: 8),
          Row(
            children: [
              Chip(
                text: 'P\u00fablico',
                selected: _isPublico,
                onTap: () => setState(() => _isPublico = true),
              ),
              const SizedBox(width: 8),
              Chip(
                text: 'Privado',
                selected: !_isPublico,
                onTap: () => setState(() => _isPublico = false),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const SectionTitle(text: 'MIEMBROS'),
          AppCard(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.person_add, color: AppColors.accent, size: 20),
                const SizedBox(width: 10),
                const Text('A\u00f1adir miembros',
                    style: TextStyle(
                        fontSize: 14, color: AppColors.textSecondary)),
                const Spacer(),
                const Text('0',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textTertiary)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          AppButton(
            text: 'Crear grupo',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _SocialCreateEvent extends StatefulWidget {
  final SocialScreensState parent;
  const _SocialCreateEvent({required this.parent});

  @override
  State<_SocialCreateEvent> createState() => _SocialCreateEventState();
}

class _SocialCreateEventState extends State<_SocialCreateEvent> {
  final _nameCtrl = TextEditingController();
  final _dateCtrl = TextEditingController();
  final _timeCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  String _selectedType = 'Entrenamiento';

  @override
  void dispose() {
    _nameCtrl.dispose();
    _dateCtrl.dispose();
    _timeCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear evento'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.parent.pop,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
        children: [
          TextField(
            controller: _nameCtrl,
            decoration: const InputDecoration(labelText: 'Nombre del evento'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _dateCtrl,
            decoration: const InputDecoration(
              labelText: 'Fecha',
              hintText: 'DD/MM/AAAA',
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _timeCtrl,
            decoration: const InputDecoration(
              labelText: 'Hora',
              hintText: 'HH:MM',
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _descCtrl,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Descripci\u00f3n',
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 16),
          const Text('Tipo',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.accent)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: ['Entrenamiento', 'Nutrici\u00f3n', 'Social']
                .map((t) => Chip(
                      text: t,
                      selected: _selectedType == t,
                      onTap: () => setState(() => _selectedType = t),
                    ))
                .toList(),
          ),
          const SizedBox(height: 20),
          AppButton(
            text: 'Crear evento',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _SocialEvent extends StatelessWidget {
  final SocialScreensState parent;
  const _SocialEvent({required this.parent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Evento'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: parent.pop,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
        children: [
          AppCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Carrera 5K',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.text)),
                const SizedBox(height: 8),
                _EventInfoRow(
                    icon: Icons.calendar_today, text: 'S\u00e1bado 28 jun'),
                const SizedBox(height: 4),
                _EventInfoRow(icon: Icons.access_time, text: '08:00'),
                const SizedBox(height: 4),
                _EventInfoRow(
                    icon: Icons.location_on, text: 'Parque Central'),
              ],
            ),
          ),
          const SectionTitle(text: 'PARTICIPANTES (12)'),
          AppCard(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                _AvatarStack(),
                const Spacer(),
                const Text('+12',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary)),
              ],
            ),
          ),
          const SectionTitle(text: 'EVIDENCIA'),
          AppCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Sube tu resultado',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text)),
                const SizedBox(height: 4),
                const Text('Comparte tu tiempo o distancia',
                    style: TextStyle(
                        fontSize: 12, color: AppColors.textSecondary)),
                const SizedBox(height: 12),
                AppButton(
                  text: 'Subir evidencia',
                  type: AppButtonType.secondary,
                  onPressed: () => parent.push('evidencia'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          AppButton(
            text: 'Unirse al evento',
            icon: const Icon(Icons.event, size: 18),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _EventInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _EventInfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.textSecondary),
        const SizedBox(width: 8),
        Text(text,
            style: const TextStyle(
                fontSize: 13, color: AppColors.textSecondary)),
      ],
    );
  }
}

class _AvatarStack extends StatelessWidget {
  final List<String> initials;
  const _AvatarStack({this.initials = const ['MP', 'CL', 'JD', 'AG']});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: Stack(
        children: initials.asMap().entries.map((e) {
          return Positioned(
            left: e.key * 22.0,
            child: AvatarCircle(letters: e.value, size: 32),
          );
        }).toList(),
      ),
    );
  }
}

class _SocialEvidence extends StatefulWidget {
  final SocialScreensState parent;
  const _SocialEvidence({required this.parent});

  @override
  State<_SocialEvidence> createState() => _SocialEvidenceState();
}

class _SocialEvidenceState extends State<_SocialEvidence> {
  final _notesCtrl = TextEditingController();

  @override
  void dispose() {
    _notesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subir evidencia'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.parent.pop,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.border,
                width: 1.5,
              ),
            ),
            child: const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.cloud_upload_outlined,
                      color: AppColors.textTertiary, size: 36),
                  SizedBox(height: 8),
                  Text('Toca para subir imagen',
                      style: TextStyle(
                          fontSize: 14, color: AppColors.textSecondary)),
                  Text('PNG, JPG m\u00e1x 5MB',
                      style: TextStyle(
                          fontSize: 11, color: AppColors.textTertiary)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _notesCtrl,
            maxLines: 5,
            decoration: const InputDecoration(
              labelText: 'Notas',
              alignLabelWithHint: true,
              hintText: 'Describe tu resultado...',
            ),
          ),
          const SizedBox(height: 20),
          AppButton(
            text: 'Subir evidencia',
            icon: const Icon(Icons.upload, size: 18),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
