import 'package:flutter_test/flutter_test.dart';
import 'package:bmi_calorie_calculator/services/bmi_calculator.dart';

void main() {
  group('BmiCalculator - Mathematical Verification & Boundaries', () {
    test('calculates correct BMI for known weight (70kg) and height (175cm)', () {
      // 70 / (1.75 * 1.75) = 22.857142857142858
      final bmi = BmiCalculator.calculateBMI(70, 175);
      expect(bmi, closeTo(22.857, 0.001));
    });

    test('calculates correct BMI with decimal inputs', () {
      // 64.5 / (1.68 * 1.68) = 22.85289...
      final bmi = BmiCalculator.calculateBMI(64.5, 168.0);
      expect(bmi, closeTo(22.85, 0.01));
    });

    test('classifies Underweight correctly below 18.5', () {
      expect(BmiCalculator.classifyCategory(18.49), 'Underweight');
      expect(BmiCalculator.classifyCategory(16.0), 'Underweight');
      expect(BmiCalculator.classifyCategory(12.0), 'Underweight');
    });

    test('classifies Normal weight boundary at 18.5 up to 24.99', () {
      expect(BmiCalculator.classifyCategory(18.5), 'Normal weight');
      expect(BmiCalculator.classifyCategory(21.7), 'Normal weight');
      expect(BmiCalculator.classifyCategory(24.99), 'Normal weight');
    });

    test('classifies Overweight boundary at 25.0 up to 29.99', () {
      expect(BmiCalculator.classifyCategory(25.0), 'Overweight');
      expect(BmiCalculator.classifyCategory(27.4), 'Overweight');
      expect(BmiCalculator.classifyCategory(29.99), 'Overweight');
    });

    test('classifies Obesity boundary at 30.0 and above', () {
      expect(BmiCalculator.classifyCategory(30.0), 'Obesity');
      expect(BmiCalculator.classifyCategory(35.5), 'Obesity');
      expect(BmiCalculator.classifyCategory(45.0), 'Obesity');
    });

    test('flags pediatric users under 18 years of age', () {
      expect(BmiCalculator.classifyCategory(22.0, age: 14), 'Pediatric (<18 yrs)');
      expect(BmiCalculator.classifyCategory(28.0, age: 17), 'Pediatric (<18 yrs)');
      expect(BmiCalculator.classifyCategory(22.0, age: 18), 'Normal weight');
    });

    test('throws ArgumentError on zero or negative height', () {
      expect(() => BmiCalculator.calculateBMI(70, 0), throwsArgumentError);
      expect(() => BmiCalculator.calculateBMI(70, -170), throwsArgumentError);
    });

    test('throws ArgumentError on zero or negative weight', () {
      expect(() => BmiCalculator.calculateBMI(0, 175), throwsArgumentError);
      expect(() => BmiCalculator.calculateBMI(-65, 175), throwsArgumentError);
    });

    test('calculates correct healthy weight boundaries for stature', () {
      // For height 175cm: min = 18.5 * 1.75^2 = 56.656 kg, max = 24.9 * 1.75^2 = 76.256 kg
      final minWeight = BmiCalculator.getMinHealthyWeight(175);
      final maxWeight = BmiCalculator.getMaxHealthyWeight(175);
      expect(minWeight, closeTo(56.65, 0.01));
      expect(maxWeight, closeTo(76.25, 0.01));
    });

    test('calculates BMI Prime correctly (ratio to 25.0)', () {
      // 25.0 / 25.0 = 1.0
      expect(BmiCalculator.calculateBmiPrime(25.0), equals(1.0));
      // 20.0 / 25.0 = 0.8
      expect(BmiCalculator.calculateBmiPrime(20.0), equals(0.8));
    });
  });
}
