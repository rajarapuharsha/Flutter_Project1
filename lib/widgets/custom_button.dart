import 'package:flutter/material.dart';

/// Reusable button widget supporting filled and outlined variants,
/// leading icons, custom background colors, and loading indicator states.
class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isOutlined;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool isLoading;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isOutlined = false,
    this.backgroundColor,
    this.foregroundColor,
    this.isLoading = false,
    this.height = 50.0,
    this.borderRadius = 12.0,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    );

    final content = isLoading
        ? const SizedBox(
            height: 22,
            width: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20),
                const SizedBox(width: 8),
              ],
              Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          );

    if (isOutlined) {
      return OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          minimumSize: Size(double.infinity, height),
          foregroundColor: foregroundColor ?? Theme.of(context).primaryColor,
          side: BorderSide(
            color: backgroundColor ?? foregroundColor ?? Theme.of(context).primaryColor,
            width: 1.5,
          ),
          shape: shape,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
        child: content,
      );
    }

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, height),
        backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
        foregroundColor: foregroundColor ?? Colors.white,
        elevation: 2,
        shape: shape,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: content,
    );
  }
}
