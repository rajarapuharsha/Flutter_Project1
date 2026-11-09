import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

/// Represents biological sex options required for the Mifflin-St Jeor estimation formula.
enum BiologicalSex {
  male,
  female;

  String get displayName => this == BiologicalSex.male ? 'Male' : 'Female';
}

/// Represents the physical activity level classifications with their Mifflin-St Jeor multipliers.
enum ActivityLevel {
  sedentary(1.2, 'Sedentary', 'Little or no exercise, desk job'),
  lightlyActive(1.375, 'Lightly Active', 'Light exercise or sports 1-3 days/week'),
  moderatelyActive(1.55, 'Moderately Active', 'Moderate exercise or sports 3-5 days/week'),
  veryActive(1.725, 'Very Active', 'Hard exercise or sports 6-7 days/week'),
  extraActive(1.9, 'Extra Active', 'Very hard exercise, physical job, or 2x training');

  final double multiplier;
  final String displayName;
  final String description;

  const ActivityLevel(this.multiplier, this.displayName, this.description);
}

/// Represents weight management calorie goals with their daily caloric adjustments.
enum CalorieGoal {
  maintain(0, 'Maintain Weight', 'Energy intake balances expenditure to sustain current weight'),
  gradualLoss(-300, 'Gradual Weight Loss', 'Modest deficit of ~300 kcal/day for sustainable reduction'),
  gradualGain(300, 'Gradual Weight Gain', 'Modest surplus of ~300 kcal/day for gradual lean mass gain');

  final int calorieOffset;
  final String displayName;
  final String description;

  const CalorieGoal(this.calorieOffset, this.displayName, this.description);
}

/// Structured immutable model holding calculation inputs, derived values,
/// classifications, and personalized wellness recommendations for VitalTrack.
class HealthResult {
  final int age;
  final BiologicalSex sex;
  final double heightCm;
  final double weightKg;
  final ActivityLevel activityLevel;
  final CalorieGoal calorieGoal;

  final double bmi;
  final String bmiCategory;
  final String bmiAdvice;

  final double bmr;
  final double maintenanceCalories;
  final double? goalCalories;

  final bool isPediatric;
  final String? safetyNotice;
  final DateTime calculatedAt;

  HealthResult({
    required this.age,
    required this.sex,
    required this.heightCm,
    required this.weightKg,
    required this.activityLevel,
    required this.calorieGoal,
    required this.bmi,
    required this.bmiCategory,
    required this.bmiAdvice,
    required this.bmr,
    required this.maintenanceCalories,
    this.goalCalories,
    required this.isPediatric,
    this.safetyNotice,
    DateTime? calculatedAt,
  }) : calculatedAt = calculatedAt ?? DateTime.now();

  /// BMI rounded to one decimal place for presentation
  String get bmiDisplay => bmi.toStringAsFixed(1);

  /// BMR rounded to the nearest whole integer
  int get bmrDisplay => bmr.round();

  /// Maintenance calories rounded to the nearest whole integer
  int get maintenanceCaloriesDisplay => maintenanceCalories.round();

  /// Goal calories rounded to the nearest whole integer if applicable
  int? get goalCaloriesDisplay => goalCalories?.round();

  /// Returns the corresponding semantic color for this result's BMI category
  Color get categoryColor => AppTheme.getColorForCategory(bmiCategory);

  /// Creates a copy of this result with an updated calorie goal without re-entering form data
  HealthResult copyWithGoal(CalorieGoal newGoal) {
    double? updatedGoalCalories;
    if (!isPediatric) {
      final calculated = maintenanceCalories + newGoal.calorieOffset;
      if (calculated >= 500) {
        updatedGoalCalories = calculated;
      }
    }

    return HealthResult(
      age: age,
      sex: sex,
      heightCm: heightCm,
      weightKg: weightKg,
      activityLevel: activityLevel,
      calorieGoal: newGoal,
      bmi: bmi,
      bmiCategory: bmiCategory,
      bmiAdvice: bmiAdvice,
      bmr: bmr,
      maintenanceCalories: maintenanceCalories,
      goalCalories: updatedGoalCalories,
      isPediatric: isPediatric,
      safetyNotice: safetyNotice,
      calculatedAt: calculatedAt,
    );
  }
}
