import 'package:flutter/material.dart';
import '../models/health_result.dart';
import '../utils/app_theme.dart';
import '../utils/health_advice.dart';
import '../widgets/custom_button.dart';
import '../widgets/health_indicator.dart';
import '../widgets/result_card.dart';

/// Comprehensive Results Screen displaying all calculated metrics:
/// BMI score, WHO category, visual indicator, BMR, daily maintenance calories (TDEE),
/// interactive weight goal switcher, personalized wellness advice, and navigation actions.
class ResultScreen extends StatefulWidget {
  final HealthResult result;

  const ResultScreen({
    super.key,
    required this.result,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late HealthResult _currentResult;
  bool _useCircularGauge = false;

  @override
  void initState() {
    super.initState();
    _currentResult = widget.result;
  }

  void _onGoalChanged(CalorieGoal newGoal) {
    setState(() {
      _currentResult = _currentResult.copyWithGoal(newGoal);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final res = _currentResult;
    final categoryColor = res.categoryColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Health Profile'),
        actions: [
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 750),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top Hero Summary
                _buildHeroCard(context, res, categoryColor, isDark),
                const SizedBox(height: 20),

                // Pediatric Safety Notice Banner if under 18
                if (res.isPediatric) ...[
                  _buildPediatricAlert(),
                  const SizedBox(height: 18),
                ],

                // 1. Body Mass Index (BMI) Card & Indicator
                ResultCard(
                  title: 'Body Mass Index (BMI)',
                  value: res.bmiDisplay,
                  unit: 'kg/m²',
                  subtitle: res.isPediatric
                      ? 'Pediatric screening (requires age-and-sex specific growth charts)'
                      : 'World Health Organization (WHO) adult standard',
                  accentColor: categoryColor,
                  icon: Icons.monitor_weight_outlined,
                  trailingBadge: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: categoryColor.withOpacity(0.14),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: categoryColor, width: 1.5),
                    ),
                    child: Text(
                      res.bmiCategory,
                      style: TextStyle(
                        color: categoryColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  child: HealthIndicator(
                    bmi: res.bmi,
                    category: res.bmiCategory,
                    isPediatric: res.isPediatric,
                    isCircular: _useCircularGauge,
                  ),
                ),
                const SizedBox(height: 16),

                // 2. Basal Metabolic Rate (BMR) Card
                ResultCard(
                  title: 'Basal Metabolic Rate (BMR)',
                  value: '${res.bmrDisplay}',
                  unit: 'kcal / day',
                  subtitle: 'Calculated using the Mifflin-St Jeor equation (${res.sex.displayName} parameters). '
                      'Represents baseline energy expended at complete physical rest.',
                  icon: Icons.battery_charging_full_outlined,
                  accentColor: AppTheme.primaryNavy,
                ),
                const SizedBox(height: 16),

                // 3. Maintenance Calories (TDEE) Card
                ResultCard(
                  title: 'Daily Maintenance Calories (TDEE)',
                  value: '${res.maintenanceCaloriesDisplay}',
                  unit: 'kcal / day',
                  subtitle: 'Energy required to maintain current body weight based on '
                      '${res.activityLevel.displayName} activity factor (${res.activityLevel.multiplier}x).',
                  icon: Icons.local_fire_department_outlined,
                  accentColor: AppTheme.secondaryTeal,
                ),
                const SizedBox(height: 16),

                // 4. Weight Goal Target Card (Dynamic Switcher)
                if (!res.isPediatric && res.goalCaloriesDisplay != null) ...[
                  ResultCard(
                    title: 'Weight Objective Caloric Target',
                    value: '${res.goalCaloriesDisplay}',
                    unit: 'kcal / day',
                    subtitle: 'Illustrative arithmetic adjustment (${res.calorieGoal.calorieOffset >= 0 ? "+" : ""}${res.calorieGoal.calorieOffset} kcal/day). '
                        '${res.calorieGoal.description}.',
                    icon: Icons.flag_outlined,
                    accentColor: AppTheme.primaryBlue,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Switch Target Objective:',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF64748B)),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: CalorieGoal.values.map((goal) {
                            final isSelected = res.calorieGoal == goal;
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
                                  _onGoalChanged(goal);
                                }
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // 5. Personalized Wellness Recommendations
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppTheme.softGreen.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.tips_and_updates_outlined, color: AppTheme.softGreen, size: 22),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Personalized Wellness Guidance',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Text(
                          res.bmiAdvice,
                          style: TextStyle(
                            fontSize: 13.5,
                            height: 1.5,
                            color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF334155),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Divider(),
                        const SizedBox(height: 12),
                        const Text(
                          'SDG 3 Healthy Living Pillars:',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.secondaryTeal,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          '• Whole-food nutrition: Prioritize lean proteins, complex fiber, and colorful produce.\n'
                          '• Hydration: Drink 2 to 3 liters of water daily.\n'
                          '• Physical activity: Complete at least 150 minutes of moderate aerobic exercise weekly.\n'
                          '• Sleep hygiene: Secure 7 to 9 hours of restorative sleep nightly.',
                          style: TextStyle(fontSize: 12.5, height: 1.5, color: Color(0xFF64748B)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // UN SDG 3 Justification Card
                _buildSdgCard(),
                const SizedBox(height: 24),

                // Bottom Action Buttons: Recalculate & Return to Dashboard
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        label: 'Recalculate / Edit',
                        icon: Icons.edit_outlined,
                        isOutlined: true,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: CustomButton(
                        label: 'Return to Dashboard',
                        icon: Icons.home_outlined,
                        backgroundColor: AppTheme.primaryNavy,
                        onPressed: () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroCard(BuildContext context, HealthResult res, Color categoryColor, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF1E293B), const Color(0xFF0F172A)]
              : [AppTheme.primaryNavy, const Color(0xFF1E3A8A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryNavy.withOpacity(0.25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.favorite, color: Color(0xFF38BDF8), size: 24),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'VitalTrack Health Summary',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'Understand Your Body. Improve Your Lifestyle.',
                        style: TextStyle(
                          color: Color(0xFF93C5FD),
                          fontSize: 11.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${res.age} yrs • ${res.sex.displayName}',
                  style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMetricPill('Height', '${res.heightCm.toStringAsFixed(1)} cm'),
              _buildMetricPill('Weight', '${res.weightKg.toStringAsFixed(1)} kg'),
              _buildMetricPill('Activity', res.activityLevel.displayName),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricPill(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  Widget _buildPediatricAlert() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F3FF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFDDD6FE)),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.child_care, color: Color(0xFF7C3AED), size: 24),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Pediatric Notice: User is under 18 years old. Adult BMI and caloric formulas do not apply directly. '
              'Adolescent body composition requires growth percentile assessment by a pediatrician.',
              style: TextStyle(fontSize: 12.5, color: Color(0xFF5B21B6), height: 1.45, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSdgCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFECFDF5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFA7F3D0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.secondaryTeal,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.public, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 10),
              const Text(
                'UN Sustainable Development Goal 3',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF065F46),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            HealthAdvice.sdg3Justification,
            style: TextStyle(fontSize: 12.5, color: Color(0xFF064E3B), height: 1.45),
          ),
        ],
      ),
    );
  }
}
