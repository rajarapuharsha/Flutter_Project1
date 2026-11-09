import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bmi_calorie_calculator/app.dart';
import 'package:bmi_calorie_calculator/models/health_result.dart';
import 'package:bmi_calorie_calculator/screens/result_screen.dart';
import 'package:bmi_calorie_calculator/utils/app_theme.dart';

void main() {
  group('VitalTrack Application Integration & Widget Tests', () {
    testWidgets('renders Home Dashboard with VitalTrack branding, tagline, and navigation destinations', (tester) async {
      tester.view.physicalSize = const Size(1280, 1024);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const VitalTrackApp());
      await tester.pumpAndSettle();

      // Verify app title & branding
      expect(find.text('VitalTrack'), findsWidgets);
      expect(find.text('Understand Your Body. Improve Your Lifestyle.'), findsOneWidget);

      // Verify navigation destinations
      expect(find.text('Dashboard'), findsOneWidget);
      expect(find.text('BMI'), findsOneWidget);
      expect(find.text('Calories'), findsOneWidget);
      expect(find.text('All-in-One'), findsOneWidget);

      // Verify feature action cards
      expect(find.text('BMI Calculator'), findsWidgets);
      expect(find.text('Daily Calorie Calculator'), findsWidgets);
    });

    testWidgets('navigates to BMI Screen, executes calculation, displays results and gauge, and resets', (tester) async {
      tester.view.physicalSize = const Size(1280, 1024);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const VitalTrackApp());
      await tester.pumpAndSettle();

      // Tap BMI tab in navigation bar
      await tester.tap(find.text('BMI'));
      await tester.pumpAndSettle();

      // Verify BMI Screen is visible
      expect(find.text('WHO Adult Classification Standard (kg/m²)'), findsOneWidget);
      expect(find.text('Calculate BMI'), findsOneWidget);

      // Enter measurements: Age 25, Height 175, Weight 70
      final ageField = find.widgetWithText(TextFormField, 'Age (years)');
      final heightField = find.widgetWithText(TextFormField, 'Height (cm)');
      final weightField = find.widgetWithText(TextFormField, 'Weight (kg)');

      await tester.enterText(ageField, '25');
      await tester.enterText(heightField, '175');
      await tester.enterText(weightField, '70');
      await tester.pumpAndSettle();

      // Tap Calculate BMI
      await tester.tap(find.text('Calculate BMI'));
      await tester.pumpAndSettle();

      // Verify Result
      expect(find.text('22.9'), findsOneWidget);
      expect(find.text('Normal weight'), findsWidgets);
      expect(find.text('BMI Analysis Result'), findsOneWidget);

      // Tap Clear to reset
      await tester.tap(find.text('Clear'));
      await tester.pumpAndSettle();

      // Result should be cleared
      expect(find.text('BMI Analysis Result'), findsNothing);
    });

    testWidgets('navigates to Calorie Screen, selects parameters, calculates BMR and TDEE', (tester) async {
      tester.view.physicalSize = const Size(1280, 1024);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const VitalTrackApp());
      await tester.pumpAndSettle();

      // Tap Calories tab
      await tester.tap(find.text('Calories'));
      await tester.pumpAndSettle();

      expect(find.text('Mifflin-St Jeor Energy Estimator'), findsOneWidget);

      // Enter Age 25, Height 175, Weight 70
      final ageField = find.widgetWithText(TextFormField, 'Age (years)');
      final heightField = find.widgetWithText(TextFormField, 'Height (cm)');
      final weightField = find.widgetWithText(TextFormField, 'Weight (kg)');

      await tester.enterText(ageField, '25');
      await tester.enterText(heightField, '175');
      await tester.enterText(weightField, '70');
      await tester.pumpAndSettle();

      // Tap Estimate Calories
      await tester.tap(find.text('Estimate Calories'));
      await tester.pumpAndSettle();

      // Verify BMR & TDEE result cards
      expect(find.text('Basal Metabolic Rate (BMR)'), findsOneWidget);
      expect(find.text('1674'), findsOneWidget); // 1673.75 rounded
      expect(find.text('Daily Maintenance Calories (TDEE)'), findsOneWidget);
      expect(find.text('2594'), findsOneWidget); // 1673.75 * 1.55 = 2594.3 rounded
    });

    testWidgets('ResultScreen renders metrics, switches goal dynamically, and provides return navigation', (tester) async {
      tester.view.physicalSize = const Size(1280, 1024);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final testResult = HealthResult(
        age: 26,
        sex: BiologicalSex.male,
        heightCm: 178.0,
        weightKg: 72.0,
        activityLevel: ActivityLevel.moderatelyActive,
        calorieGoal: CalorieGoal.maintain,
        bmi: 22.7,
        bmiCategory: 'Normal weight',
        bmiAdvice: 'Your BMI is within the healthy adult range.',
        bmr: 1700.0,
        maintenanceCalories: 2635.0,
        goalCalories: 2635.0,
        isPediatric: false,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: ResultScreen(result: testResult),
        ),
      );
      await tester.pumpAndSettle();

      // Check header, metrics, and advice
      expect(find.text('VitalTrack Health Summary'), findsOneWidget);
      expect(find.text('22.7'), findsOneWidget);
      expect(find.text('Normal weight'), findsWidgets);
      expect(find.text('1700'), findsOneWidget);
      expect(find.text('2635'), findsWidgets);

      // Check navigation buttons
      expect(find.text('Recalculate / Edit'), findsOneWidget);
      expect(find.text('Return to Dashboard'), findsOneWidget);

      // Tap Gradual Weight Loss chip (-300 kcal)
      await tester.tap(find.text('Gradual Weight Loss'));
      await tester.pumpAndSettle();

      // 2635 - 300 = 2335
      expect(find.text('2335'), findsOneWidget);
    });

    testWidgets('shows About dialog with SDG 3 justification quote when info button is tapped', (tester) async {
      await tester.pumpWidget(const VitalTrackApp());
      await tester.pumpAndSettle();

      // Tap info action in AppBar
      await tester.tap(find.byIcon(Icons.info_outline));
      await tester.pumpAndSettle();

      expect(find.text('About VitalTrack'), findsOneWidget);
      expect(find.textContaining('VitalTrack supports SDG 3'), findsOneWidget);

      // Close dialog
      await tester.tap(find.text('Close'));
      await tester.pumpAndSettle();

      expect(find.text('About VitalTrack'), findsNothing);
    });
  });
}
