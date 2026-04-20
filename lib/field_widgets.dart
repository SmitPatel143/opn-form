import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:opn_form/model/form_field.dart';
import 'package:opn_form/model/state_provider.dart';
import 'package:opn_form/model/tree_node.dart';

abstract class BaseFormFieldWidget extends ConsumerWidget {
  final FormFieldDto field;

  const BaseFormFieldWidget({super.key, required this.field});

  Widget buildField(BuildContext context, WidgetRef ref,
      {required bool isRequired,
      required bool isDisabled,
      required bool isHidden});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conditionTree = field.conditionTree;
    final action = conditionTree?.action;
    final deps = conditionTree?.node.dependencies ?? {};

    final Map<String, dynamic> relevantData = {};
    for (final dep in deps) {
      final val = ref.watch(
        formDataProvider.select((state) => state[dep]),
      );
      if (val != null) {
        relevantData[dep] = val;
      }
    }

    debugPrint("build method is called in field widget ${field.name}");

    // Evaluate conditions using only the relevant dependency data
    bool isRequired = false;
    bool isDisabled = false;
    bool isHidden = false;

    if (action != null) {
      final eval = conditionTree!.node.evaluateNode(relevantData);
      switch (action) {
        case ConditionActions.required:
          isRequired = eval;
          break;
        case ConditionActions.disabled:
          isDisabled = eval;
          break;
        case ConditionActions.hide:
          isHidden = eval;
          break;
      }
    }

    if (isHidden) return const SizedBox();

    return buildField(context, ref,
        isRequired: isRequired, isDisabled: isDisabled, isHidden: isHidden);
  }
}

