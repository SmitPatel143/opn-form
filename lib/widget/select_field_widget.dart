import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../field_widgets.dart';
import 'package:opn_form/model/state_provider.dart';

class SelectFieldWidget extends BaseFormFieldWidget {
  const SelectFieldWidget({super.key, required super.field});

  @override
  Widget buildField(
    BuildContext context,
    WidgetRef ref, {
    required bool isRequired,
    required bool isDisabled,
    required bool isHidden,
  }) {
    final value = ref.read(formDataProvider)[field.id!];

    final options = field.select?.options ?? [];

    return DropdownButtonFormField<String>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      initialValue: value,
      items: options
          .map(
            (opt) =>
                DropdownMenuItem(value: opt.id, child: Text(opt.name ?? '')),
          )
          .toList(),
      onChanged: isDisabled
          ? null
          : (val) {
              ref.read(formDataProvider.notifier).updateValue(field.id!, val);
            },
      decoration: InputDecoration(labelText: field.name),
      validator: (val) {
        if (isRequired && (val == null || val.isEmpty)) {
          return "This field is required";
        }
        return null;
      },
    );
  }
}
