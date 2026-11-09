import 'package:flutter/material.dart';
import 'screens/bmi_screen.dart';
import 'screens/calculator_screen.dart';
import 'screens/calorie_screen.dart';
import 'screens/home_screen.dart';
import 'utils/app_theme.dart';
import 'utils/health_advice.dart';

/// Root application widget configuring MaterialApp, light/dark theme modes,
/// and tab-based navigation across VitalTrack screens.
class VitalTrackApp extends StatefulWidget {
  const VitalTrackApp({super.key});

  @override
  State<VitalTrackApp> createState() => _VitalTrackAppState();
}

/// Backward compatibility alias
typedef BmiCalorieApp = VitalTrackApp;

class _VitalTrackAppState extends State<VitalTrackApp> {
  int _currentIndex = 0;
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      if (_themeMode == ThemeMode.light) {
        _themeMode = ThemeMode.dark;
      } else if (_themeMode == ThemeMode.dark) {
        _themeMode = ThemeMode.light;
      } else {
        final brightness = MediaQuery.of(context).platformBrightness;
        _themeMode = brightness == Brightness.dark ? ThemeMode.light : ThemeMode.dark;
      }
    });
  }

  void _navigateToCalculator() {
    setState(() {
      _currentIndex = 3;
    });
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.favorite, color: Color(0xFF38BDF8)),
              SizedBox(width: 10),
              Text(
                'About VitalTrack',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'VitalTrack – BMI & Daily Calorie Companion',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Understand Your Body. Improve Your Lifestyle.',
                  style: TextStyle(fontSize: 12.5, color: AppTheme.secondaryTeal, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                const Text(
                  'VitalTrack is an academic Flutter mobile and cross-platform application developed '
                  'for B.Tech practical evaluation, aligned with UN Sustainable Development Goal 3 '
                  '(Good Health and Well-Being).',
                  style: TextStyle(fontSize: 13, height: 1.45),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFECFDF5),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFA7F3D0)),
                  ),
                  child: const Text(
                    HealthAdvice.sdg3Justification,
                    style: TextStyle(fontSize: 12, color: Color(0xFF065F46), height: 1.4, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Scientific Standards Implemented:',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                ),
                const SizedBox(height: 6),
                const Text(
                  '• WHO Body Mass Index classification ranges\n'
                  '• Mifflin-St Jeor BMR estimation equations (Male & Female)\n'
                  '• Physical activity multipliers (1.2 to 1.9x)\n'
                  '• Pediatric safety and non-diagnostic disclaimers',
                  style: TextStyle(fontSize: 12, height: 1.5, color: Color(0xFF64748B)),
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFBEB),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFFDE68A)),
                  ),
                  child: const Text(
                    'Notice: For educational demonstration only. Not intended as clinical diagnosis or medical treatment.',
                    style: TextStyle(fontSize: 11, color: Color(0xFF92400E), height: 1.35),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VitalTrack – BMI & Daily Calorie Companion',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      home: Builder(
        builder: (context) {
          final isDark = Theme.of(context).brightness == Brightness.dark;

          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.favorite, size: 20, color: Color(0xFF38BDF8)),
                  ),
                  const SizedBox(width: 10),
                  const Flexible(
                    child: Text(
                      'VitalTrack',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: Icon(isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
                  tooltip: isDark ? 'Switch to Light Theme' : 'Switch to Dark Theme',
                  onPressed: _toggleTheme,
                ),
                IconButton(
                  icon: const Icon(Icons.info_outline),
                  tooltip: 'About VitalTrack & SDG 3',
                  onPressed: () => _showAboutDialog(context),
                ),
              ],
            ),
            body: IndexedStack(
              index: _currentIndex,
              children: [
                HomeScreen(onNavigateToCalculator: _navigateToCalculator),
                const BmiScreen(),
                const CalorieScreen(),
                const CalculatorScreen(),
              ],
            ),
            bottomNavigationBar: NavigationBar(
              selectedIndex: _currentIndex,
              onDestinationSelected: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.dashboard_outlined),
                  selectedIcon: Icon(Icons.dashboard, color: AppTheme.primaryNavy),
                  label: 'Dashboard',
                ),
                NavigationDestination(
                  icon: Icon(Icons.scale_outlined),
                  selectedIcon: Icon(Icons.scale, color: AppTheme.primaryNavy),
                  label: 'BMI',
                ),
                NavigationDestination(
                  icon: Icon(Icons.local_fire_department_outlined),
                  selectedIcon: Icon(Icons.local_fire_department, color: AppTheme.primaryNavy),
                  label: 'Calories',
                ),
                NavigationDestination(
                  icon: Icon(Icons.calculate_outlined),
                  selectedIcon: Icon(Icons.calculate, color: AppTheme.primaryNavy),
                  label: 'All-in-One',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
