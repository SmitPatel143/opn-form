import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../field_widgets.dart';
import 'package:opn_form/model/state_provider.dart';

class TextFieldWidget extends BaseFormFieldWidget {
  const TextFieldWidget({super.key, required super.field});

  @override
  Widget buildField(BuildContext context, WidgetRef ref,
      {required bool isRequired,
      required bool isDisabled,
      required bool isHidden}) {
    final value = ref.read(
      formDataProvider.select((state) => state[field.id]),
    );

    return TextFormField(
      initialValue: value as String?,
      enabled: !isDisabled,
      decoration: InputDecoration(
        labelText: field.name,
        helperText: field.helpPosition == 'below_input'
            ? 'Help for ${field.name}'
            : null,
      ),
      validator: (val) {
        if (isRequired && (val == null || val.isEmpty)) {
          return "Field is required";
        }
        return null;
      },
      onChanged: (val) {
        ref
            .read(formDataProvider.notifier)
            .updateValue(field.id!, val);
      },
    );
  }
}