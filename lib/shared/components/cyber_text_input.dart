import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Styled text field matching the NCPD Design System.
class CyberTextInput extends StatelessWidget {
  const CyberTextInput({
    super.key,
    required this.label,
    this.controller,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.readOnly = false,
    this.textCapitalization = TextCapitalization.none,
    this.maxLines = 1,
    this.initialValue,
  });

  final String label;
  final TextEditingController? controller;
  final String? hint;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool readOnly;
  final TextCapitalization textCapitalization;
  final int maxLines;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: controller == null ? initialValue : null,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      readOnly: readOnly,
      textCapitalization: textCapitalization,
      maxLines: maxLines,
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 14,
        letterSpacing: 0.5,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, size: 18, color: AppColors.textMuted)
            : null,
        suffixIcon: suffixIcon,
      ),
    );
  }
}

/// Dropdown variant for enums / fixed lists.
class CyberDropdown<T> extends StatelessWidget {
  const CyberDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validator,
  });

  final String label;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      validator: validator,
      dropdownColor: AppColors.backgroundCard,
      style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
      icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.primary),
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: AppColors.backgroundInput,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.border),
          borderRadius: BorderRadius.zero,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.border),
          borderRadius: BorderRadius.zero,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
          borderRadius: BorderRadius.zero,
        ),
        labelStyle: const TextStyle(
          color: AppColors.textSecondary,
          fontFamily: 'monospace',
          fontSize: 11,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}
