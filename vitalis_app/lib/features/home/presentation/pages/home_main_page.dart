import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/core/widgets/common_widgets.dart';
import 'package:vitalis_app/core/theme/app_theme.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/activity.dart';
import '../widgets/home_widgets.dart';

class HomeMainPage extends StatelessWidget {
  final User user;
  final List<Activity> activities;
  final void Function(String) onNavigate;

  const HomeMainPage({
    super.key,
    required this.user,
    required this.activities,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            GreetingWidget(
              initials: 'V',
              onProfileTap: () => onNavigate('profile'),
            ),
            const SizedBox(height: 24),
            _buildStatsRow(
              const StatCard(value: '3', label: 'Entrenos hoy'),
              const StatCard(value: '7.2', label: 'Horas sueño'),
            ),
            const SizedBox(height: 8),
            _buildStatsRow(
              const StatCard(value: '1,842', label: 'kcal'),
              const StatCard(value: '2', label: 'Eventos'),
            ),
            const SizedBox(height: 16),
            _buildStreakCard(),
            const SizedBox(height: 24),
            const SectionTitle(text: 'Acceso rápido'),
            const SizedBox(height: 4),
            _buildQuickAccessGrid(context),
            const SizedBox(height: 24),
            const SectionTitle(text: 'Actividad reciente'),
            const SizedBox(height: 4),
            _buildRecentActivity(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow(Widget left, Widget right) {
    return Row(children: [left, const SizedBox(width: 8), right]);
  }

  Widget _buildStreakCard() {
    const days = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
    return AppCard(
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.star, color: AppColors.accent, size: 20),
              const SizedBox(width: 8),
              const Text('7 días de racha',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.text)),
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
                    decoration: const BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
                    child: const Icon(Icons.check, color: Color(0xFF0F0F0F), size: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(days[i], style: const TextStyle(fontSize: 10, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                ],
              );
            }),
          ),
          const SizedBox(height: 16),
          Container(height: 1, color: AppColors.border.withOpacity(0.15)),
          const SizedBox(height: 12),
          const Row(
            children: [
              _StreakStat(value: '24', label: 'días activos\neste mes'),
              SizedBox(width: 24),
              _StreakStat(value: '85%', label: 'constancia\nsemanal'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccessGrid(BuildContext context) {
    final cards = [
      const QuickCardData('Entrenamiento', '3 rutinas activas', Icons.fitness_center),
      const QuickCardData('Sueño', 'Objetivo: 8h', Icons.bedtime),
      const QuickCardData('Alimentación', '1,842/2,200 kcal', Icons.restaurant),
      const QuickCardData('Social', '2 grupos, 1 evento', Icons.people),
    ];
    return Column(
      children: [
        Row(children: [
          Expanded(child: QuickAccessCard(data: cards[0])),
          const SizedBox(width: 8),
          Expanded(child: QuickAccessCard(data: cards[1])),
        ]),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(child: QuickAccessCard(data: cards[2])),
          const SizedBox(width: 8),
          Expanded(child: QuickAccessCard(data: cards[3])),
        ]),
      ],
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      children: activities.map((a) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: ActivityCardWidget(data: a),
      )).toList(),
    );
  }
}

class _StreakStat extends StatelessWidget {
  final String value;
  final String label;
  const _StreakStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Text(value, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: AppColors.accent, height: 1.1)),
          const SizedBox(width: 6),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, height: 1.3))),
        ],
      ),
    );
  }
}
