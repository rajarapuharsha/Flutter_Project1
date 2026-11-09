# User Manual: VitalTrack – BMI & Daily Calorie Companion
## Healthy Living for Sustainable Development (UN SDG 3)

---

### Table of Contents
1. [Introduction](#1-introduction)
2. [System Requirements & Installation](#2-system-requirements--installation)
3. [Launching the Application](#3-launching-the-application)
4. [Navigating the Dashboard](#4-navigating-the-dashboard)
5. [Using the BMI Calculator](#5-using-the-bmi-calculator)
6. [Using the Daily Calorie Calculator](#6-using-the-daily-calorie-calculator)
7. [Interpreting Your Health Profile](#7-interpreting-your-health-profile)
8. [Pediatric Safety Features](#8-pediatric-safety-features)
9. [Theme Mode & Accessibility](#9-theme-mode--accessibility)
10. [Privacy, Data Security & Offline Use](#10-privacy-data-security--offline-use)
11. [Frequently Asked Questions (FAQ)](#11-frequently-asked-questions-faq)
12. [Health & Safety Disclaimer](#12-health--safety-disclaimer)

---

### 1. Introduction
**VitalTrack – BMI & Daily Calorie Companion** is an academic software application designed to support **United Nations Sustainable Development Goal 3: Good Health and Well-Being**. The application calculates Body Mass Index (BMI), Basal Metabolic Rate (BMR) via the Mifflin-St Jeor formula, and Total Daily Energy Expenditure (TDEE) across five standard physical activity tiers.

VitalTrack operates **100% offline**, privacy-first, and requires no account registration, remote servers, or background analytics.

---

### 2. System Requirements & Installation

| Platform | Minimum OS Version | Hardware Requirements |
|---|---|---|
| **Android** | Android 5.0 (API level 21) or higher | 1.5 GHz multi-core, 2 GB RAM |
| **Web** | Modern browser (Chrome 90+, Edge 90+, Firefox 88+, Safari 14+) | 1 GHz CPU, 2 GB RAM |
| **Windows Desktop** | Windows 10 (64-bit) or Windows 11 | x64 CPU, 4 GB RAM, DirectX 11 support |
| **iOS / iPadOS** | iOS 12.0 or higher | 64-bit Apple device |
| **macOS Desktop** | macOS 10.14 (Mojave) or higher | Intel or Apple Silicon, 4 GB RAM |
| **Linux Desktop** | Ubuntu 20.04 LTS+, Fedora 36+, or equivalent | 64-bit x86/ARM, GTK 3.0+ |

---

### 3. Launching the Application

#### Running from Source (Development Environment)
1. Ensure the Flutter SDK is installed on your system.
2. Open a terminal inside the project directory:
   ```bash
   cd "c:\Users\rajar\OneDrive\Desktop\Flutter Project"
   ```
3. Fetch dependencies:
   ```bash
   flutter pub get
   ```
4. Run on your desired platform:
   - **Android Device/Emulator:** `flutter run -d android`
   - **Web Browser (Chrome):** `flutter run -d chrome`
   - **Windows Desktop:** `flutter run -d windows`

---

### 4. Navigating the Dashboard
Upon opening VitalTrack, you arrive at the **Home Dashboard**:
- **Hero Banner:** Features the VitalTrack brand identity, pulse logo, tagline, and quick launcher buttons.
- **BMI & Calorie Cards:** Direct cards to launch the dedicated calculators.
- **Wellness Tips:** A horizontal carousel of practical daily habits (Hydration, 150-Min Movement, Whole Foods, Restorative Sleep, Mindful Eating).
- **Health Primer:** Summary cards explaining BMI, BMR, and TDEE.
- **UN SDG 3 Card:** Explains the project's contribution to Target 3.4.
- **Top Bar Actions:**
  - **Theme Toggle:** Switch between Light and Dark mode.
  - **Info Button (ℹ️):** Opens the About VitalTrack dialog.
- **Bottom Navigation Bar:** Switch between Dashboard, BMI Calculator, Calorie Calculator, and All-in-One view.

---

### 5. Using the BMI Calculator
1. Select the **BMI** tab from the bottom navigation bar or tap **Launch BMI Calculator** on the home dashboard.
2. Enter your **Age** in years (e.g. `25`).
3. Enter your **Height** in centimeters (e.g. `175.0`).
4. Enter your **Weight** in kilograms (e.g. `70.0`).
5. Tap **Calculate BMI**.
6. View your large BMI numerical score (e.g. `22.9 kg/m²`), category badge (e.g. `Normal weight`), and visual spectrum indicator.
7. Tap the toggle icon in the card header to switch between the horizontal spectrum bar and the radial circular gauge.
8. Tap **View Complete Health Profile** to see your integrated results.

---

### 6. Using the Daily Calorie Calculator
1. Select the **Calories** tab from the bottom navigation bar.
2. Enter your **Age**, select your **Biological Sex** (Male or Female), enter your **Height (cm)**, and enter your **Weight (kg)**.
3. Select your **Physical Activity Level** from the dropdown menu:
   - Sedentary ($1.2\times$)
   - Lightly Active ($1.375\times$)
   - Moderately Active ($1.55\times$)
   - Very Active ($1.725\times$)
   - Extra Active ($1.9\times$)
4. Choose your **Caloric Objective** (Maintain Weight, Gradual Loss, Gradual Gain).
5. Tap **Estimate Calories**.
6. View your **Basal Metabolic Rate (BMR)**, **Daily Maintenance Calories (TDEE)**, and nutritional guidelines.

---

### 7. Interpreting Your Health Profile
The **Complete Health Profile Screen** displays:
- **Biometric Summary:** Height, weight, age, and sex overview.
- **BMI Score & Category:** Underweight ($<18.5$), Normal ($18.5-24.9$), Overweight ($25.0-29.9$), or Obesity ($\ge 30.0$).
- **BMR (kcal/day):** Baseline resting energy expenditure.
- **Maintenance Calories (TDEE):** Daily energy required to sustain current weight.
- **Interactive Goal Switcher:** Tap between Maintain, Loss (-300 kcal), and Gain (+300 kcal) chips to see instant adjustments.
- **Personalized Recommendations:** Category-specific lifestyle tips and SDG 3 healthy living pillars.

---

### 8. Pediatric Safety Features
When the entered age is under 18 years:
- Adult BMI classifications and adult weight loss/gain targets are suppressed.
- A prominent medical advisory informs that adolescent body composition dynamically changes with growth and requires pediatric percentile growth charts evaluated by a healthcare professional.

---

### 9. Theme Mode & Accessibility
- Tap the **Sun/Moon** icon in the AppBar at any time to toggle between Light Theme and Dark Theme.
- High-contrast colors ensure legibility across all lighting environments.

---

### 10. Privacy, Data Security & Offline Use
- **100% Offline:** All math executes strictly in device RAM using Dart functions.
- **Zero Data Collection:** No cookies, trackers, telemetry, or cloud requests.
- **Session Only:** Data is stored in memory during runtime and is cleared upon resetting.

---

### 11. Frequently Asked Questions (FAQ)

**Q1: Why does BMI categorize an athlete as overweight?**  
*A: BMI is a ratio of mass to height. It does not measure body fat percentage directly and cannot distinguish dense muscle tissue from fat.*

**Q2: Are the BMR equations exact?**  
*A: The Mifflin-St Jeor formula is one of the most widely validated predictive models in clinical nutrition, but individual metabolic rates vary based on thyroid function, genetics, muscle mass, and climate.*

**Q3: Can children use VitalTrack?**  
*A: Yes, but VitalTrack safely detects ages under 18, suppresses adult cutoffs, and provides pediatric health education.*

---

### 12. Health & Safety Disclaimer
> [!IMPORTANT]
> VitalTrack is strictly an educational tool designed for academic demonstration and general wellness self-awareness. It is **not** a certified medical diagnostic device. Do not use its output to diagnose illnesses, manage clinical conditions, or replace professional consultation with a licensed physician or registered dietitian.
