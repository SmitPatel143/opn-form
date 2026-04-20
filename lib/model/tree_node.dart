import 'package:flutter/cupertino.dart';
import 'package:opn_form/model/field_type.dart';
import 'package:opn_form/model/form_field.dart';

enum FieldType {
  text,
  date,
  url,
  phone,
  email,
  checkbox,
  select,
  multiSelect,
  number,
  files;

  factory FieldType.fromJson(String value) {
    switch (value) {
      case 'phone_number':
        return FieldType.phone;
      case 'multi_select':
        return FieldType.multiSelect;
      default:
        return FieldType.values.firstWhere((e) => e.name == value);
    }
  }
}

enum LogicOperator {
  and,
  or;

  factory LogicOperator.fromJson(String value) {
    return LogicOperator.values.firstWhere((element) => element.name == value);
  }
}


/// email, link, phoneNumber, textfeild
enum StringOperator {
  equals(value: 'equals'),
  doesNotEqual(value: 'does_not_equal'),
  isEmpty(value: 'is_empty'),
  isNotEmpty(value: 'is_not_empty'),
  contentLengthEquals(value: 'content_length_equals'),
  contentLengthDoesNotEqual(value: 'content_length_does_not_equal'),
  contentLengthGreaterThan(value: 'content_length_greater_than'),
  contentLengthGreaterThanOrEqualTo(value: 'content_length_greater_than_or_equal_to',),
  contentLengthLessThan(value: 'content_length_less_than'),
  contentLengthLessThanOrEqualTo(value: 'content_length_less_than_or_equal_to'),
  contains(value: 'contains'),
  doesNotContains(value: 'does_not_contain'),
  startsWith(value: 'starts_with'),
  endsWith(value: 'ends');

  final String value;

  const StringOperator({required this.value});
}

enum DateOperator {
  equals(value: 'equals'),
  isEmpty(value: 'is_empty'),
  isNotEmpty(value: 'is_not_empty'),
  before(value: 'before'),
  after(value: 'after'),
  onOrBefore(value: 'on_or_before'),
  onOrAfter(value: 'on_or_after'),
  pastWeek(value: 'past_week'),
  pastMonth(value: 'past_month'),
  pastYear(value: 'past_year'),
  nextWeek(value: 'next_week'),
  nextMonth(value: 'next_month'),
  nextYear(value: 'next_year'),

  doesNotEqual(value: 'does_not_equal');

  final String value;

  const DateOperator({required this.value});
}

enum CheckBoxOperator {
  equals(value: 'equals'),
  doesNotEqual(value: 'does_not_equal');

  final String value;

  const CheckBoxOperator({required this.value});
}

enum SelectOperator {
  equals(value: 'equals'),
  doesNotEqual(value: 'does_not_equal'),
  isEmpty(value: 'is_empty'),
  isNotEmpty(value: 'is_not_empty');

  final String value;

  const SelectOperator({required this.value});
}

enum MultiSelectOperator {
  equals(value: 'equals'),
  doesNotEqual(value: 'does_not_equal'),
  contains(value: 'contains'),
  doesNotContains(value: 'does_not_contain');

  final String value;

  const MultiSelectOperator({required this.value});
}

enum NumberOperator {
  equals(value: 'equals'),
  doesNotEqual(value: 'does_not_equal'),
  greaterThan(value: 'greater_than'),
  greaterThanOrEqualTo(value: 'greater_than_or_equal_to'),
  lessThan(value: 'less_than'),
  lessThanOrEqualTo(value: 'less_than_or_equal_to'),
  isEmpty(value: 'is_empty'),
  isNotEmpty(value: 'is_not_empty'),
  contentLengthEquals(value: 'content_length_equals'),
  contentLengthDoesNotEqual(value: 'content_length_does_not_equal'),
  contentLengthGreaterThan(value: 'content_length_greater_than'),
  contentLengthGreaterThanOrEqualTo(value: 'content_length_greater_than_or_equal_to',),
  contentLengthLessThan(value: 'content_length_less_than'),
  contentLengthLessThanOrEqualTo(value: 'content_length_less_than_or_equal_to');

  final String value;

  const NumberOperator({required this.value});
}

enum FilesOperator {
  isEmpty(value: 'is_empty'),
  isNotEmpty(value: 'is_not_empty');

  final String value;

  const FilesOperator({required this.value});
}

enum ConditionActions {
  hide("hide-block"),
  required("require-answer"),
  disabled("disable-block");

  final String value;

  const ConditionActions(this.value);

  factory ConditionActions.fromJson(String value) {
    return ConditionActions.values.firstWhere(
          (element) => element.value == value,
      orElse: () => ConditionActions.disabled,
    );
  }
}

final class ConditionTree {
  final ConditionNode node;
  final ConditionActions action;

  const ConditionTree({required this.action, required this.node});
}

sealed class ConditionNode {
  const ConditionNode();

  Set<String> get dependencies;

  bool evaluateNode(Map<String, dynamic> formData) {
    debugPrint("evaludating tree");
    switch (this) {
      case ConditionLeaf leaf:
        return leaf.evaluate(formData[leaf.fieldId]);
      case ConditionGroup group:
        return group.logicOperator == LogicOperator.and
            ? group.children.every((e) => e.evaluateNode(formData))
            : group.children.any((e) => e.evaluateNode(formData));
    }
  }

  static ConditionNode buildTree(Condition condition) {
    /// If it has operatorIdentifier → Parent Node
    if (condition.operatorIdentifier != null &&
        condition.operatorIdentifier!.isNotEmpty) {
      return ConditionGroup(
        children: condition.children!.map((e) => buildTree(e)).toList(),
        logicOperator: LogicOperator.fromJson(condition.operatorIdentifier!),
        id: condition.id!,
      );
    }
    /// Else → Leaf Node
    else {
      final fieldType = FieldType.fromJson(
        condition.value!.propertyMeta!.type!,
      );
      return ConditionLeaf(
        id: condition.id!,
        fieldId: condition.identifier!,
        fieldType: fieldType,
        operator: FieldOperator.from(fieldType, condition.value!.operator!),
        value: condition.value!.value,
      );
    }
  }
}

final class ConditionGroup extends ConditionNode {
  final String id;
  final LogicOperator logicOperator;
  final List<ConditionNode> children;

  late final Set<String> _dependencies = _buildDependencies();

  ConditionGroup({
    required this.children,
    required this.logicOperator,
    required this.id,
  });

  @override
  Set<String> get dependencies => _dependencies;

  Set<String> _buildDependencies() {
    final set = <String>{};
    for (var child in children) {
      set.addAll(child.dependencies);
    }
    return set;
  }
}

final class ConditionLeaf extends ConditionNode {
  final String id;
  final String fieldId;
  final FieldType fieldType;
  final FieldOperator operator;
  final dynamic value;

  const ConditionLeaf({
    required this.id,
    required this.fieldId,
    required this.fieldType,
    required this.operator,
    required this.value,
  });

  bool evaluate(dynamic inputValue) {
    return operator.eval(inputValue, value);
  }

  @override
  Set<String> get dependencies => {fieldId};
}
