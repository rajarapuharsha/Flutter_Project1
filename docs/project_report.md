# ACADEMIC PROJECT REPORT

## VitalTrack – BMI & Daily Calorie Companion
**Academic Flutter SDG Project Evaluation**  
**Course Rubric: 25 Marks Full Assessment**  
**Alignment: United Nations Sustainable Development Goal 3 (Good Health and Well-Being)**

---

### 1. Cover Page & Metadata
- **Project Title:** VitalTrack – BMI & Daily Calorie Companion
- **Tagline:** *Understand Your Body. Improve Your Lifestyle.*
- **Application Version:** 1.0.0+1
- **Target Evaluation:** Academic SDG Capstone / VEDIC Portal Submission
- **Primary SDG Target:** UN SDG 3: Good Health and Well-Being (Target 3.4 & 3.5)
- **Framework & Language:** Flutter SDK (Stable Channel >= 3.10.0) & Dart 3.x (Sound Null Safety)
- **UI Paradigm:** Material Design 3 (Responsive Multi-Platform)
- **Deployment Targets:** Android (Primary), Web, Windows Desktop, iOS, macOS, Linux
- **Repository Visibility:** Git Version Controlled, Open-Source (MIT License)

---

### 2. Abstract
Chronic non-communicable diseases (NCDs) such as cardiovascular conditions, Type 2 diabetes, and metabolic syndrome represent leading global causes of preventable morbidity. Central to preventing these conditions is personal health awareness regarding physical body dimensions, baseline metabolic expenditures, and nutritional energy balances. This project presents **VitalTrack**, a cross-platform, privacy-first software application built with the Flutter framework and Dart. The system allows users to calculate Body Mass Index (BMI), estimate Basal Metabolic Rate (BMR) via the clinically validated Mifflin-St Jeor formula, determine Total Daily Energy Expenditure (TDEE) based on five standardized activity multipliers, and explore safe illustrative calorie adjustment goals (-300, 0, +300 kcal/day).

Designed to operate entirely offline without remote databases or backend telemetry, the application provides an accessible visual spectrum indicator, radial circular gauge, robust input validation, and distinct safety guardrails for pediatric users under 18 years of age. By translating complex nutritional equations into an intuitive digital experience, the project aligns directly with United Nations Sustainable Development Goal 3 (Target 3.4: reducing premature mortality from NCDs through prevention and education).

---

### 3. Introduction
Modern lifestyles increasingly feature sedentary desk work and access to energy-dense, hyper-palatable foods. Consequently, many individuals lack a clear mathematical understanding of their daily caloric expenditure and whether their current weight falls within healthy epidemiological boundaries.

Digital health applications can bridge this knowledge gap. However, many contemporary commercial health apps require intrusive user accounts, cloud database tracking, continuous internet access, or monetize personal data through targeted advertising.

VitalTrack addresses these challenges by delivering an offline-capable, cross-platform Flutter application that adheres to sound software engineering principles. It separates calculation business logic from presentation, employs modular and testable architecture, and emphasizes user privacy and ethical AI/software design.

---

### 4. Problem Statement
Many individuals lack accessible, privacy-respecting, and mathematically transparent tools to:
1. Objectively evaluate their Body Mass Index against World Health Organization (WHO) adult classifications.
2. Estimate their resting basal metabolic energy expenditure using validated equations.
3. Understand how daily physical activity scales their maintenance caloric requirements.
4. Explore modest, sustainable caloric modifications for weight management without resorting to dangerous extreme crash diets.
5. Receive immediate feedback without surrendering private biometric measurements to third-party cloud servers.
6. Safeguard pediatric users from inappropriately applying adult BMI categories to growing children.

---

