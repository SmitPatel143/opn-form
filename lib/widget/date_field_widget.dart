import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:opn_form/model/state_provider.dart';
import '../field_widgets.dart';

class DateFieldWidget extends BaseFormFieldWidget {
  const DateFieldWidget({super.key, required super.field});

  @override
  Widget buildField(BuildContext context, WidgetRef ref,
      {required bool isRequired,
      required bool isDisabled,
      required bool isHidden}) {
    debugPrint("date field widget rebuild");
    final value = ref.watch(
      formDataProvider.select((value) {
        return value[field.id!];
      },));

    return ListTile(
      title: Text(field.name ?? 'Date'),
      subtitle: Text(value ?? 'Select Date'),
      enabled: !isDisabled,
      trailing: const Icon(Icons.calendar_today),
      onTap: isDisabled
          ? null
          : () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (date != null) {
                ref
                    .read(formDataProvider.notifier)
                    .updateValue(field.id!, date.toIso8601String().split('T')[0]);
              }
            },
    );
  }
}
