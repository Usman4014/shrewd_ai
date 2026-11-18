



import 'package:material_ui/material_ui.dart';
import 'package:shrewd_ai/core/theme/app_design_tokens.dart';

class AppDropdown<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> items;
  final String Function(T) itemLabel;
  final ValueChanged<T?> onChanged;
  final String? hint;
  final String? Function(T?)? validator;
  final bool required;
  final bool enabled;

  const AppDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
    this.hint,
    this.validator,
    this.required = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          required ? '$label *' : label,
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(
          height: AppDesignTokens.spacingSmall,
        ),
        DropdownButtonFormField<T>(
          initialValue: value,
          isExpanded: true,
          decoration: InputDecoration(
            hintText: hint,
          ),
          dropdownColor: theme.colorScheme.surface,
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(
                itemLabel(item),
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: enabled ? onChanged : null,
          validator: validator,
        ),
      ],
    );
  }
}
