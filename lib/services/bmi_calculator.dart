/// Service responsible for Body Mass Index (BMI) calculations,
/// WHO category classifications, and healthy weight range estimations.
class BmiCalculator {
  /// Calculates Body Mass Index (BMI) using the standard metric formula:
  /// BMI = weight (kg) / [height (m)]^2
  /// Throws [ArgumentError] if height or weight are non-positive.
  static double calculateBMI(double weightKg, double heightCm) {
    if (heightCm <= 0) {
      throw ArgumentError('Height must be greater than zero.');
    }
    if (weightKg <= 0) {
      throw ArgumentError('Weight must be greater than zero.');
    }

    final heightM = heightCm / 100.0;
    final bmi = weightKg / (heightM * heightM);

    if (!bmi.isFinite) {
      throw ArgumentError('Calculated BMI is not a finite number.');
    }
    return bmi;
  }

  /// Classifies BMI into standard World Health Organization categories.
  /// If [age] is supplied and is under 18, returns a pediatric designation
  /// because adult cutoffs do not apply to developing adolescents.
  static String classifyCategory(double bmi, {int? age}) {
    if (age != null && age < 18) {
      return 'Pediatric (<18 yrs)';
    }

    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi < 25.0) {
      return 'Normal weight';
    } else if (bmi < 30.0) {
      return 'Overweight';
    } else {
      return 'Obesity';
    }
  }

  /// Calculates the lower boundary of normal healthy weight in kilograms for a given stature.
  /// Healthy BMI minimum = 18.5 kg/m²
  static double getMinHealthyWeight(double heightCm) {
    if (heightCm <= 0) return 0.0;
    final heightM = heightCm / 100.0;
    return 18.5 * (heightM * heightM);
  }

  /// Calculates the upper boundary of normal healthy weight in kilograms for a given stature.
  /// Healthy BMI maximum = 24.9 kg/m²
  static double getMaxHealthyWeight(double heightCm) {
    if (heightCm <= 0) return 0.0;
    final heightM = heightCm / 100.0;
    return 24.9 * (heightM * heightM);
  }

  /// Calculates BMI Prime, a dimensionless ratio comparing actual BMI to the upper limit of normal weight (25.0).
  /// BMI Prime < 0.74: Underweight, 0.74 - 1.0: Normal, 1.0 - 1.2: Overweight, > 1.2: Obese.
  static double calculateBmiPrime(double bmi) {
    return bmi / 25.0;
  }
}
