import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../field_widgets.dart';
import 'package:opn_form/model/state_provider.dart';

class UrlFieldWidget extends BaseFormFieldWidget {
  const UrlFieldWidget({super.key, required super.field});

  @override
  Widget buildField(BuildContext context, WidgetRef ref,
      {required bool isRequired,
      required bool isDisabled,
      required bool isHidden}) {
    final value = ref.read(formDataProvider)[field.id!];

    return TextFormField(
      initialValue: value as String?,
      enabled: !isDisabled,
      keyboardType: TextInputType.url,
      decoration: InputDecoration(
        labelText: field.name,
        prefixIcon: const Icon(Icons.link),
      ),
      validator: (val) {
        if (isRequired && (val == null || val.isEmpty)) {
          return "This field is required";
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