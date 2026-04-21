import 'package:flutter/material.dart';
import 'package:opn_form/logicdto.dart';
import 'package:opn_form/model/form_field.dart';
import 'package:opn_form/widget/check_box_field_widget.dart';
import 'package:opn_form/widget/date_field_widget.dart';
import 'package:opn_form/widget/email_field_widget.dart';
import 'package:opn_form/widget/files_field_widget.dart';
import 'package:opn_form/widget/multi_select_field_widget.dart';
import 'package:opn_form/widget/number_field_widget.dart';
import 'package:opn_form/widget/phone_field_widget.dart';
import 'package:opn_form/widget/select_field_widget.dart';
import 'package:opn_form/widget/text_field_widget.dart';
import 'package:opn_form/widget/url_field_widget.dart';

class DynamicForm extends StatelessWidget {
  const DynamicForm({super.key});

  @override
  Widget build(BuildContext context) {
    List<FormFieldDto> formField = [];

    try {
      formField = formJson.map((e) {
        return FormFieldDto.fromJson(e);
      }).toList();
    } catch (e, stack) {
      debugPrint("Form parsing error: $e");
      debugPrint("$stack");
    }
    return FieldWrapper(field: formField);
  }
}

class FieldWrapper extends StatefulWidget {
  final List<FormFieldDto> field;
  const FieldWrapper({super.key, required this.field});

  @override
  State<FieldWrapper> createState() => _FieldWrapperState();
}

class _FieldWrapperState extends State<FieldWrapper> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: widget.field.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: _buildField(item),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildField(FormFieldDto field) {
    switch (field.type) {
      case 'text':
        return TextFieldWidget(field: field);
      case 'date':
        return DateFieldWidget(field: field);
      case 'url':
        return UrlFieldWidget(field: field);
      case 'phone_number':
        return PhoneFieldWidget(field: field);
      case 'email':
        return EmailFieldWidget(field: field);
      case 'checkbox':
        return CheckBoxFieldWidget(field: field);
      case 'select':
        return SelectFieldWidget(field: field);
      case 'multi_select':
        return MultiSelectFieldWidget(field: field);
      case 'number':
        return NumberFieldWidget(field: field);
      case 'files':
        return FilesFieldWidget(field: field);
      default:
        return Text('Unsupported field type: ${field.type}');
    }
  }
}
