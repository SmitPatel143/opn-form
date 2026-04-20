import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:opn_form/model/state_provider.dart';
import '../field_widgets.dart';

class FilesFieldWidget extends BaseFormFieldWidget {
  const FilesFieldWidget({super.key, required super.field});

  @override
  Widget buildField(BuildContext context, WidgetRef ref,
      {required bool isRequired,
      required bool isDisabled,
      required bool isHidden}) {
    final files = ref.read(formDataProvider)[field.id!];

    return ListTile(
      title: Text(field.name ?? 'Files'),
      subtitle: Text('${files?.length} files selected'),
      enabled: !isDisabled,
      trailing: const Icon(Icons.attach_file),
      onTap: isDisabled
          ? null
          : () {
              ref.read(formDataProvider.notifier).updateValue(field.id!, [
                ...files,
                'file_${files.length + 1}.pdf',
              ]);
            },
    );
  }
}
