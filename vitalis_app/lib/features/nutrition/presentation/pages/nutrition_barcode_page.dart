import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/core/widgets/common_widgets.dart';
import 'package:vitalis_app/core/theme/app_theme.dart';
import '../widgets/nutrition_widgets.dart';

class NutritionBarcodePage extends StatefulWidget {
  final VoidCallback onGoBack;
  const NutritionBarcodePage({super.key, required this.onGoBack});
  @override
  State<NutritionBarcodePage> createState() => _NutritionBarcodePageState();
}

class _NutritionBarcodePageState extends State<NutritionBarcodePage> {
  int _selectedChip = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: widget.onGoBack,
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
                  color: AppColors.accent.withValues(alpha: 0.5),
                  width: 2,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    CustomPaint(
                      size: const Size(250, 180),
                      painter: ScannerGridPainter(),
                    ),
                    const PulsingLine(),
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
