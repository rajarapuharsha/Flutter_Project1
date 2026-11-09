import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

/// An attractive, visual BMI indicator supporting both a multi-segment
/// horizontal spectrum bar with a pointer needle and a circular radial gauge.
class HealthIndicator extends StatelessWidget {
  final double bmi;
  final String category;
  final bool isPediatric;
  final bool isCircular;

  const HealthIndicator({
    super.key,
    required this.bmi,
    required this.category,
    this.isPediatric = false,
    this.isCircular = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isPediatric) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.pediatricColor.withOpacity(0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppTheme.pediatricColor.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            const Icon(Icons.info_outline, color: AppTheme.pediatricColor, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Pediatric Profile: Standard adult BMI scale does not apply to individuals under 18 years. '
                'Growth percentiles interpreted by a pediatrician must be used.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.pediatricColor,
                      height: 1.4,
                    ),
              ),
            ),
          ],
        ),
      );
    }

    if (isCircular) {
      return _buildCircularGauge(context);
    }

    return _buildHorizontalSpectrum(context);
  }

  Widget _buildCircularGauge(BuildContext context) {
    final activeColor = AppTheme.getColorForCategory(category);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 200,
            height: 140,
            child: CustomPaint(
              painter: _RadialBmiPainter(
                bmi: bmi,
                activeColor: activeColor,
                isDark: isDark,
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        bmi.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: isDark ? Colors.white : const Color(0xFF0F172A),
                          letterSpacing: -0.5,
                        ),
                      ),
                      Text(
                        'kg/m²',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: activeColor.withOpacity(0.14),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: activeColor, width: 1.5),
            ),
            child: Text(
              category,
              style: TextStyle(
                color: activeColor,
                fontWeight: FontWeight.w800,
                fontSize: 13,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalSpectrum(BuildContext context) {
    const minScale = 12.0;
    const maxScale = 40.0;
    final normalizedPosition = ((bmi - minScale) / (maxScale - minScale)).clamp(0.0, 1.0);
    final activeColor = AppTheme.getColorForCategory(category);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Semantics(
      label: 'BMI Category Bar: Current BMI is ${bmi.toStringAsFixed(1)}, classified as $category.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'BMI Range Spectrum',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: activeColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: activeColor),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    color: activeColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Track with Needle Pointer
          LayoutBuilder(
            builder: (context, constraints) {
              final trackWidth = constraints.maxWidth;
              final pointerX = (trackWidth * normalizedPosition).clamp(8.0, trackWidth - 8.0);

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  // Multi-Segmented Color Bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: const SizedBox(
                      height: 16,
                      child: Row(
                        children: [
                          // Underweight (< 18.5)
                          Expanded(
                            flex: 65,
                            child: ColoredBox(color: AppTheme.underweightColor),
                          ),
                          SizedBox(width: 2),
                          // Normal weight (18.5 - 24.9)
                          Expanded(
                            flex: 65,
                            child: ColoredBox(color: AppTheme.normalWeightColor),
                          ),
                          SizedBox(width: 2),
                          // Overweight (25.0 - 29.9)
                          Expanded(
                            flex: 50,
                            child: ColoredBox(color: AppTheme.overweightColor),
                          ),
                          SizedBox(width: 2),
                          // Obesity (>= 30.0)
                          Expanded(
                            flex: 100,
                            child: ColoredBox(color: AppTheme.obesityColor),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Pointer Needle Marker
                  Positioned(
                    left: pointerX - 6,
                    top: -6,
                    child: Container(
                      width: 12,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: isDark ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A),
                          width: 2.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 12),

          // Scale Labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildRangeLabel(context, '<18.5\nUnderweight', AppTheme.underweightColor),
              _buildRangeLabel(context, '18.5–24.9\nNormal', AppTheme.normalWeightColor),
              _buildRangeLabel(context, '25–29.9\nOverweight', AppTheme.overweightColor),
              _buildRangeLabel(context, '≥30\nObesity', AppTheme.obesityColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRangeLabel(BuildContext context, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 11,
                height: 1.15,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF64748B),
              ),
        ),
      ],
    );
  }
}

/// Custom painter for semi-circular radial BMI gauge
class _RadialBmiPainter extends CustomPainter {
  final double bmi;
  final Color activeColor;
  final bool isDark;

  _RadialBmiPainter({
    required this.bmi,
    required this.activeColor,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2 - 14;

    final backgroundPaint = Paint()
      ..color = isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;

    // Draw background semicircle (from 180 deg to 0 deg)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi,
      false,
      backgroundPaint,
    );

    // Normalize BMI: 12.0 -> 0.0, 40.0 -> 1.0
    final fraction = ((bmi - 12.0) / (40.0 - 12.0)).clamp(0.0, 1.0);
    final sweepAngle = math.pi * fraction;

    final activePaint = Paint()
      ..color = activeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;

    if (sweepAngle > 0.01) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        math.pi,
        sweepAngle,
        false,
        activePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RadialBmiPainter oldDelegate) {
    return oldDelegate.bmi != bmi ||
        oldDelegate.activeColor != activeColor ||
        oldDelegate.isDark != isDark;
  }
}
