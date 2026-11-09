/// Repository of evidence-based, non-diagnostic wellness insights,
/// health guidance categorized by BMI, SDG 3 mission justifications,
/// and daily practical health tips.
class HealthAdvice {
  /// SDG 3 official project justification statement
  static const String sdg3Justification =
      'VitalTrack supports SDG 3 by helping individuals understand basic health indicators '
      'such as BMI and estimated daily calorie requirements. It promotes health awareness and '
      'encourages balanced nutrition and healthy lifestyle habits.';

  /// Non-diagnostic and non-prescriptive medical disclaimer
  static const String nonDiagnosticDisclaimer =
      'VitalTrack is an academic software tool developed for educational self-awareness '
      'and screening purposes only. Calculations and classifications are mathematical estimates, '
      'not clinical medical diagnoses or personalized dietary prescriptions. Always consult a qualified '
      'physician, registered dietitian, or pediatrician for individualized medical advice.';

  /// Returns general wellness advice based on BMI category.
  /// Uses conditional statements to select appropriate guidance.
  static String getBmiAdvice(String category, {bool isPediatric = false}) {
    if (isPediatric) {
      return 'For children and adolescents under 18, standard adult BMI categories do not apply. '
          'Body composition in youth varies significantly with growth stages, age, and sex. '
          'Please consult a pediatrician or qualified healthcare professional to evaluate growth using pediatric percentiles.';
    }

    final lower = category.toLowerCase();
    if (lower.contains('underweight')) {
      return 'Your BMI falls below the standard adult normal range. Consider focusing on nutrient-dense foods '
          '(nuts, avocados, whole grains, lean proteins), ensuring adequate caloric intake, and consulting '
          'a healthcare provider or registered dietitian to evaluate overall nutritional status safely.';
    } else if (lower.contains('normal')) {
      return 'Your BMI is within the healthy adult range. Continue maintaining balanced dietary patterns, '
          'regular physical activity (at least 150 minutes of moderate activity weekly), restorative sleep, '
          'and routine wellness checkups to support long-term well-being.';
    } else if (lower.contains('overweight')) {
      return 'Your BMI is above the standard healthy range. Prioritize sustainable lifestyle habits including '
          'daily moderate physical activity, whole foods, hydration, and mindful portion sizes. Consider an '
          'individualized wellness assessment with a healthcare professional.';
    } else if (lower.contains('obese') || lower.contains('obesity')) {
      return 'Your BMI indicates obesity classification. Discussing your personal health profile, metabolic '
          'biomarkers, and sustainable lifestyle strategies with a doctor or qualified nutritionist is strongly '
          'recommended to support lifelong health and prevent chronic disease.';
    } else {
      return 'Maintain balanced nutrition, stay physically active, drink adequate water, and consult a qualified healthcare professional for individualized guidance.';
    }
  }

  /// Returns evidence-based daily wellness recommendations for the home dashboard.
  static List<Map<String, dynamic>> getDailyTips() {
    return [
      {
        'title': 'Stay Hydrated Consistently',
        'subtitle': 'Aim for 2 to 3 liters of water daily to support digestion, energy, and cellular function.',
        'icon': 'water_drop_outlined',
        'color': 0xFF0284C7,
      },
      {
        'title': '150 Minutes of Movement',
        'subtitle': 'WHO recommends at least 150 minutes of moderate-intensity aerobic physical activity throughout the week.',
        'icon': 'directions_run_outlined',
        'color': 0xFF10B981,
      },
      {
        'title': 'Prioritize Whole Foods',
        'subtitle': 'Fill your plate with colorful vegetables, fruits, whole grains, and lean protein sources.',
        'icon': 'restaurant_outlined',
        'color': 0xFFF59E0B,
      },
      {
        'title': 'Restorative Sleep Hygiene',
        'subtitle': 'Secure 7 to 9 hours of quality sleep nightly to regulate hunger hormones and metabolic recovery.',
        'icon': 'bedtime_outlined',
        'color': 0xFF6366F1,
      },
      {
        'title': 'Mindful Portion Balance',
        'subtitle': 'Listen to your body\'s natural hunger and satiety cues rather than eating while distracted.',
        'icon': 'self_improvement_outlined',
        'color': 0xFF0D9488,
      },
    ];
  }

  /// General nutrition guidelines for caloric management
  static List<String> getCaloricGuidelines() {
    return [
      'Basal Metabolic Rate (BMR) accounts for ~60-75% of your daily energy expenditure at complete rest.',
      'Daily maintenance calories (TDEE) scale with your physical occupation and exercise routine.',
      'Sustainable weight management aims for modest adjustments (~300 kcal/day) rather than extreme restriction.',
      'Crash dieting lowers metabolic rate and causes muscle loss; prioritize strength training and protein intake.',
    ];
  }
}
