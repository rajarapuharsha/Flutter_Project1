import 'package:flutter_test/flutter_test.dart';
import 'package:bmi_calorie_calculator/models/health_result.dart';
import 'package:bmi_calorie_calculator/services/calorie_calculator.dart';

void main() {
  group('CalorieCalculator - Mifflin-St Jeor & TDEE Multipliers', () {
    test('calculates male BMR mathematically according to equation', () {
      // Male: (10 * 70) + (6.25 * 175) - (5 * 25) + 5
      // = 700 + 1093.75 - 125 + 5 = 1673.75
      final bmr = CalorieCalculator.calculateBMRMale(25, 70, 175);
      expect(bmr, equals(1673.75));
    });

    test('calculates female BMR mathematically according to equation', () {
      // Female: (10 * 70) + (6.25 * 175) - (5 * 25) - 161
      // = 700 + 1093.75 - 125 - 161 = 1507.75
      final bmr = CalorieCalculator.calculateBMRFemale(25, 70, 175);
      expect(bmr, equals(1507.75));
    });

    test('unified calculateBMR respects BiologicalSex selection', () {
      final maleBmr = CalorieCalculator.calculateBMR(
        age: 30,
        sex: BiologicalSex.male,
        heightCm: 180,
        weightKg: 80,
      );
      final femaleBmr = CalorieCalculator.calculateBMR(
        age: 30,
        sex: BiologicalSex.female,
        heightCm: 180,
        weightKg: 80,
      );

      // Male BMR has +5 while female has -161, diff is 166
      expect(maleBmr - femaleBmr, equals(166.0));
    });

    test('throws ArgumentError for invalid BMR inputs', () {
      expect(() => CalorieCalculator.calculateBMRMale(0, 70, 175), throwsArgumentError);
      expect(() => CalorieCalculator.calculateBMRMale(25, 0, 175), throwsArgumentError);
      expect(() => CalorieCalculator.calculateBMRMale(25, 70, 0), throwsArgumentError);
      expect(() => CalorieCalculator.calculateBMRFemale(-1, 60, 160), throwsArgumentError);
    });

    test('returns exact activity multipliers for all 5 tiers', () {
      expect(CalorieCalculator.getActivityMultiplier(ActivityLevel.sedentary), equals(1.2));
      expect(CalorieCalculator.getActivityMultiplier(ActivityLevel.lightlyActive), equals(1.375));
      expect(CalorieCalculator.getActivityMultiplier(ActivityLevel.moderatelyActive), equals(1.55));
      expect(CalorieCalculator.getActivityMultiplier(ActivityLevel.veryActive), equals(1.725));
      expect(CalorieCalculator.getActivityMultiplier(ActivityLevel.extraActive), equals(1.9));
    });

    test('calculates daily maintenance calories (TDEE = BMR * Multiplier)', () {
      const bmr = 1600.0;
      final tdee = CalorieCalculator.calculateDailyCalories(bmr, 1.55);
      expect(tdee, equals(2480.0));
    });

    test('throws ArgumentError for non-positive BMR or multiplier', () {
      expect(() => CalorieCalculator.calculateDailyCalories(0, 1.2), throwsArgumentError);
      expect(() => CalorieCalculator.calculateDailyCalories(1500, 0), throwsArgumentError);
      expect(() => CalorieCalculator.calculateDailyCalories(-1500, 1.5), throwsArgumentError);
    });

    test('calculates goal calories for adults (+/- 300 kcal/day)', () {
      const maintenance = 2400.0;

      final maintain = CalorieCalculator.calculateGoalCalories(
        maintenanceCalories: maintenance,
        goal: CalorieGoal.maintain,
        isPediatric: false,
      );
      expect(maintain, equals(2400.0));

      final loss = CalorieCalculator.calculateGoalCalories(
        maintenanceCalories: maintenance,
        goal: CalorieGoal.gradualLoss,
        isPediatric: false,
      );
      expect(loss, equals(2100.0));

      final gain = CalorieCalculator.calculateGoalCalories(
        maintenanceCalories: maintenance,
        goal: CalorieGoal.gradualGain,
        isPediatric: false,
      );
      expect(gain, equals(2700.0));
    });

    test('suppresses goal calories for pediatric users (<18 yrs)', () {
      final pediatricGoal = CalorieCalculator.calculateGoalCalories(
        maintenanceCalories: 2200.0,
        goal: CalorieGoal.gradualLoss,
        isPediatric: true,
      );
      expect(pediatricGoal, isNull);
    });

    test('suppresses goal calories if result drops below 500 kcal/day', () {
      final unfeasibleGoal = CalorieCalculator.calculateGoalCalories(
        maintenanceCalories: 600.0,
        goal: CalorieGoal.gradualLoss, // 600 - 300 = 300 < 500
        isPediatric: false,
      );
      expect(unfeasibleGoal, isNull);
    });
  });
}
