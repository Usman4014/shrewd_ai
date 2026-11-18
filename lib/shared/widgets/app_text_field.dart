
import 'package:material_ui/material_ui.dart';

import 'package:shrewd_ai/core/theme/app_design_tokens.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String? hint;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final int maxLines;
  final int? maxLength;
  final bool required;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool readOnly;
  final ValueChanged<String>? onChanged;
  final EdgeInsetsGeometry? contentPadding;

  const AppTextField({
    super.key,
    required this.controller,
    this.label,
    this.hint,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.maxLength,
    this.required = false,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    this.onChanged,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            required ? '$label *' : label!,
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: AppDesignTokens.spacingSmall),
        ],
        SizedBox(
          height: maxLines == 1
              ? AppDesignTokens.inputHeight
              : null,
          child: TextFormField(
            controller: controller,
            validator: validator,
            keyboardType: keyboardType,
            maxLines: maxLines,
            maxLength: maxLength,
            readOnly: readOnly,
            onChanged: onChanged,
            style: theme.textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: hint,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              contentPadding: contentPadding,
              counterStyle: theme.textTheme.bodySmall,
            ),
          ),
        ),
      ],
    );
  }
}
