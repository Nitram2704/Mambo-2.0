import 'package:flutter/material.dart' hide Chip;
import 'package:vitalis_app/core/widgets/common_widgets.dart';
import 'package:vitalis_app/core/theme/app_theme.dart';
import 'package:vitalis_app/core/widgets/toast.dart';

class NutritionManualPage extends StatefulWidget {
  final VoidCallback onGoBack;
  const NutritionManualPage({super.key, required this.onGoBack});
  @override
  State<NutritionManualPage> createState() => _NutritionManualPageState();
}

class _NutritionManualPageState extends State<NutritionManualPage> {
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
          onPressed: widget.onGoBack,
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
