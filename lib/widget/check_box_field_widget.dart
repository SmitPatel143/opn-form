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
    final value = ref.watch(
      formDataProvider.select((value) {
        return value[field.id];
      }),
    );
    debugPrint("build method invoked of checkbox");
    return CheckboxListTile(
      title: Text(field.name ?? ''),
      value: value ?? false,
      onChanged: isDisabled
          ? null
          : (value) {
              debugPrint("check box value in function: $value");
              ref.read(formDataProvider.notifier).updateValue(field.id!, value);
            },
    );
  }
}
