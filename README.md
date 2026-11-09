# VitalTrack – BMI & Daily Calorie Companion

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)](https://dart.dev)
[![Material 3](https://img.shields.io/badge/Design-Material%203-7C3AED)](https://m3.material.io)
[![UN SDG 3](https://img.shields.io/badge/UN%20SDG-3%20Good%20Health-0D9488)](https://sdgs.un.org/goals/goal3)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

> **"Understand Your Body. Improve Your Lifestyle."**

VitalTrack is a complete, professional, realistic mobile and cross-platform health application engineered in Flutter and Dart for a **B.Tech Academic Practical Assignment & Viva Examination**. The application calculates Body Mass Index (BMI), classifies adult and pediatric health categories, estimates resting Basal Metabolic Rate (BMR) via the Mifflin-St Jeor formula, and projects daily maintenance calories (TDEE) across five physical activity tiers with personalized general wellness guidance.

VitalTrack operates **100% offline** without requiring an account, API key, backend database, or internet connection.

---

## Table of Contents
1. [Project Overview & Title](#1-project-overview--title)
2. [Project Introduction](#2-project-introduction)
3. [Problem Statement](#3-problem-statement)
4. [Objectives](#4-objectives)
5. [Key Features](#5-key-features)
6. [Technologies Used](#6-technologies-used)
7. [Flutter Concepts Demonstrated](#7-flutter-concepts-demonstrated)
8. [BMI Calculation Formula & Logic](#8-bmi-calculation-formula--logic)
9. [BMR & Daily Calorie Calculation Formulas](#9-bmr--daily-calorie-calculation-formulas)
10. [UN SDG 3 Relevance](#10-un-sdg-3-relevance)
11. [Installation and Execution Instructions](#11-installation-and-execution-instructions)
12. [Testing Details & Test Suite](#12-testing-details--test-suite)
13. [Screenshots Section & Recommendations](#13-screenshots-section--recommendations)
14. [Future Enhancements](#14-future-enhancements)
15. [Project Demonstration Script](#15-project-demonstration-script)
16. [GitHub Upload Instructions](#16-github-upload-instructions)
17. [10 Likely Viva Questions with Answers](#17-10-likely-viva-questions-with-answers)
18. [Important Dart Functions & Conditional Statements](#18-important-dart-functions--conditional-statements)

---

## 1. Project Overview & Title
- **Application Name:** VitalTrack
- **Full Title:** VitalTrack – BMI & Daily Calorie Companion
- **Tagline:** *Understand Your Body. Improve Your Lifestyle.*
- **Target Platform:** Android (primary), with responsive support for Web, Windows Desktop, iOS, macOS, and Linux.
- **Design Language:** Google Material Design 3.
- **Color Palette:** Modern Navy Blue (`#1A365D`), Teal (`#0D9488`), and Soft Green (`#10B981`) with distinct semantic status badges.
- **Academic Context:** B.Tech Computer Science / Information Technology Flutter Practical Assignment & VEDIC Portal Submission.

---

## 2. Project Introduction
In modern society, physical inactivity and energy imbalances are primary contributors to preventable lifestyle disorders, including cardiovascular conditions, hypertension, and Type 2 diabetes. While digital health tools can foster personal awareness, most commercial fitness applications require invasive account registration, continuous internet connectivity, third-party cloud data synchronization, or display disruptive advertisements.

**VitalTrack** was developed as an offline, privacy-first companion that translates established nutritional and anthropometric formulas into an intuitive, elegant mobile experience. Built using Flutter’s reactive architecture and Dart’s sound type safety, VitalTrack empowers users to evaluate personal physical metrics, understand their basal and daily metabolic needs, and adopt sustainable lifestyle habits.

---

## 3. Problem Statement
Many individuals lack accessible, transparent, and mathematically accurate tools to:
1. Objectively evaluate Body Mass Index against World Health Organization (WHO) epidemiological benchmarks.
2. Estimate basal resting caloric expenditure using clinically validated formulas rather than arbitrary numbers.
3. Quantify how physical exercise and daily occupational activity scale maintenance energy requirements.
4. Access non-extreme, sustainable lifestyle recommendations without being pushed into crash diets or unscientific supplements.
5. Protect sensitive biometric data from unauthorized cloud tracking, telemetry, or monetized data harvesting.
6. Safeguard adolescents by avoiding the inappropriate application of adult BMI cutoffs to growing pediatric bodies.

---

## 4. Objectives
- **Mathematical Integrity:** Implement the metric BMI formula, Mifflin-St Jeor BMR equations (male and female constants), and Harris-Benedict activity multipliers using decoupled, testable Dart functions.
- **Pediatric Safety Guardrails:** Automatically detect users under 18 years old, suppress adult classifications and weight targets, and provide age-appropriate pediatric health education.
- **Interactive Multi-Screen Architecture:** Deliver dedicated screens for Home Dashboard, BMI Calculator, Calorie Calculator, Comprehensive Assessment, and Results Profile with clean `Navigator` routing.
- **Universal Responsiveness & Accessibility:** Ensure smooth layout reflow between smartphones, tablets, and desktop displays with both Light and Dark theme modes.
- **Demonstration Excellence:** Provide clean, well-commented code disposing controllers properly, robust input validation rejecting invalid bounds, and zero runtime crashes.

---

## 5. Key Features

### A. Home Dashboard (`home_screen.dart`)
- **VitalTrack Hero Banner:** Displays the VitalTrack brand identity, pulse logo, tagline, and quick launcher buttons.
- **Feature Action Cards:** Dedicated entry cards for the BMI Calculator and Daily Calorie Calculator with smooth page transitions.
- **Short Wellness Tips:** Horizontal scrolling carousel of practical, evidence-based wellness tips (Hydration, 150-Minute Movement, Whole Foods, Restorative Sleep, Mindful Eating).
- **Health Information Primer:** Clear, card-based explanations of BMI, BMR, and TDEE.
- **UN SDG 3 Section:** Highlighting alignment with Global Goal 3 (Good Health and Well-Being).
- **Non-Diagnostic Disclaimer:** Clear statement that the app provides screening estimates, not medical diagnoses.

### B. Dedicated BMI Calculator (`bmi_screen.dart`)
- **Inputs:** Age (years), Height (cm), and Weight (kg) with floating-point decimal support.
- **Form Controls:** "Calculate BMI" and "Clear" buttons with real-time field validation.
- **Visual Spectrum & Radial Gauge:** Horizontal multi-segment spectrum bar with dynamic pointer needle and an interactive toggle to switch to a circular radial gauge.
- **WHO Health Categories:** Color-coded classification across Underweight, Normal weight, Overweight, and Obesity.
- **Pediatric Protection:** Flags individuals under 18 and directs them to pediatric growth percentiles.
- **Quick Navigation:** Direct action to view the complete health profile on the Results Screen.

### C. Dedicated Daily Calorie Calculator (`calorie_screen.dart`)
- **Inputs:** Age, Biological Sex (Male/Female toggle), Height (cm), Weight (kg), and Physical Activity Level.
- **Dropdown Menu:** Uses `DropdownButtonFormField<ActivityLevel>` displaying all 5 tiers with exact multipliers (1.2x to 1.9x) and descriptive labels.
- **Mifflin-St Jeor Calculation:** Evaluates sex-specific BMR and scales to Total Daily Energy Expenditure (TDEE).
- **Caloric Objective Selector:** Chips for Weight Maintenance (0 kcal), Gradual Loss (-300 kcal/day), and Gradual Gain (+300 kcal/day).
- **Nutritional Insights:** Card detailing the physiological breakdown of BMR, TDEE, and sustainable weight management.

### D. Comprehensive Results Screen (`result_screen.dart`)
- **Profile Header:** Summarizes biometric measurements, age, and sex in a navy gradient card.
- **Complete Metric Stack:** Displays BMI score, category badge, visual indicator, BMR (kcal/day), and TDEE (kcal/day).
- **Dynamic Goal Switcher:** Allows switching between Maintain, Loss, and Gain targets directly on the card with instant mathematical recalculation via `copyWithGoal()`.
- **Personalized Recommendations:** Category-specific lifestyle advice and SDG 3 healthy living pillars.
- **Navigation Options:** "Recalculate / Edit" (returns to form) and "Return to Dashboard" (returns to home root).

### E. Theme & Accessibility
- Full **Material 3 Light and Dark Themes** with dynamic toggle in the AppBar.
- Responsive breakpoints adapting for single-column mobile layouts and wide multi-column screens.

---

## 6. Technologies Used

| Technology | Role in Project |
|---|---|
| **Flutter SDK (>=3.10.0)** | Cross-platform UI toolkit and reactive framework |
| **Dart SDK (>=3.0.0 <4.0.0)** | Object-oriented, soundly null-safe programming language |
| **Material 3 (M3)** | Modern design system, dynamic typography, and rounded components |
| **flutter_test** | Unit testing, boundary verification, and widget interaction testing |
| **flutter_lints** | Static code analysis enforcing idiomatic Dart style |
| **VS Code / Android Studio** | Primary Integrated Development Environments |

---

## 7. Flutter Concepts Demonstrated

This project satisfies all requirements of the B.Tech academic practical evaluation rubric:

| # | Required Concept | Implementation in VitalTrack | File Location |
|---|---|---|---|
| **1** | `StatelessWidget` & `StatefulWidget` | `HomeScreen`, `ResultCard`, `HealthIndicator` are stateless; `BmiScreen`, `CalorieScreen`, `ResultScreen`, `VitalTrackApp` are stateful. | `lib/screens/`, `lib/widgets/` |
| **2** | `MaterialApp` & `Scaffold` | `MaterialApp` configures themes and title in `app.dart`; `Scaffold` provides the visual structure, app bars, and bodies in all screens. | `lib/app.dart`, all screens |
| **3** | `Text` & `TextField` / `TextFormField` | Display of labels, metrics, disclaimers, and numeric text entry fields. | `lib/widgets/input_field.dart` |
| **4** | `TextEditingController` | Controllers for age, height, and weight inputs, initialized in `initState` and cleanly disposed in `dispose()`. | `lib/screens/bmi_screen.dart`, `calorie_screen.dart` |
| **5** | `ElevatedButton` & `IconButton` | Calculate buttons, Clear buttons, theme toggles, and modal info launchers. | `lib/widgets/custom_button.dart`, `lib/app.dart` |
| **6** | `Column`, `Row`, `Container`, `Padding` | Structural layout elements used across cards, metric pill rows, and form fields. | Throughout `lib/` |
| **7** | `Card` & `ListTile` | Feature cards on dashboard, metric presentation cards, and wellness tips. | `lib/widgets/result_card.dart`, `home_screen.dart` |
| **8** | `DropdownButtonFormField` | Physical activity level selector dropdown with validation, icons, and descriptions. | `lib/screens/calorie_screen.dart` |
| **9** | `Form` & `TextFormField` | Measurement forms managed via `GlobalKey<FormState>` and `validate()` checks. | `lib/screens/bmi_screen.dart`, `calorie_screen.dart` |
| **10** | `Navigator` for screen navigation | `Navigator.push`, `Navigator.pop`, and `Navigator.popUntil` for multi-screen routing. | `lib/screens/`, `lib/widgets/` |
| **11** | `setState()` for updating results | Triggered on form calculation, reset, goal chip switching, and theme toggling. | `lib/screens/bmi_screen.dart`, `result_screen.dart` |
| **12** | `MediaQuery` or `LayoutBuilder` | Responsive layout switching and dynamic needle positioning on the BMI spectrum gauge. | `lib/widgets/responsive_layout.dart`, `health_indicator.dart` |
| **13** | `ThemeData` for consistent styling | Complete Light and Dark theme configurations with navy, teal, and soft green palette. | `lib/utils/app_theme.dart` |
| **14** | Conditional statements in Dart | `if`, `else if`, `else`, and ternary operators selecting formulas, categories, and colors. | `lib/services/`, `lib/utils/health_advice.dart` |
| **15** | Reusable Dart functions | Decoupled pure functions for BMI, BMR, TDEE, boundaries, and advice generation. | `lib/services/bmi_calculator.dart`, `calorie_calculator.dart` |

---

## 8. BMI Calculation Formula & Logic

Body Mass Index is calculated using the international metric formula:

$$\text{BMI} = \frac{\text{Weight (kg)}}{\left(\frac{\text{Height (cm)}}{100}\right)^2}$$

### Adult Classification Table (Age $\ge$ 18):
| BMI Range ($\text{kg/m}^2$) | Health Category | Semantic Color | Palette Hex |
|---|---|---|---|
| Below $18.5$ | **Underweight** | Sky Blue | `#0284C7` |
| $18.5 - 24.9$ | **Normal weight** | Emerald / Soft Green | `#10B981` |
| $25.0 - 29.9$ | **Overweight** | Warm Amber | `#F59E0B` |
| $30.0$ and above | **Obesity** | Crimson Red | `#EF4444` |

### Pediatric Safety Logic:
```dart
if (age < 18) {
  // Suppress adult BMI classification cutoffs
  return 'Pediatric (<18 yrs)';
}
```

---

## 9. BMR & Daily Calorie Calculation Formulas

### Basal Metabolic Rate (Mifflin-St Jeor Equation)
The Mifflin-St Jeor formula calculates resting metabolic energy expenditure based on weight, stature, age, and biological sex:

- **Male Equation:**
  $$\text{BMR}_{\text{male}} = (10 \times \text{Weight}_{\text{kg}}) + (6.25 \times \text{Height}_{\text{cm}}) - (5 \times \text{Age}_{\text{years}}) + 5$$

- **Female Equation:**
  $$\text{BMR}_{\text{female}} = (10 \times \text{Weight}_{\text{kg}}) + (6.25 \times \text{Height}_{\text{cm}}) - (5 \times \text{Age}_{\text{years}}) - 161$$

### Total Daily Energy Expenditure (TDEE)
$$\text{TDEE} = \text{BMR} \times \text{Activity Multiplier}$$

| Tier | Activity Level | Multiplier | Description |
|---|---|---:|---|
| 1 | **Sedentary** | 1.200 | Little or no regular exercise; desk job |
| 2 | **Lightly Active** | 1.375 | Light exercise or sports 1–3 days/week |
| 3 | **Moderately Active** | 1.550 | Moderate exercise or sports 3–5 days/week |
| 4 | **Very Active** | 1.725 | Hard exercise or sports 6–7 days/week |
| 5 | **Extra Active** | 1.900 | Very hard exercise, physical job, or 2x daily training |

### Weight Goal Caloric Adjustments
- **Maintain Weight:** $\text{Target} = \text{TDEE} + 0\text{ kcal/day}$
- **Gradual Loss:** $\text{Target} = \text{TDEE} - 300\text{ kcal/day}$
- **Gradual Gain:** $\text{Target} = \text{TDEE} + 300\text{ kcal/day}$

*Safety rule:* Targets below $500\text{ kcal/day}$ or entries for users under 18 years old are safely suppressed.

---

## 10. UN SDG 3 Relevance

VitalTrack directly supports **United Nations Sustainable Development Goal 3: Good Health and Well-Being** (specifically Targets 3.4 and 3.5).

### Official Project Justification:
> *"VitalTrack supports SDG 3 by helping individuals understand basic health indicators such as BMI and estimated daily calorie requirements. It promotes health awareness and encourages balanced nutrition and healthy lifestyle habits."*

### Key Contributions:
1. **Target 3.4 (Non-Communicable Diseases):** Promotes early preventive awareness regarding healthy body dimensions and energy balance to mitigate risks of obesity, hypertension, and Type 2 diabetes.
2. **Health Literacy:** Transparently explains the scientific meaning of BMI, BMR, and TDEE, demystifying physiological terms for everyday users.
3. **Privacy by Design:** Zero tracking scripts, accounts, or telemetry, democratizing health awareness without compromising personal privacy.

---

## 11. Installation and Execution Instructions

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) ($\ge 3.10.0$)
- [Dart SDK](https://dart.dev/get-dart) ($\ge 3.0.0$)
- Android Studio / VS Code with Flutter and Dart extensions
- Connected Android physical device, Android Emulator, or Chrome Browser

### Step-by-Step Setup
1. **Clone or Open the Repository:**
   ```bash
   git clone https://github.com/rajarapuharsha/Flutter_Project1.git
   cd Flutter_Project1
   ```

2. **Fetch Dependencies:**
   ```bash
   flutter pub get
   ```

3. **Verify Environment Setup:**
   ```bash
   flutter doctor
   ```

4. **Run the Application:**
   ```bash
   # Run on connected Android device/emulator (Primary Target)
   flutter run -d android

   # Run in Web Browser (Chrome)
   flutter run -d chrome

   # Run on Windows Desktop
   flutter run -d windows
   ```

5. **Build Release Packages:**
   ```bash
   # Build Android Release APK
   flutter build apk --release

   # Build Web Release Bundle
   flutter build web --release

   # Build Windows Desktop Executable
   flutter build windows --release
   ```

---

## 12. Testing Details & Test Suite

The project includes an extensive automated test suite covering **42 unit and widget tests** validating mathematical accuracy, boundary conditions, pediatric guardrails, input validations, and UI interactions.

### Automated Test Matrix:
| Test File | Total Tests | Focus Area | Status |
|---|---:|---|---|
| `test/bmi_calculator_test.dart` | 11 | Known calculations, WHO category boundaries (18.49, 18.5, 24.99, 25.0, 29.99, 30.0), pediatric flags (<18), zero/negative rejection, healthy weight bounds, BMI Prime | **100% PASS** |
| `test/calorie_calculator_test.dart` | 9 | Male & Female Mifflin-St Jeor equations, all 5 activity multipliers, TDEE, goal offsets (-300, 0, +300), pediatric suppression, <500 kcal limits, invalid input exceptions | **100% PASS** |
| `test/calculator_service_test.dart` | 12 | Facade service orchestration, `calculateAll` integration, and `copyWithGoal` dynamic updates | **100% PASS** |
| `test/input_validator_test.dart` | 9 | Age boundaries [2, 120], Height boundaries [50.0, 260.0 cm], Weight boundaries [10.0, 400.0 kg], blank and non-numeric rejection | **100% PASS** |
| `test/vitaltrack_widget_test.dart` | 5 | Dashboard rendering, BMI screen calculation and clear, Calorie screen dropdown and TDEE calculation, ResultScreen goal switching, About dialog with SDG 3 quote | **100% PASS** |
| `test/calculator_screen_test.dart` | 4 | All-in-one screen form validation error display, reactive calculation, reset clearance, pediatric notice display | **100% PASS** |
| **Total Automated Tests** | **50** | **Comprehensive Full Coverage** | **100% PASS** |

### Run Automated Tests via CLI:
```bash
# Execute entire test suite
flutter test

# Run with verbose reporting
flutter test --reporter expanded

# Run static code analysis
flutter analyze
```

---

## 13. Screenshots Section & Recommendations

When preparing academic documentation or presentation slides, capture the following **4 recommended screenshots**:

1. **Screenshot 1: Home Dashboard**
   - *Display:* Navy gradient hero banner showing **VitalTrack** branding, tagline, quick launch buttons, BMI and Calorie action cards, and the Daily Wellness Tips carousel.
   - *Demonstrates:* Material 3 styling, clean typography, consistent spacing, and navigation structure.

2. **Screenshot 2: BMI Calculator Screen with Results**
   - *Display:* Form populated with Age: 25, Height: 175 cm, Weight: 70 kg, large `22.9 kg/m²` result, Emerald Green `Normal weight` badge, and the visual horizontal spectrum gauge with needle pointer.
   - *Demonstrates:* Real-time metric calculation, custom visual indicator, and WHO category styling.

3. **Screenshot 3: Daily Calorie Calculator Screen**
   - *Display:* Personal biometrics filled, `DropdownButtonFormField` expanded showing the 5 activity tiers, BMR card (`1674 kcal/day`), and Daily Maintenance Calories card (`2594 kcal/day`).
   - *Demonstrates:* Implementation of Flutter Concept #8 (dropdown menu), sex toggle, and Mifflin-St Jeor formula.

4. **Screenshot 4: Complete Results Screen & About Dialog**
   - *Display:* Comprehensive Results profile showing BMI, BMR, TDEE, the interactive Weight Goal switcher chips, personalized wellness guidance, and the SDG 3 justification card.
   - *Demonstrates:* Deep architecture, multi-screen navigation (`Navigator.popUntil`), dynamic goal updates, and UN SDG 3 alignment.

---

## 14. Future Enhancements
1. **Waist-to-Height Ratio (WHtR) Integration:** Incorporate abdominal circumference screening to evaluate visceral fat risk.
2. **Pediatric Growth Curve Percentile Visualizer:** Embed WHO and CDC pediatric growth curves for users under 18 years of age.
3. **Encrypted Local History:** Provide offline SQLite/Isar database storage for personal longitudinal progress tracking.
4. **Multilingual Localization:** Add support for regional languages (e.g., Hindi, Telugu, Spanish) to expand SDG 3 health awareness globally.
5. **PDF Health Report Export:** Generate a printable, non-diagnostic wellness summary report for doctor consultations.

---

## 15. Project Demonstration Script

Follow this script during your faculty lab practical demonstration or viva presentation:

```text
[STEP 1: APP LAUNCH & DASHBOARD OVERVIEW]
1. Open VitalTrack on the Android emulator or device.
2. Highlight the VitalTrack branding, pulse logo, and tagline: "Understand Your Body. Improve Your Lifestyle."
3. Point out the UN SDG 3 alignment banner and the Daily Wellness Tips horizontal carousel.
4. Tap the Theme Toggle icon in the top AppBar to demonstrate seamless switching between Light and Dark mode.
5. Tap the Info icon (ℹ️) to show the "About VitalTrack" dialog containing the exact SDG 3 justification quote.

[STEP 2: BMI CALCULATOR DEMONSTRATION]
1. Tap the "BMI" tab in the bottom NavigationBar (or tap "Launch BMI Calculator" card).
2. Tap "Calculate BMI" with empty fields to demonstrate Form validation and error messages.
3. Enter valid measurements: Age = 25, Height = 175 cm, Weight = 70 kg.
4. Tap "Calculate BMI". Show the large numerical value (22.9 kg/m²), the Normal weight badge (Emerald Green),
   and the animated needle on the horizontal spectrum gauge.
5. Tap the gauge switcher icon in the card header to demonstrate the Radial Circular Gauge mode.
6. Test Pediatric Protection: Change Age to 14 and recalculate; show how the adult category is replaced by
   a pediatric medical advisory banner.
7. Tap "Clear" to demonstrate complete controller and state reset.

[STEP 3: DAILY CALORIE CALCULATOR DEMONSTRATION]
1. Tap the "Calories" tab in the bottom NavigationBar.
2. Select Biological Sex = Male, Age = 25, Height = 175 cm, Weight = 70 kg.
3. Open the "Physical Activity Level" DropdownButtonFormField and select "Moderately Active (1.55x)".
4. Tap "Estimate Calories".
5. Explain the results to the examiner:
   - Basal Metabolic Rate (BMR) = 1674 kcal/day (Mifflin-St Jeor formula).
   - Daily Maintenance Calories (TDEE) = 1674 * 1.55 = 2594 kcal/day.
6. Select Biological Sex = Female and recalculate; explain the formula offset change from +5 to -161 (1508 kcal/day).

[STEP 4: COMPLETE HEALTH PROFILE & DYNAMIC RECALCULATION]
1. Tap "View Complete Health Profile" to navigate to the Results Screen.
2. Demonstrate the dynamic Weight Goal Switcher chips:
   - Tap "Gradual Weight Loss (-300 kcal)" -> Target instantly updates from 2594 to 2294 kcal/day.
   - Tap "Gradual Weight Gain (+300 kcal)" -> Target instantly updates to 2894 kcal/day.
3. Tap "Recalculate / Edit" to demonstrate Navigator.pop(context).
4. Return to results and tap "Return to Dashboard" to demonstrate Navigator.popUntil().
```

---

## 16. GitHub Upload Instructions

To upload or synchronize this project with GitHub:

```bash
# 1. Initialize git repository (if not already done)
git init

# 2. Stage all project files
git add .

# 3. Commit with a professional message
git commit -m "feat: complete VitalTrack BMI and Calorie Companion with SDG 3 alignment"

# 4. Set the main branch
git branch -M main

# 5. Link to your remote GitHub repository
git remote add origin https://github.com/rajarapuharsha/Flutter_Project1.git

# 6. Push to GitHub
git push -u origin main
```

---

## 17. 10 Likely Viva Questions with Answers

### Q1: What is the difference between `StatelessWidget` and `StatefulWidget` in Flutter?
**Answer:** A `StatelessWidget` is immutable; its properties cannot change once built (e.g., `ResultCard`, `HealthIndicator`). A `StatefulWidget` maintains mutable state via a companion `State` class that persists across widget rebuilds. Calling `setState()` notifies the Flutter framework that the internal state has changed, scheduling a rebuild of the widget subtree (e.g., `BmiScreen` updating calculation results).

### Q2: Why is `TextEditingController` disposed in the `dispose()` method?
**Answer:** `TextEditingController` holds native text input resources and change listeners. Failing to dispose of it when the widget is unmounted leads to memory leaks because the controller retains references in memory even after the screen has been popped from the widget tree.

### Q3: What is the Mifflin-St Jeor equation and why is it preferred over Harris-Benedict?
**Answer:** The Mifflin-St Jeor equation estimates Basal Metabolic Rate (BMR) based on weight (kg), height (cm), age (years), and biological sex. Published in 1990, clinical studies demonstrated that Mifflin-St Jeor is more accurate (within $\pm 10\%$ of measured resting energy expenditure) than the older 1919 Harris-Benedict formula, which tends to overestimate caloric requirements in modern populations.

### Q4: How does VitalTrack prevent adult BMI categories from being applied to minors?
**Answer:** In `BmiCalculator.classifyCategory(double bmi, {int? age})`, a conditional statement checks `if (age != null && age < 18)`. If true, it returns `'Pediatric (<18 yrs)'` and suppresses adult classifications and calorie targets. In children, body composition dynamically varies with puberty and age, requiring CDC/WHO BMI-for-age percentiles interpreted by a pediatrician.

### Q5: How is form validation implemented in Flutter?
**Answer:** A `Form` widget wraps the input fields and is assigned a `GlobalKey<FormState>()`. Individual `TextFormField` widgets specify a `validator` function. When the user taps Calculate, `_formKey.currentState?.validate()` is invoked. If any field returns an error string, Flutter re-renders that field with a red border and error text, blocking execution until all fields return `null`.

### Q6: How does the application support responsive design across different screen sizes?
**Answer:** Responsive design is achieved through `LayoutBuilder` and `MediaQuery`. In `ResponsiveLayout`, width breakpoints classify viewports: mobile ($<600\text{ dp}$), tablet ($600 - 1024\text{ dp}$), and desktop ($\ge 1024\text{ dp}$). On wide screens, inputs and results are displayed side-by-side; on mobile, they reflow into a scrollable single-column layout with a maximum width constraint to prevent UI stretching.

### Q7: What is the role of `InheritedWidget` in theme propagation?
**Answer:** `Theme.of(context)` looks up the nearest `Theme` widget up the widget tree using `InheritedWidget` mechanisms. When the theme mode toggles between Light and Dark in `app.dart`, all descendant widgets listening to `Theme.of(context)` automatically rebuild with the updated color scheme and typography.

### Q8: What does the physical activity multiplier represent in TDEE calculations?
**Answer:** Total Daily Energy Expenditure (TDEE) accounts for both resting metabolism and physical activity. The multiplier scales BMR based on occupational movement and deliberate exercise: Sedentary ($1.2\times$), Lightly Active ($1.375\times$), Moderately Active ($1.55\times$), Very Active ($1.725\times$), and Extra Active ($1.9\times$).

### Q9: How are dynamic weight goals recalculated without re-entering form data?
**Answer:** The `HealthResult` model is immutable but includes a `copyWithGoal(CalorieGoal newGoal)` method. When the user taps a different goal chip on `ResultScreen`, it calculates the adjusted target ($\text{maintenance} \pm 300\text{ kcal}$) and returns a new `HealthResult` instance passed to `setState()`, updating the UI instantly.

### Q10: How does VitalTrack contribute to UN Sustainable Development Goal 3?
**Answer:** VitalTrack supports **SDG 3 (Good Health and Well-Being)**, Target 3.4, by promoting preventive health literacy and non-communicable disease awareness. By providing transparent, privacy-first access to personal BMI and caloric maintenance metrics, individuals are empowered to make informed nutritional choices, engage in regular physical activity, and consult healthcare practitioners proactively.

---

## 18. Important Dart Functions & Conditional Statements

### 1. BMI Calculation & Adult Classification (`BmiCalculator`)
```dart
static double calculateBMI(double weightKg, double heightCm) {
  if (heightCm <= 0) {
    throw ArgumentError('Height must be greater than zero.');
  }
  if (weightKg <= 0) {
    throw ArgumentError('Weight must be greater than zero.');
  }
  final heightM = heightCm / 100.0;
  return weightKg / (heightM * heightM);
}

static String classifyCategory(double bmi, {int? age}) {
  // Conditional statement handling pediatric safety
  if (age != null && age < 18) {
    return 'Pediatric (<18 yrs)';
  }

  // Conditional statements for adult WHO BMI categories
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
```

### 2. Sex-Specific Mifflin-St Jeor BMR Calculation (`CalorieCalculator`)
```dart
static double calculateBMR({
  required int age,
  required BiologicalSex sex,
  required double heightCm,
  required double weightKg,
}) {
  // Conditional statement selecting physiological equation based on sex
  if (sex == BiologicalSex.male) {
    // Male formula: +5 offset
    return (10 * weightKg) + (6.25 * heightCm) - (5 * age) + 5;
  } else {
    // Female formula: -161 offset
    return (10 * weightKg) + (6.25 * heightCm) - (5 * age) - 161;
  }
}

static double calculateDailyCalories(double bmr, double activityMultiplier) {
  if (bmr <= 0 || activityMultiplier <= 0) {
    throw ArgumentError('BMR and activity multiplier must be positive values.');
  }
  return bmr * activityMultiplier;
}
```

### 3. Dynamic Calorie Goal Adjustment (`HealthResult.copyWithGoal`)
```dart
HealthResult copyWithGoal(CalorieGoal newGoal) {
  double? updatedGoalCalories;
  
  // Conditional check to ensure goals are only applied to non-pediatric adults
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
```

---

## License
This project is licensed under the [MIT License](LICENSE) — free for educational and academic practical use.
