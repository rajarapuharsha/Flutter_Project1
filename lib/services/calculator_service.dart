import '../models/health_result.dart';
import '../utils/health_advice.dart';
import 'bmi_calculator.dart';
import 'calorie_calculator.dart';

/// Unified calculation facade orchestrating BMI and metabolic rate services
/// into an immutable [HealthResult].
class CalculatorService {
  /// Calculates Body Mass Index (BMI).
  static double calculateBMI(double weightKg, double heightCm) {
    return BmiCalculator.calculateBMI(weightKg, heightCm);
  }

  /// Classifies adult BMI into standard WHO categories.
  static String getBMICategory(double bmi) {
    return BmiCalculator.classifyCategory(bmi);
  }

  /// Provides non-diagnostic lifestyle guidance based on BMI classification.
  static String getBMIAdvice(double bmi, {bool isPediatric = false}) {
    final category = isPediatric ? 'Pediatric (<18 yrs)' : getBMICategory(bmi);
    return HealthAdvice.getBmiAdvice(category, isPediatric: isPediatric);
  }

  /// Calculates Basal Metabolic Rate (BMR) for males.
  static double calculateBMRMale(int age, double weightKg, double heightCm) {
    return CalorieCalculator.calculateBMRMale(age, weightKg, heightCm);
  }

  /// Calculates Basal Metabolic Rate (BMR) for females.
  static double calculateBMRFemale(int age, double weightKg, double heightCm) {
    return CalorieCalculator.calculateBMRFemale(age, weightKg, heightCm);
  }

  /// Returns physical activity multiplier.
  static double getActivityMultiplier(ActivityLevel level) {
    return CalorieCalculator.getActivityMultiplier(level);
  }

  /// Computes estimated total daily maintenance calorie expenditure (TDEE).
  static double calculateDailyCalories(double bmr, double activityMultiplier) {
    return CalorieCalculator.calculateDailyCalories(bmr, activityMultiplier);
  }

  /// Computes the optional illustrative goal calorie estimate.
  static double? calculateGoalCalories({
    required double maintenanceCalories,
    required CalorieGoal goal,
    required bool isPediatric,
  }) {
    return CalorieCalculator.calculateGoalCalories(
      maintenanceCalories: maintenanceCalories,
      goal: goal,
      isPediatric: isPediatric,
    );
  }

  /// Orchestrates full calculation workflow and returns an immutable [HealthResult].
  static HealthResult calculateAll({
    required int age,
    required BiologicalSex sex,
    required double heightCm,
    required double weightKg,
    required ActivityLevel activityLevel,
    required CalorieGoal calorieGoal,
  }) {
    final isPediatric = age < 18;

    // 1. BMI Calculation
    final bmi = calculateBMI(weightKg, heightCm);

    // 2. Category & Advice
    final bmiCategory = BmiCalculator.classifyCategory(bmi, age: age);
    final bmiAdvice = getBMIAdvice(bmi, isPediatric: isPediatric);

    // 3. BMR Calculation (Mifflin-St Jeor)
    final bmr = CalorieCalculator.calculateBMR(
      age: age,
      sex: sex,
      heightCm: heightCm,
      weightKg: weightKg,
    );

    // 4. Daily Maintenance Calories
    final multiplier = getActivityMultiplier(activityLevel);
    final maintenance = calculateDailyCalories(bmr, multiplier);

    // 5. Calorie Goal Estimation
    final goalCalories = calculateGoalCalories(
      maintenanceCalories: maintenance,
      goal: calorieGoal,
      isPediatric: isPediatric,
    );

    // 6. Safety Notice
    String? safetyNotice;
    if (isPediatric) {
      safetyNotice = 'Note: Age is under 18 years. Caloric and BMI assessments are illustrative only. '
          'Pediatric nutrition and growth tracking require professional medical consultation.';
    }

    return HealthResult(
      age: age,
      sex: sex,
      heightCm: heightCm,
      weightKg: weightKg,
      activityLevel: activityLevel,
      calorieGoal: calorieGoal,
      bmi: bmi,
      bmiCategory: bmiCategory,
      bmiAdvice: bmiAdvice,
      bmr: bmr,
      maintenanceCalories: maintenance,
      goalCalories: goalCalories,
      isPediatric: isPediatric,
      safetyNotice: safetyNotice,
    );
  }
}
