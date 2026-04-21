import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../field_widgets.dart';
import 'package:opn_form/model/state_provider.dart';

class MultiSelectFieldWidget extends BaseFormFieldWidget {
  const MultiSelectFieldWidget({super.key, required super.field});

  @override
  Widget buildField(
    BuildContext context,
    WidgetRef ref, {
    required bool isRequired,
    required bool isDisabled,
    required bool isHidden,
  }) {
    final List<String?>? selectedValues = ref.read(
      formDataProvider.select((value) {
        return value[field.id];
      }),
    );

    final options = field.multiSelect?.options ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            field.name ?? '',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        FormField<List<String?>>(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          initialValue: selectedValues,
          validator: (value) {
            if (isRequired && (value == null || value.isEmpty)) {
              return "This field is required";
            }
            return null;
          },
          builder: (multiSelectFieldState) {
            final currentValues = multiSelectFieldState.value ?? [];

            void updateValues(List<String?> updated) {
              multiSelectFieldState.didChange(updated);

              if (updated.isEmpty) {
                ref.read(formDataProvider.notifier).removeValue(field.id!);
              } else {
                ref
                    .read(formDataProvider.notifier)
                    .updateValue(field.id!, updated);
              }
            }

            return Wrap(
              spacing: 8,
              children: options.map((opt) {
                final isSelected =
                    multiSelectFieldState.value?.contains(opt.id) ?? false;

                return FilterChip(
                  label: Text(opt.name ?? ''),
                  selected: isSelected,
                  onSelected: isDisabled
                      ? null
                      : (selected) {
                          final updated = isSelected
                              ? currentValues.where((v) => v != opt.id).toList()
                              : [...currentValues, opt.id];

                          updateValues(updated);
                        },
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
