import 'package:flutter/material.dart';
import '../models/health_result.dart';
import '../services/bmi_calculator.dart';
import '../services/calorie_calculator.dart';
import '../utils/app_theme.dart';
import '../utils/health_advice.dart';
import '../utils/input_validator.dart';
import '../widgets/custom_button.dart';
import '../widgets/input_field.dart';
import '../widgets/result_card.dart';
import 'result_screen.dart';

/// Dedicated Daily Calorie Calculator Screen estimating Basal Metabolic Rate (BMR)
/// via the Mifflin-St Jeor equation and Total Daily Energy Expenditure (TDEE)
/// across five standardized physical activity tiers.
class CalorieScreen extends StatefulWidget {
  const CalorieScreen({super.key});

  @override
  State<CalorieScreen> createState() => _CalorieScreenState();
}

class _CalorieScreenState extends State<CalorieScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _scrollController = ScrollController();

  BiologicalSex _selectedSex = BiologicalSex.male;
  ActivityLevel _selectedActivity = ActivityLevel.moderatelyActive;
  CalorieGoal _selectedGoal = CalorieGoal.maintain;

  double? _bmr;
  double? _maintenanceCalories;
  double? _goalCalories;
  bool _isPediatric = false;
  HealthResult? _lastResult;

  @override
  void dispose() {
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _calculateCalories() {
    if (_formKey.currentState?.validate() ?? false) {
      final age = int.parse(_ageController.text.trim());
      final height = double.parse(_heightController.text.trim());
      final weight = double.parse(_weightController.text.trim());
      final isPediatric = age < 18;

      // 1. Calculate BMR using Mifflin-St Jeor
      final bmr = CalorieCalculator.calculateBMR(
        age: age,
        sex: _selectedSex,
        heightCm: height,
        weightKg: weight,
      );

      // 2. Calculate Daily Maintenance Calories (TDEE)
      final multiplier = CalorieCalculator.getActivityMultiplier(_selectedActivity);
      final maintenance = CalorieCalculator.calculateDailyCalories(bmr, multiplier);

      // 3. Calculate Caloric Goal Adjustment
      final goalCalories = CalorieCalculator.calculateGoalCalories(
        maintenanceCalories: maintenance,
        goal: _selectedGoal,
        isPediatric: isPediatric,
      );

      // 4. Calculate BMI for comprehensive profile
      final bmi = BmiCalculator.calculateBMI(weight, height);
      final category = BmiCalculator.classifyCategory(bmi, age: age);
      final advice = HealthAdvice.getBmiAdvice(category, isPediatric: isPediatric);

      final fullResult = HealthResult(
        age: age,
        sex: _selectedSex,
        heightCm: height,
        weightKg: weight,
        activityLevel: _selectedActivity,
        calorieGoal: _selectedGoal,
        bmi: bmi,
        bmiCategory: category,
        bmiAdvice: advice,
        bmr: bmr,
        maintenanceCalories: maintenance,
        goalCalories: goalCalories,
        isPediatric: isPediatric,
        safetyNotice: isPediatric
            ? 'Note: User is under 18. Pediatric caloric needs depend dynamically on growth and puberty.'
            : null,
      );

      setState(() {
        _bmr = bmr;
        _maintenanceCalories = maintenance;
        _goalCalories = goalCalories;
        _isPediatric = isPediatric;
        _lastResult = fullResult;
      });

      // Smoothly scroll down towards results
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            450,
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
      _selectedSex = BiologicalSex.male;
      _selectedActivity = ActivityLevel.moderatelyActive;
      _selectedGoal = CalorieGoal.maintain;
      _bmr = null;
      _maintenanceCalories = null;
      _goalCalories = null;
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
            Icon(Icons.local_fire_department_outlined, size: 22),
            SizedBox(width: 10),
            Text('Daily Calorie Calculator'),
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
                // Header Banner
                _buildHeaderCard(context, isDark),
                const SizedBox(height: 20),

                // Form Card
                _buildFormCard(context),
                const SizedBox(height: 24),

                // Results section if calculated
                if (_bmr != null && _maintenanceCalories != null) ...[
                  _buildResultsSection(context, isDark),
                  const SizedBox(height: 20),
                ],

                // Calorie Disclaimer
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
              : [AppTheme.secondaryTeal, const Color(0xFF0F766E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.secondaryTeal.withOpacity(0.2),
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
                child: const Icon(Icons.bolt_outlined, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mifflin-St Jeor Energy Estimator',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'BMR & Total Daily Energy Expenditure (TDEE)',
                      style: TextStyle(fontSize: 12, color: Color(0xFFCCFBF1)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Basal Metabolic Rate represents baseline calories burned at complete rest. '
            'Scaling BMR with your daily physical activity level estimates your maintenance calorie requirement.',
            style: TextStyle(fontSize: 13, height: 1.45, color: Color(0xFFF0FDFA)),
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
                  const Icon(Icons.person_outline, color: AppTheme.primaryNavy, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    'Personal Biometrics & Activity',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                  ),
                ],
              ),
              const Divider(height: 24),

              // Sex Selection & Age in a responsive row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Age Input
                  Expanded(
                    flex: 1,
                    child: InputField(
                      controller: _ageController,
                      labelText: 'Age (years)',
                      hintText: 'e.g. 25',
                      prefixIcon: Icons.cake_outlined,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      validator: InputValidator.validateAge,
                    ),
                  ),
                  const SizedBox(width: 14),

                  // Biological Sex Selector
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Biological Sex',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF475569),
                              ),
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          height: 52,
                          child: SegmentedButton<BiologicalSex>(
                            segments: const [
                              ButtonSegment(
                                value: BiologicalSex.male,
                                label: Text('Male'),
                                icon: Icon(Icons.male, size: 18),
                              ),
                              ButtonSegment(
                                value: BiologicalSex.female,
                                label: Text('Female'),
                                icon: Icon(Icons.female, size: 18),
                              ),
                            ],
                            selected: {_selectedSex},
                            onSelectionChanged: (newSelection) {
                              setState(() {
                                _selectedSex = newSelection.first;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Height and Weight Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: InputField(
                      controller: _heightController,
                      labelText: 'Height (cm)',
                      hintText: 'e.g. 175.0',
                      suffixText: 'cm',
                      prefixIcon: Icons.height,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      textInputAction: TextInputAction.next,
                      validator: InputValidator.validateHeight,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: InputField(
                      controller: _weightController,
                      labelText: 'Weight (kg)',
                      hintText: 'e.g. 70.0',
                      suffixText: 'kg',
                      prefixIcon: Icons.monitor_weight_outlined,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      textInputAction: TextInputAction.next,
                      validator: InputValidator.validateWeight,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Activity Level Dropdown (Demonstrating DropdownButtonFormField Concept #8!)
              Text(
                'Physical Activity Level (TDEE Factor)',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF334155),
                    ),
              ),
              const SizedBox(height: 6),
              DropdownButtonFormField<ActivityLevel>(
                value: _selectedActivity,
                isExpanded: true,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.directions_run_outlined),
                ),
                items: ActivityLevel.values.map((level) {
                  return DropdownMenuItem<ActivityLevel>(
                    value: level,
                    child: Text(
                      '${level.displayName} (${level.multiplier}x) — ${level.description}',
                      style: const TextStyle(fontSize: 13),
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
                onChanged: (newLevel) {
                  if (newLevel != null) {
                    setState(() {
                      _selectedActivity = newLevel;
                    });
                  }
                },
              ),
              const SizedBox(height: 20),

              // Calorie Goal Selection
              Text(
                'Caloric Objective',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF334155),
                    ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: CalorieGoal.values.map((goal) {
                  final isSelected = _selectedGoal == goal;
                  return ChoiceChip(
                    label: Text(
                      goal.displayName,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected ? Colors.white : const Color(0xFF1E293B),
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: AppTheme.primaryNavy,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedGoal = goal;
                        });
                      }
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CustomButton(
                      label: 'Estimate Calories',
                      icon: Icons.local_fire_department_outlined,
                      backgroundColor: AppTheme.secondaryTeal,
                      onPressed: _calculateCalories,
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

  Widget _buildResultsSection(BuildContext context, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 1. Basal Metabolic Rate (BMR) Card
        ResultCard(
          title: 'Basal Metabolic Rate (BMR)',
          value: '${_bmr!.round()}',
          unit: 'kcal / day',
          subtitle: 'Energy expended at complete physical rest using the Mifflin-St Jeor equation '
              '(${_selectedSex.displayName} biological formula).',
          icon: Icons.battery_charging_full_outlined,
          accentColor: AppTheme.primaryNavy,
        ),
        const SizedBox(height: 14),

        // 2. Daily Maintenance Calories (TDEE) Card
        ResultCard(
          title: 'Daily Maintenance Calories (TDEE)',
          value: '${_maintenanceCalories!.round()}',
          unit: 'kcal / day',
          subtitle: 'Estimated energy required to sustain current weight based on '
              '${_selectedActivity.displayName} activity multiplier (${_selectedActivity.multiplier}x).',
          icon: Icons.local_fire_department_outlined,
          accentColor: AppTheme.secondaryTeal,
        ),
        const SizedBox(height: 14),

        // 3. Goal Calorie Target Card (if not pediatric)
        if (!_isPediatric && _goalCalories != null) ...[
          ResultCard(
            title: 'Selected Weight Goal Target',
            value: '${_goalCalories!.round()}',
            unit: 'kcal / day',
            subtitle: 'Illustrative arithmetic adjustment (${_selectedGoal.calorieOffset >= 0 ? "+" : ""}${_selectedGoal.calorieOffset} kcal/day). '
                '${_selectedGoal.description}.',
            icon: Icons.flag_outlined,
            accentColor: AppTheme.primaryBlue,
          ),
          const SizedBox(height: 14),
        ],

        // 4. General Nutrition & Activity Recommendations
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.restaurant_menu_outlined, color: AppTheme.secondaryTeal, size: 22),
                    SizedBox(width: 10),
                    Text(
                      'Nutritional & Metabolic Insights',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...HealthAdvice.getCaloricGuidelines().map(
                  (tip) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.check_circle_outline, color: AppTheme.softGreen, size: 16),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            tip,
                            style: const TextStyle(fontSize: 13, height: 1.4, color: Color(0xFF475569)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 20),
                if (_lastResult != null)
                  CustomButton(
                    label: 'View Complete Health Profile',
                    icon: Icons.assessment_outlined,
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
        ),
      ],
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
          Icon(Icons.info_outline, color: Color(0xFFB45309), size: 20),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Notice: Caloric estimates are mathematical approximations based on the Mifflin-St Jeor formula. '
              'They do not constitute prescribed diets or medical nutritional therapy. Consult a registered dietitian for personalized meal planning.',
              style: TextStyle(fontSize: 12, color: Color(0xFF92400E), height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