### 5. Project Objectives
The core objectives of the system are:
1. **Mathematical Accuracy**: Implement the metric Body Mass Index formula, the Mifflin-St Jeor BMR equations (incorporating male and female physiological constants), and the five-tier Harris-Benedict physical activity multipliers.
2. **Goal-Based Caloric Adjustments**: Calculate maintenance calories and provide illustrative arithmetic adjustments for gradual weight reduction (-300 kcal/day) or gradual weight accretion (+300 kcal/day).
3. **Safety & Pediatric Guardrails**: Automatically detect entries for individuals under 18 years of age, suppress inappropriate adult BMI classifications and weight modification targets, and present pediatric health guidance advising consultation with healthcare practitioners.
4. **Architectural Decoupling**: Separate data models, calculation services, input validation, and user interface widgets into distinct, maintainable Dart modules.
5. **Universal Accessibility & Responsiveness**: Deliver an adaptive Material 3 interface that dynamically reflows between a single-column layout on mobile devices and a side-by-side two-column dashboard on desktop and web viewports.
6. **Data Privacy & Zero Infrastructure Overhead**: Run 100% offline within client device memory without requiring login credentials, external APIs, cloud databases, or tracking scripts.

---

### 6. Scope
- **In-Scope**:
  - Adults aged 18–120 years: Complete BMI classification, BMR calculation, TDEE calculation, and goal adjustments.
  - Children and youth aged 2–17 years: Detection, pediatric safety notices, and medical referral advisories.
  - Input measurement support: Metric height (cm) and weight (kg) with full floating-point decimal precision.
  - Visual feedback: Multi-colored segmented gauge bar with pointer needle and circular radial gauge reflecting calculated BMI.
  - Interactive recalculation: Dynamic calorie goal switching directly within result cards without re-entering form data.
  - Form validation: Field-specific error handling for empty, non-numeric, or out-of-bounds inputs.
  - Dedicated screens for Home Dashboard, BMI Calculator, Calorie Calculator, and Complete Results.
- **Out-of-Scope**:
  - Medical diagnosis or prescription of clinical diets.
  - Cloud synchronization, social sharing, and user account creation.
  - Persistent biometric tracking across calendar dates (deliberately omitted for privacy).

---

### 7. SDG 3 Relevance: Good Health and Well-Being
The United Nations 2030 Agenda for Sustainable Development highlights **Goal 3: Ensure healthy lives and promote well-being for all at all ages**.

> *"VitalTrack supports SDG 3 by helping individuals understand basic health indicators such as BMI and estimated daily calorie requirements. It promotes health awareness and encourages balanced nutrition and healthy lifestyle habits."*

#### Alignment Points:
1. **Target 3.4 (Non-Communicable Diseases)**: Obesity, cardiovascular diseases, and hypertension are heavily influenced by chronic energy imbalances. Providing clear maintenance caloric thresholds fosters self-regulation.
2. **Health Literacy & Education**: The application includes a comprehensive Health Primer explaining the physiological meanings of BMI, BMR, and TDEE, demystifying clinical terminology for lay users.
3. **Preventive Self-Care**: Empowers individuals to evaluate lifestyle habits before chronic conditions develop.
4. **Ethical Communication**: Explicitly states that BMI is an epidemiological ratio rather than a comprehensive diagnostic tool, avoiding health stigma and encouraging professional medical assessments.

---

### 8. System Requirements

#### Minimum Hardware Requirements
- **Mobile (Android/iOS)**: 1.2 GHz processor, 1.5 GB RAM, 50 MB free disk space.
- **Desktop (Windows/macOS/Linux)**: 1.8 GHz dual-core x86/ARM64 processor, 2 GB RAM, 100 MB free disk space.
- **Web Browser**: Modern browser supporting WebGL and CanvasKit or HTML5.

#### Software & Development Environment
- **Flutter Framework**: Version 3.10.0 or higher (Channel: stable)
- **Dart SDK**: Version 3.0.0 or higher (Null safety enabled)
- **IDEs**: VS Code, Android Studio, or IntelliJ IDEA with Flutter/Dart extensions
- **Build Tools**: Android SDK (API 34 / compileSdk 34), Visual Studio 2022 C++ Tools (Windows)

