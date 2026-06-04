import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

enum CyberButtonVariant { primary, danger, outline, ghost }

class CyberButton extends StatelessWidget {
  const CyberButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = CyberButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.minWidth = double.infinity,
  });

  final String label;
  final VoidCallback? onPressed;
  final CyberButtonVariant variant;
  final IconData? icon;
  final bool isLoading;
  final double minWidth;

  @override
  Widget build(BuildContext context) {
    final child = isLoading
        ? const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(AppColors.background),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 16),
                const SizedBox(width: 8),
              ],
              Text(label),
            ],
          );

    switch (variant) {
      case CyberButtonVariant.primary:
        return SizedBox(
          width: minWidth,
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            child: child,
          ),
        );

      case CyberButtonVariant.danger:
        return SizedBox(
          width: minWidth,
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.danger,
              foregroundColor: Colors.white,
              minimumSize: Size(minWidth, 50),
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              textStyle: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                fontSize: 13,
                letterSpacing: 2.0,
              ),
            ),
            child: child,
          ),
        );

      case CyberButtonVariant.outline:
        return SizedBox(
          width: minWidth,
          child: OutlinedButton(
            onPressed: isLoading ? null : onPressed,
            child: child,
          ),
        );

      case CyberButtonVariant.ghost:
        return SizedBox(
          width: minWidth,
          child: TextButton(
            onPressed: isLoading ? null : onPressed,
            child: child,
          ),
        );
    }
  }
}
