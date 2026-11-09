import 'package:flutter/material.dart';

/// A reusable, accessible card component for presenting calculated health metrics,
/// badges, and educational summaries with consistent styling and typography.
class ResultCard extends StatelessWidget {
  final String title;
  final String value;
  final String? unit;
  final String? subtitle;
  final Widget? trailingBadge;
  final IconData icon;
  final Color accentColor;
  final Widget? child;

  const ResultCard({
    super.key,
    required this.title,
    required this.value,
    this.unit,
    this.subtitle,
    this.trailingBadge,
    required this.icon,
    this.accentColor = const Color(0xFF1A365D),
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryTextColor = isDark ? const Color(0xFFF1F5F9) : const Color(0xFF0F172A);
    final secondaryTextColor = isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(isDark ? 0.2 : 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: accentColor, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF334155),
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                if (trailingBadge != null) trailingBadge!,
              ],
            ),
            const SizedBox(height: 14),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 28,
                    color: primaryTextColor,
                    letterSpacing: -0.5,
                  ),
                ),
                if (unit != null) ...[
                  const SizedBox(width: 6),
                  Text(
                    unit!,
                    style: TextStyle(
                      color: secondaryTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                style: TextStyle(
                  color: secondaryTextColor,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
            ],
            if (child != null) ...[
              const SizedBox(height: 16),
              child!,
            ],
          ],
        ),
      ),
    );
  }
}