---

### 9. Technology Stack
- **Framework**: Flutter (cross-platform single-codebase UI engine).
- **Language**: Dart 3 with sound null safety.
- **Design System**: Material Design 3 (`ThemeData(useMaterial3: true)`).
- **State Architecture**: Flutter built-in reactive state (`StatefulWidget`, `State`, `setState`) for clean, dependency-free lifecycle management.
- **Automated Testing**: `flutter_test` framework for unit and widget testing.
- **Version Control**: Git with standardized `.gitignore` and MIT licensing.

---

### 10. System Architecture & Folder Structure

```text
lib/
├── main.dart                      # Application entry point
├── app.dart                       # MaterialApp, light/dark theme toggle, navigation
├── models/
│   ├── health_result.dart         # Core immutable data model & enums
│   └── calculator_result.dart     # Backward-compatible model alias
├── services/
│   ├── bmi_calculator.dart        # Pure Dart BMI calculation & WHO logic
│   ├── calorie_calculator.dart    # Pure Dart Mifflin-St Jeor & TDEE service
│   └── calculator_service.dart    # Orchestrator facade service
├── utils/
│   ├── app_theme.dart             # Material 3 light & dark theme definitions
│   ├── health_advice.dart         # Categorized wellness advice & SDG 3 text
│   └── input_validator.dart       # Reusable boundary validator
├── widgets/
│   ├── custom_button.dart         # Reusable filled/outlined button
│   ├── input_field.dart           # Reusable styled TextFormField
│   ├── result_card.dart           # Metric presentation card component
│   ├── health_indicator.dart      # Horizontal spectrum bar & radial gauge
│   ├── bmi_indicator.dart         # Compatibility alias
│   ├── activity_level_selector.dart# Activity tier dropdown widget
│   ├── input_form.dart            # Multi-input measurement form
│   └── responsive_layout.dart     # Responsive breakpoint coordinator
└── screens/
    ├── home_screen.dart           # Dashboard with branding, tips & primer
    ├── bmi_screen.dart            # Dedicated BMI Calculator screen
    ├── calorie_screen.dart        # Dedicated Calorie Calculator screen
    ├── result_screen.dart         # Complete Results & goal switcher screen
    └── calculator_screen.dart     # All-in-one responsive calculator screen
```

---

### 11. Testing Methodology & Actual Results
Automated testing was conducted across **50 unit and widget test cases** using `flutter_test`:
- **BMI Calculations & Boundary Transitions**: 11 test cases verifying standard calculations, exact boundaries (18.49, 18.5, 24.99, 25.0, 29.99, 30.0), healthy weight bounds, BMI Prime, and invalid input rejection (100% PASS).
- **Mifflin-St Jeor & TDEE Calculations**: 9 test cases verifying male and female constants, all 5 multipliers, goal offsets (-300, 0, +300), pediatric suppression, and non-positive input handling (100% PASS).
- **Calculator Service Orchestration**: 12 test cases confirming unified calculations, pediatric flags, and dynamic goal updates (100% PASS).
- **Input Validator**: 9 test cases verifying boundary ranges, empty strings, and non-numerics (100% PASS).
- **VitalTrack Widget Tests**: 5 test cases confirming Dashboard rendering, BMI screen calculation, Calorie screen dropdown, Results screen goal updates, and About dialog display (100% PASS).
- **All-in-One Screen Tests**: 4 test cases confirming UI rendering, validation error display, end-to-end calculations, dynamic goal updates, and reset clearing (100% PASS).

---

### 12. Conclusion
**VitalTrack – BMI & Daily Calorie Companion** demonstrates a complete, production-ready Flutter software engineering project. By uniting rigorous mathematical models (WHO BMI, Mifflin-St Jeor, Harris-Benedict) with an accessible Material 3 design system, responsive layouts, automated tests, and offline privacy safeguards, the application provides an exemplary educational tool supporting United Nations Sustainable Development Goal 3.
