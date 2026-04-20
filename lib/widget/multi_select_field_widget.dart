import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../field_widgets.dart';
import 'package:opn_form/model/state_provider.dart';

class MultiSelectFieldWidget extends BaseFormFieldWidget {
  const MultiSelectFieldWidget({super.key, required super.field});

  @override
  Widget buildField(BuildContext context, WidgetRef ref,
      {required bool isRequired,
      required bool isDisabled,
      required bool isHidden}) {
    final selectedValues = ref.read(formDataProvider)[field.id!];

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
        Wrap(
          spacing: 8,
          children: options.map((opt) {
            final isSelected = selectedValues?.contains(opt.id) ?? false;

            return FilterChip(
              label: Text(opt.name ?? ''),
              selected: isSelected,
              onSelected: isDisabled
                  ? null
                  : (selected) {
                      if (selected) {
                        ref.read(formDataProvider.notifier).updateValue(
                          field.id!,
                          [...selectedValues, opt.id],
                        );
                      } else {
                        ref
                            .read(formDataProvider.notifier)
                            .updateValue(
                              field.id!,
                              selectedValues.where((v) => v != opt.id).toList(),
                            );
                      }
                    },
            );
          }).toList(),
        ),
      ],
    );
  }
}
