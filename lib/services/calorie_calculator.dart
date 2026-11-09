import '../models/health_result.dart';

/// Service responsible for metabolic rate estimations (Mifflin-St Jeor),
/// physical activity multiplier scaling (TDEE), and illustrative goal targets.
class CalorieCalculator {
  /// Calculates Basal Metabolic Rate (BMR) for males using the Mifflin-St Jeor equation:
  /// BMR = (10 * weight in kg) + (6.25 * height in cm) - (5 * age in years) + 5
  static double calculateBMRMale(int age, double weightKg, double heightCm) {
    if (age <= 0 || weightKg <= 0 || heightCm <= 0) {
      throw ArgumentError('Age, weight, and height must all be positive values.');
    }
    return (10 * weightKg) + (6.25 * heightCm) - (5 * age) + 5;
  }

  /// Calculates Basal Metabolic Rate (BMR) for females using the Mifflin-St Jeor equation:
  /// BMR = (10 * weight in kg) + (6.25 * height in cm) - (5 * age in years) - 161
  static double calculateBMRFemale(int age, double weightKg, double heightCm) {
    if (age <= 0 || weightKg <= 0 || heightCm <= 0) {
      throw ArgumentError('Age, weight, and height must all be positive values.');
    }
    return (10 * weightKg) + (6.25 * heightCm) - (5 * age) - 161;
  }

  /// Unified BMR calculation delegating to sex-specific equations.
  static double calculateBMR({
    required int age,
    required BiologicalSex sex,
    required double heightCm,
    required double weightKg,
  }) {
    if (sex == BiologicalSex.male) {
      return calculateBMRMale(age, weightKg, heightCm);
    } else {
      return calculateBMRFemale(age, weightKg, heightCm);
    }
  }

  /// Returns the corresponding physical activity multiplier from the enum.
  static double getActivityMultiplier(ActivityLevel level) {
    return level.multiplier;
  }

  /// Computes estimated total daily maintenance calorie expenditure (TDEE).
  /// Formula: TDEE = BMR * Activity Multiplier
  static double calculateDailyCalories(double bmr, double activityMultiplier) {
    if (bmr <= 0 || activityMultiplier <= 0) {
      throw ArgumentError('BMR and activity multiplier must be positive values.');
    }
    final calories = bmr * activityMultiplier;
    if (!calories.isFinite) {
      throw ArgumentError('Calculated daily calories are not finite.');
    }
    return calories;
  }

  /// Computes the optional illustrative goal calorie estimate.
  /// Adjusts maintenance calories by the goal offset (-300 for loss, +300 for gain, 0 for maintain).
  /// Returns null if user is under 18 or if the target is unfeasibly low (< 500 kcal/day).
  static double? calculateGoalCalories({
    required double maintenanceCalories,
    required CalorieGoal goal,
    required bool isPediatric,
  }) {
    if (isPediatric) {
      return null;
    }

    final target = maintenanceCalories + goal.calorieOffset;
    if (target < 500 || !target.isFinite) {
      return null;
    }
    return target;
  }
}
