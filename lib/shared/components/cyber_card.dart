import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Reusable card with a neon-cyan left-border accent.
class CyberCard extends StatelessWidget {
  const CyberCard({
    super.key,
    required this.child,
    this.borderColor = AppColors.primary,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
    this.margin,
  });

  final Widget child;
  final Color borderColor;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        border: Border(
          left: BorderSide(color: borderColor, width: 3),
          top:  BorderSide(color: AppColors.border),
          right:  BorderSide(color: AppColors.border),
          bottom: BorderSide(color: AppColors.border),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          splashColor: borderColor.withOpacity(0.1),
          highlightColor: borderColor.withOpacity(0.05),
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}
