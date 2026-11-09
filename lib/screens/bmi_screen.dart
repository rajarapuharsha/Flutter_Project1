import 'package:flutter/material.dart';
import '../models/health_result.dart';
import '../services/bmi_calculator.dart';
import '../services/calorie_calculator.dart';
import '../utils/app_theme.dart';
import '../utils/health_advice.dart';
import '../utils/input_validator.dart';
import '../widgets/custom_button.dart';
import '../widgets/health_indicator.dart';
import '../widgets/input_field.dart';
import 'result_screen.dart';

/// Dedicated BMI Calculator Screen allowing users to calculate Body Mass Index,
/// view WHO classifications, visual spectrum gauges, and lifestyle advice.
class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _scrollController = ScrollController();

  double? _bmi;
  String? _category;
  String? _advice;
  bool _isPediatric = false;
  bool _useCircularGauge = false;
  HealthResult? _lastResult;

  @override
  void dispose() {
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _calculateBmi() {
    if (_formKey.currentState?.validate() ?? false) {
      final age = int.parse(_ageController.text.trim());
      final height = double.parse(_heightController.text.trim());
      final weight = double.parse(_weightController.text.trim());

      final calculatedBmi = BmiCalculator.calculateBMI(weight, height);
      final isPediatric = age < 18;
      final category = BmiCalculator.classifyCategory(calculatedBmi, age: age);
      final advice = HealthAdvice.getBmiAdvice(category, isPediatric: isPediatric);

      // Estimate BMR & TDEE with default parameters for full report
      final bmr = CalorieCalculator.calculateBMR(
        age: age,
        sex: BiologicalSex.male,
        heightCm: height,
        weightKg: weight,
      );
      final maintenance = CalorieCalculator.calculateDailyCalories(
        bmr,
        ActivityLevel.moderatelyActive.multiplier,
      );
      final goalCalories = CalorieCalculator.calculateGoalCalories(
        maintenanceCalories: maintenance,
        goal: CalorieGoal.maintain,
        isPediatric: isPediatric,
      );

      final fullResult = HealthResult(
        age: age,
        sex: BiologicalSex.male,
        heightCm: height,
        weightKg: weight,
        activityLevel: ActivityLevel.moderatelyActive,
        calorieGoal: CalorieGoal.maintain,
        bmi: calculatedBmi,
        bmiCategory: category,
        bmiAdvice: advice,
        bmr: bmr,
        maintenanceCalories: maintenance,
        goalCalories: goalCalories,
        isPediatric: isPediatric,
        safetyNotice: isPediatric
            ? 'Note: Age is under 18 years. BMI percentiles on clinical pediatric charts should be evaluated.'
            : null,
      );

      setState(() {
        _bmi = calculatedBmi;
        _category = category;
        _advice = advice;
        _isPediatric = isPediatric;
        _lastResult = fullResult;
      });

      // Smoothly scroll down towards results
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            350,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  void _reset() {
    _formKey.currentState?.reset();
    _ageController.clear();
    _heightController.clear();
    _weightController.clear();
    setState(() {
      _bmi = null;
      _category = null;
      _advice = null;
      _isPediatric = false;
      _lastResult = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.scale_outlined, size: 22),
            SizedBox(width: 10),
            Text('BMI Calculator'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Intro
                _buildHeaderCard(context, isDark),
                const SizedBox(height: 20),

                // Measurement Form Card
                _buildFormCard(context),
                const SizedBox(height: 24),

                // Results Card if calculated
                if (_bmi != null && _category != null) ...[
                  _buildResultCard(context, isDark),
                  const SizedBox(height: 20),
                ],

                // Screening Disclaimer
                _buildDisclaimerCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF1E293B), const Color(0xFF0F172A)]
              : [AppTheme.primaryNavy, const Color(0xFF1E3A8A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryNavy.withOpacity(0.18),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.monitor_weight_outlined, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Body Mass Index (BMI)',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'WHO Adult Classification Standard (kg/m²)',
                      style: TextStyle(fontSize: 12, color: Color(0xFF93C5FD)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'BMI evaluates body weight relative to stature: Weight (kg) / Height (m)². '
            'Enter your age, height, and weight to determine your category.',
            style: TextStyle(fontSize: 13, height: 1.45, color: Color(0xFFF1F5F9)),
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.edit_note, color: AppTheme.secondaryTeal, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    'Enter Your Measurements',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                  ),
                ],
              ),
              const Divider(height: 24),

              // Age Input
              InputField(
                controller: _ageController,
                labelText: 'Age (years)',
                hintText: 'e.g. 24',
                prefixIcon: Icons.cake_outlined,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                validator: InputValidator.validateAge,
              ),
              const SizedBox(height: 16),

              // Height Input (cm)
              InputField(
                controller: _heightController,
                labelText: 'Height (cm)',
                hintText: 'e.g. 175.0',
                suffixText: 'cm',
                prefixIcon: Icons.height,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.next,
                validator: InputValidator.validateHeight,
              ),
              const SizedBox(height: 16),

              // Weight Input (kg)
              InputField(
                controller: _weightController,
                labelText: 'Weight (kg)',
                hintText: 'e.g. 70.5',
                suffixText: 'kg',
                prefixIcon: Icons.fitness_center_outlined,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _calculateBmi(),
                validator: InputValidator.validateWeight,
              ),
              const SizedBox(height: 24),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CustomButton(
                      label: 'Calculate BMI',
                      icon: Icons.calculate_outlined,
                      onPressed: _calculateBmi,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 1,
                    child: CustomButton(
                      label: 'Clear',
                      icon: Icons.refresh_outlined,
                      isOutlined: true,
                      onPressed: _reset,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultCard(BuildContext context, bool isDark) {
    final activeColor = AppTheme.getColorForCategory(_category!);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: activeColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.analytics_outlined, color: activeColor, size: 22),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'BMI Analysis Result',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                // Indicator format switcher
                IconButton(
                  tooltip: _useCircularGauge ? 'Switch to Bar View' : 'Switch to Gauge View',
                  icon: Icon(_useCircularGauge ? Icons.linear_scale : Icons.timelapse),
                  onPressed: () {
                    setState(() {
                      _useCircularGauge = !_useCircularGauge;
                    });
                  },
                ),
              ],
            ),
            const Divider(height: 24),

            // Large BMI Numerical Value & Health Category
            Center(
              child: Column(
                children: [
                  Text(
                    _bmi!.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                      letterSpacing: -1,
                    ),
                  ),
                  const Text(
                    'kg / m²',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: activeColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: activeColor, width: 1.5),
                    ),
                    child: Text(
                      _category!,
                      style: TextStyle(
                        color: activeColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Health Indicator (Spectrum Bar or Radial Gauge)
            HealthIndicator(
              bmi: _bmi!,
              category: _category!,
              isPediatric: _isPediatric,
              isCircular: _useCircularGauge,
            ),
            const SizedBox(height: 20),

            // Personalized Wellness Guidance
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lightbulb_outline, color: activeColor, size: 20),
                      const SizedBox(width: 8),
                      const Text(
                        'General Wellness Guidance',
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _advice!,
                    style: const TextStyle(fontSize: 13, height: 1.45, color: Color(0xFF475569)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Navigate to Full Results Screen
            if (_lastResult != null)
              CustomButton(
                label: 'View Complete Health Profile',
                icon: Icons.assessment_outlined,
                backgroundColor: AppTheme.secondaryTeal,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultScreen(result: _lastResult!),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDisclaimerCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFDE68A)),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.shield_outlined, color: Color(0xFFB45309), size: 20),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Notice: BMI is an epidemiological screening indicator, not a definitive medical diagnosis. '
              'It does not distinguish between lean muscle mass and body fat. Consult a qualified physician for clinical advice.',
              style: TextStyle(fontSize: 12, color: Color(0xFF92400E), height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
