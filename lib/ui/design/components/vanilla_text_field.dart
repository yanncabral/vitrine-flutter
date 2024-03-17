import 'package:flutter/material.dart';
import 'package:vitrine/ui/design/vanilla_color_scheme.dart';

class VanillaTextField extends StatelessWidget {
  final String labelText;
  final void Function(String text) onChange;
  final String? errorText;
  final bool? enabled;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;

  const VanillaTextField({
    super.key,
    required this.labelText,
    required this.onChange,
    this.errorText,
    this.enabled,
    this.textInputAction,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enabled,
      textInputAction: textInputAction,
      onChanged: onChange,
      keyboardType: keyboardType,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: VanillaColorScheme.black,
          ),
      cursorColor: VanillaColorScheme.dark,
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: VanillaColorScheme.light,
            width: 0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: VanillaColorScheme.error,
            width: 0,
          ),
        ),
        errorText: errorText,
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: VanillaColorScheme.black.withOpacity(0.4),
            ),
        filled: true,
        fillColor: VanillaColorScheme.light,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: VanillaColorScheme.error,
            width: 0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: VanillaColorScheme.light,
            width: 0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: VanillaColorScheme.light,
            width: 0,
          ),
        ),
      ),
    );
  }
}
