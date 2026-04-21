import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:opn_form/model/state_provider.dart';
import '../field_widgets.dart';

class CheckBoxFieldWidget extends BaseFormFieldWidget {
  const CheckBoxFieldWidget({super.key, required super.field});

  @override
  Widget buildField(
    BuildContext context,
    WidgetRef ref, {
    required bool isRequired,
    required bool isDisabled,
    required bool isHidden,
  }) {
    final bool? value = ref.read(
      formDataProvider.select((value) {
        return value[field.id];
      }),
    );
    return FormField<bool?>(
      initialValue: value,
      builder: (checkBoxState) {
        return CheckboxListTile(
          title: Text(field.name ?? ''),
          value: checkBoxState.value ?? false,
          onChanged: isDisabled
              ? null
              : (val) {
                  checkBoxState.didChange(val);
                  ref
                      .read(formDataProvider.notifier)
                      .updateValue(field.id!, val);
                },
        );
      },
    );
  }
}
