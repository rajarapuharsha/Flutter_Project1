# Quality Assurance & Testing Report
## VitalTrack – BMI & Daily Calorie Companion (UN SDG 3 Project)

---

### 1. Test Overview & Strategy
This report documents the verification, validation, and test results for **VitalTrack – BMI & Daily Calorie Companion**. The quality assurance strategy comprises:
1. **Mathematical & Business Logic Unit Testing**: Verifying core formulas (BMI, Mifflin-St Jeor BMR, Harris-Benedict/TDEE multipliers, and goal offset calculations).
2. **Boundary & Edge Case Testing**: Testing exact boundary transitions (18.49, 18.5, 24.99, 25.0, 29.99, 30.0), extreme numbers, zero values, negative values, and non-finite numbers.
3. **Safety & Pediatric Guardrail Testing**: Verifying that individuals under 18 receive pediatric safety advice with adult classifications suppressed.
4. **Input Validation Testing**: Validating field-specific boundary criteria, numeric formatting, and rejection of blank/malformed entries.
5. **Widget & Interaction Testing**: Testing UI rendering, empty state display, error notification display, calculation triggering, reactive result display, and reset state clearance across Dashboard, BMI screen, Calorie screen, and Result screen.

---

### 2. Test Execution Summary

| Test Suite | File Location | Total Tests | Passed | Failed | Status |
|---|---|---:|---:|---:|---|
| **BMI Calculator Unit Tests** | `test/bmi_calculator_test.dart` | 11 | 11 | 0 | **PASS** |
| **Calorie Calculator Unit Tests** | `test/calorie_calculator_test.dart` | 9 | 9 | 0 | **PASS** |
| **Calculator Service Tests** | `test/calculator_service_test.dart` | 12 | 12 | 0 | **PASS** |
| **Input Validator Unit Tests** | `test/input_validator_test.dart` | 9 | 9 | 0 | **PASS** |
| **VitalTrack Widget Tests** | `test/vitaltrack_widget_test.dart` | 5 | 5 | 0 | **PASS** |
| **All-in-One Screen Tests** | `test/calculator_screen_test.dart` | 4 | 4 | 0 | **PASS** |
| **Total Automated Test Cases** | | **50** | **50** | **0** | **100% PASS** |

---

### 3. Detailed Test Cases & Results

#### 3.1 Unit Tests: BMI Calculation & Classification (`test/bmi_calculator_test.dart`)
| Test ID | Description | Input Data | Expected Result | Actual Result | Status |
|---|---|---|---|---|---|
| **TC-BMI-01** | Standard BMI Calculation | Weight: `70 kg`, Height: `175 cm` | BMI $\approx 22.857 \text{ kg/m}^2$ | $22.857 \text{ kg/m}^2$ | **PASS** |
| **TC-BMI-02** | Decimal Precision Handling | Weight: `64.5 kg`, Height: `168.0 cm` | BMI $\approx 22.853 \text{ kg/m}^2$ | $22.853 \text{ kg/m}^2$ | **PASS** |
| **TC-BMI-03** | Underweight Upper Boundary | BMI: `18.49` | Category: `Underweight` | `Underweight` | **PASS** |
| **TC-BMI-04** | Normal Weight Lower Boundary | BMI: `18.5` | Category: `Normal weight` | `Normal weight` | **PASS** |
| **TC-BMI-05** | Normal Weight Upper Boundary | BMI: `24.99` | Category: `Normal weight` | `Normal weight` | **PASS** |
| **TC-BMI-06** | Overweight Lower Boundary | BMI: `25.0` | Category: `Overweight` | `Overweight` | **PASS** |
| **TC-BMI-07** | Overweight Upper Boundary | BMI: `29.99` | Category: `Overweight` | `Overweight` | **PASS** |
| **TC-BMI-08** | Obesity Classification | BMI: `30.0` | Category: `Obesity` | `Obesity` | **PASS** |
| **TC-BMI-09** | Pediatric Suppression | Age: `14`, BMI: `22.0` | Category: `Pediatric (<18 yrs)` | `Pediatric (<18 yrs)` | **PASS** |
| **TC-BMI-10** | Zero/Negative Height Protection | Height: `0` or `-170 cm` | Throws `ArgumentError` | Throws `ArgumentError` | **PASS** |
| **TC-BMI-11** | Zero/Negative Weight Protection | Weight: `0` or `-65 kg` | Throws `ArgumentError` | Throws `ArgumentError` | **PASS** |

