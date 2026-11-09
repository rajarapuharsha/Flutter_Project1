import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import '../utils/health_advice.dart';
import '../widgets/responsive_layout.dart';
import 'bmi_screen.dart';
import 'calorie_screen.dart';

/// Professional Home Dashboard for VitalTrack.
/// Features VitalTrack branding and logo, welcome greeting, BMI and Calorie Calculator
/// launch cards, educational primer, daily wellness tips, and UN SDG 3 alignment.
class HomeScreen extends StatelessWidget {
  final VoidCallback? onNavigateToCalculator;

  const HomeScreen({
    super.key,
    this.onNavigateToCalculator,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Hero Banner & VitalTrack Branding
              _buildHeroHeader(context),
              const SizedBox(height: 24),

              // Action Cards: BMI Calculator & Daily Calorie Calculator
              _buildActionCards(context),
              const SizedBox(height: 28),

              // Short Wellness Tips Section
              _buildDailyTipsSection(context),
              const SizedBox(height: 28),

              // Health Information Primer: BMI, BMR, TDEE
              _buildPrimerSection(context),
              const SizedBox(height: 28),

              // UN Sustainable Development Goal 3 Feature Card
              _buildSdgSection(context),
              const SizedBox(height: 28),

              // Health Disclaimer Card
              _buildDisclaimerCard(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.primaryNavy, Color(0xFF1E3A8A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryNavy.withOpacity(0.25),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.favorite,
                  color: Color(0xFF38BDF8),
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'VitalTrack',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                          ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Understand Your Body. Improve Your Lifestyle.',
                      style: TextStyle(
                        color: Color(0xFF93C5FD),
                        fontWeight: FontWeight.w600,
                        fontSize: 13.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Welcome to VitalTrack — your offline personal companion for Body Mass Index (BMI), '
            'Basal Metabolic Rate (BMR), and Daily Calorie requirements. Built for UN Sustainable '
            'Development Goal 3 (Good Health and Well-Being), VitalTrack runs 100% offline with zero data tracking.',
            style: TextStyle(
              color: Color(0xFFF1F5F9),
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 10,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BmiScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.secondaryTeal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.scale_outlined, size: 18),
                label: const Text('BMI Calculator', style: TextStyle(fontWeight: FontWeight.w700)),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CalorieScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.local_fire_department_outlined, size: 18),
                label: const Text('Calorie Calculator', style: TextStyle(fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCards(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);

    final cards = [
      _buildFeatureCard(
        context: context,
        icon: Icons.scale_outlined,
        accentColor: AppTheme.primaryBlue,
        title: 'BMI Calculator',
        description:
            'Calculate metric Body Mass Index (kg/m²) and evaluate adult WHO classifications across Underweight, Normal, Overweight, and Obesity ranges.',
        buttonLabel: 'Launch BMI Calculator',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BmiScreen()),
          );
        },
      ),
      _buildFeatureCard(
        context: context,
        icon: Icons.local_fire_department_outlined,
        accentColor: AppTheme.secondaryTeal,
        title: 'Daily Calorie Calculator',
        description:
            'Compute resting Basal Metabolic Rate via the Mifflin-St Jeor equation and evaluate maintenance calories across 5 activity multipliers.',
        buttonLabel: 'Launch Calorie Calculator',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CalorieScreen()),
          );
        },
      ),
    ];

    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: cards[0]),
          const SizedBox(width: 16),
          Expanded(child: cards[1]),
        ],
      );
    } else {
      return Column(
        children: [
          cards[0],
          const SizedBox(height: 14),
          cards[1],
        ],
      );
    }
  }

  Widget _buildFeatureCard({
    required BuildContext context,
    required IconData icon,
    required Color accentColor,
    required String title,
    required String description,
    required String buttonLabel,
    required VoidCallback onTap,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: accentColor, size: 28),
            ),
            const SizedBox(height: 14),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF64748B),
                    height: 1.45,
                  ),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(44),
                foregroundColor: accentColor,
                side: BorderSide(color: accentColor.withOpacity(0.7), width: 1.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(buttonLabel, style: const TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward_rounded, size: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyTipsSection(BuildContext context) {
    final tips = HealthAdvice.getDailyTips();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.tips_and_updates_outlined, color: AppTheme.secondaryTeal, size: 22),
            const SizedBox(width: 8),
            Text(
              'Wellness Tips for Daily Living',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 130,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: tips.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final tip = tips[index];
              final tipColor = Color(tip['color'] as int);

              return Container(
                width: 250,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: tipColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            tip['title'] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      tip['subtitle'] as String,
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: Color(0xFF64748B),
                        height: 1.35,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPrimerSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.menu_book_outlined, color: AppTheme.primaryNavy, size: 24),
                const SizedBox(width: 10),
                Text(
                  'Health Information Primer',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            _buildPrimerItem(
              title: 'Body Mass Index (BMI)',
              body:
                  'BMI is an epidemiological metric defined as weight (kg) divided by height squared (m²). '
                  'The World Health Organization classifies adult BMI into Underweight (<18.5), Normal weight (18.5-24.9), '
                  'Overweight (25.0-29.9), and Obesity (≥30.0). It serves as a screening indicator rather than a diagnostic measurement.',
            ),
            const Divider(height: 24),
            _buildPrimerItem(
              title: 'Basal Metabolic Rate (BMR)',
              body:
                  'BMR is the baseline energy expended to maintain involuntary vital life functions (cardiac rhythm, cellular respiration, thermoregulation) '
                  'in a resting state. VitalTrack uses the validated Mifflin-St Jeor equation with sex-specific constants.',
            ),
            const Divider(height: 24),
            _buildPrimerItem(
              title: 'Total Daily Energy Expenditure (TDEE)',
              body:
                  'TDEE scales your resting BMR by your physical activity tier (1.2x to 1.9x). '
                  'Consuming calories matching your TDEE maintains current weight; modest deficits (~300 kcal/day) facilitate sustainable reduction.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrimerItem({required String title, required String body}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          body,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF475569),
            height: 1.45,
          ),
        ),
      ],
    );
  }

  Widget _buildSdgSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFFECFDF5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFA7F3D0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.secondaryTeal,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.public, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'UN Sustainable Development Goal 3',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF065F46),
                      ),
                    ),
                    Text(
                      'Ensure healthy lives and promote well-being for all at all ages',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.teal.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            HealthAdvice.sdg3Justification,
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF064E3B),
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisclaimerCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFDE68A)),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.shield_outlined, color: AppTheme.overweightColor, size: 24),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Educational & Non-Diagnostic Disclaimer',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xFF92400E),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  HealthAdvice.nonDiagnosticDisclaimer,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF92400E),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