#### 3.2 Unit Tests: Calorie & Metabolic Estimations (`test/calorie_calculator_test.dart`)
| Test ID | Description | Input Data | Expected Result | Actual Result | Status |
|---|---|---|---|---|---|
| **TC-CAL-01** | Male Mifflin-St Jeor Formula | Age: `25`, Weight: `70 kg`, Height: `175 cm` | $\text{BMR} = 1673.75 \text{ kcal/day}$ | $1673.75 \text{ kcal/day}$ | **PASS** |
| **TC-CAL-02** | Female Mifflin-St Jeor Formula | Age: `25`, Weight: `70 kg`, Height: `175 cm` | $\text{BMR} = 1507.75 \text{ kcal/day}$ | $1507.75 \text{ kcal/day}$ | **PASS** |
| **TC-CAL-03** | Sex Biological Difference Check | Age: `30`, Height: `180 cm`, Weight: `80 kg` | Difference $= 166.0 \text{ kcal}$ | $166.0 \text{ kcal}$ | **PASS** |
| **TC-CAL-04** | Invalid BMR Input Rejection | Age: `0`, Weight: `0`, or Height: `0` | Throws `ArgumentError` | Throws `ArgumentError` | **PASS** |
| **TC-CAL-05** | Activity Multiplier Tiers | Sedentary to Extra Active | Exact `1.2` to `1.9` | Matches | **PASS** |
| **TC-CAL-06** | Daily Maintenance Energy (TDEE)| BMR: `1600 kcal`, Multiplier: `1.55` | $\text{TDEE} = 2480.0 \text{ kcal/day}$ | $2480.0 \text{ kcal/day}$ | **PASS** |
| **TC-CAL-07** | Adult Calorie Goal Offsets | Maintenance: `2400 kcal` | Maintain: `2400`, Loss: `2100`, Gain: `2700` | Matches | **PASS** |
| **TC-CAL-08** | Pediatric Goal Suppression | Age: `15`, Goal: `Loss` | `null` (suppressed) | `null` | **PASS** |
| **TC-CAL-09** | Floor Limit Protection | Maintenance: `600 kcal`, Goal: `Loss` | `null` ($< 500 \text{ kcal}$) | `null` | **PASS** |

#### 3.3 Unit Tests: Input Validation Rules (`test/input_validator_test.dart`)
| Test ID | Description | Input Data | Expected Result | Actual Result | Status |
|---|---|---|---|---|---|
| **TC-VAL-01** | Blank Age Field | `""` or `null` | `'Please enter your age.'` | Matches | **PASS** |
| **TC-VAL-02** | Non-Integer Age | `"25.5"` or `"abc"` | `'Please enter a valid whole number for age.'` | Matches | **PASS** |
| **TC-VAL-03** | Age Below Range | `"1"` | `'Age must be between 2 and 120 years.'` | Matches | **PASS** |
| **TC-VAL-04** | Age Above Range | `"121"` | `'Age must be between 2 and 120 years.'` | Matches | **PASS** |
| **TC-VAL-05** | Blank Height Field | `""` or `null` | `'Please enter your height.'` | Matches | **PASS** |
| **TC-VAL-06** | Height Out of Range | `"49.9"` or `"260.1"` | `'Height must be between 50.0 and 260.0 cm.'` | Matches | **PASS** |
| **TC-VAL-07** | Blank Weight Field | `""` or `null` | `'Please enter your weight.'` | Matches | **PASS** |
| **TC-VAL-08** | Weight Out of Range | `"9.9"` or `"400.1"` | `'Weight must be between 10.0 and 400.0 kg.'` | Matches | **PASS** |
| **TC-VAL-09** | Valid Inputs Accepted | Age: `"25"`, Ht: `"175"`, Wt: `"70"` | `null` (valid) | `null` | **PASS** |

#### 3.4 Widget Tests: VitalTrack UI & Interactions (`test/vitaltrack_widget_test.dart`)
| Test ID | Description | Steps & Interactions | Expected Result | Actual Result | Status |
|---|---|---|---|---|---|
| **TC-WGT-01** | Dashboard & Branding | Render `VitalTrackApp` | Branding, tagline, cards, and navigation destinations visible | All elements located | **PASS** |
| **TC-WGT-02** | BMI Screen Flow & Reset | Enter `25`, `175`, `70`; tap Calculate; tap Clear | BMI `22.9`, Normal weight badge rendered; Clear resets form | Flow verified | **PASS** |
| **TC-WGT-03** | Calorie Screen Flow | Select Sex, enter `25`, `175`, `70`; tap Estimate | BMR `1674`, TDEE `2594` rendered | Flow verified | **PASS** |
| **TC-WGT-04** | ResultScreen Goal Switching | Load `ResultScreen`, tap Gradual Loss | Target updates dynamically from `2635` to `2335` | Flow verified | **PASS** |
| **TC-WGT-05** | About Dialog & SDG 3 Quote | Tap Info icon in AppBar | About dialog renders with exact SDG 3 justification quote | Quote verified | **PASS** |

---

### 4. Cross-Platform Build Compatibility
VitalTrack is written in clean, modern Flutter and Dart targeting six platforms from a single codebase:
- **Android:** API level 21 through 34 (`flutter build apk --release`).
- **Web Browser:** CanvasKit and HTML5 rendering (`flutter build web --release`).
- **Windows Desktop:** Win32/x64 C++ release executable (`flutter build windows --release`).
- **iOS / macOS / Linux:** Single shared Dart codebase ready for build with native toolchains.
