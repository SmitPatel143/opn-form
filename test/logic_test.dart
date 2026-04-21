import 'package:flutter_test/flutter_test.dart';
import 'package:opn_form/model/field_type.dart';
import 'package:opn_form/model/form_field.dart';
import 'package:opn_form/model/tree_node.dart';

void main() {
  // ──────────────────────────────────────────────────────────────────────────
  // 1. STRING FIELD OPERATOR — covers text, url, email, phone
  // ──────────────────────────────────────────────────────────────────────────
  group('StringFieldOperator', () {
    test('equals — true when strings match', () {
      const op = StringFieldOperator(StringOperator.equals);
      expect(op.eval('hello', 'hello'), isTrue);
      expect(op.eval('hello', 'world'), isFalse);
      expect(op.eval(null, 'hello'), isFalse);
      expect(op.eval('', ''), isTrue);
    });

    test('doesNotEqual — true when strings differ', () {
      const op = StringFieldOperator(StringOperator.doesNotEqual);
      expect(op.eval('hello', 'world'), isTrue);
      expect(op.eval('hello', 'hello'), isFalse);
      expect(op.eval(null, 'hello'), isTrue);
    });

    test('isEmpty — true when input is null or empty string', () {
      const op = StringFieldOperator(StringOperator.isEmpty);
      expect(op.eval(null, null), isTrue);
      expect(op.eval('', null), isTrue);
      expect(op.eval('hello', null), isFalse);
    });

    test('isNotEmpty — true when input has content', () {
      const op = StringFieldOperator(StringOperator.isNotEmpty);
      expect(op.eval('hello', null), isTrue);
      expect(op.eval('', null), isFalse);
      expect(op.eval(null, null), isFalse);
    });

    test('contains — true when input contains the value', () {
      const op = StringFieldOperator(StringOperator.contains);
      expect(op.eval('hello world', 'world'), isTrue);
      expect(op.eval('hello', 'xyz'), isFalse);
      expect(op.eval(null, 'xyz'), isFalse);
    });

    test('doesNotContains — true when input does NOT contain value', () {
      const op = StringFieldOperator(StringOperator.doesNotContains);
      expect(op.eval('hello', 'xyz'), isTrue);
      expect(op.eval('hello world', 'world'), isFalse);
      expect(op.eval(null, 'xyz'), isFalse); // null → contains returns true via ?? true → negated
    });

    test('startsWith — true when input starts with value', () {
      const op = StringFieldOperator(StringOperator.startsWith);
      expect(op.eval('hello world', 'hello'), isTrue);
      expect(op.eval('hello world', 'world'), isFalse);
      expect(op.eval(null, 'hello'), isFalse);
    });

    test('endsWith — true when input ends with value', () {
      const op = StringFieldOperator(StringOperator.endsWith);
      expect(op.eval('hello world', 'world'), isTrue);
      expect(op.eval('hello world', 'hello'), isFalse);
      expect(op.eval(null, 'world'), isFalse);
    });

    test('contentLengthEquals — matches exact length', () {
      const op = StringFieldOperator(StringOperator.contentLengthEquals);
      expect(op.eval('hello', 5), isTrue);
      expect(op.eval('hello', 3), isFalse);
      expect(op.eval('', 0), isTrue);
    });

    test('contentLengthDoesNotEqual — true when lengths differ', () {
      const op = StringFieldOperator(StringOperator.contentLengthDoesNotEqual);
      expect(op.eval('hello', 3), isTrue);
      expect(op.eval('hello', 5), isFalse);
    });

    test('contentLengthGreaterThan', () {
      const op = StringFieldOperator(StringOperator.contentLengthGreaterThan);
      expect(op.eval('hello', 2), isTrue);
      expect(op.eval('hi', 5), isFalse);
      expect(op.eval('hi', 2), isFalse); // equal → not greater
    });

    test('contentLengthGreaterThanOrEqualTo', () {
      const op = StringFieldOperator(StringOperator.contentLengthGreaterThanOrEqualTo);
      expect(op.eval('hello', 5), isTrue);
      expect(op.eval('hello', 3), isTrue);
      expect(op.eval('hi', 5), isFalse);
    });

    test('contentLengthLessThan', () {
      const op = StringFieldOperator(StringOperator.contentLengthLessThan);
      expect(op.eval('hi', 5), isTrue);
      expect(op.eval('hello', 3), isFalse);
      expect(op.eval('hi', 2), isFalse); // equal → not less
    });

    test('contentLengthLessThanOrEqualTo', () {
      const op = StringFieldOperator(StringOperator.contentLengthLessThanOrEqualTo);
      expect(op.eval('hi', 5), isTrue);
      expect(op.eval('hi', 2), isTrue);
      expect(op.eval('hello', 3), isFalse);
    });
  });

  // ──────────────────────────────────────────────────────────────────────────
  // 2. DATE FIELD OPERATOR
  // ──────────────────────────────────────────────────────────────────────────
  group('DateFieldOperator', () {
    test('equals — date-only comparison', () {
      const op = DateFieldOperator(DateOperator.equals);
      expect(op.eval('2023-10-01T10:00:00', '2023-10-01'), isTrue);
      expect(op.eval('2023-10-01', '2023-10-01'), isTrue);
      expect(op.eval('2023-10-01', '2023-10-02'), isFalse);
      expect(op.eval(null, '2023-10-01'), isFalse);
    });

    test('doesNotEqual', () {
      const op = DateFieldOperator(DateOperator.doesNotEqual);
      expect(op.eval('2023-10-01', '2023-10-02'), isTrue);
      expect(op.eval('2023-10-01', '2023-10-01'), isFalse);
    });

    test('isEmpty — true when input is null or unparseable', () {
      const op = DateFieldOperator(DateOperator.isEmpty);
      expect(op.eval(null, null), isTrue);
      expect(op.eval('', null), isTrue);
      expect(op.eval('not-a-date', null), isTrue);
      expect(op.eval('2023-10-01', null), isFalse);
    });

    test('isNotEmpty — true when input is a valid date', () {
      const op = DateFieldOperator(DateOperator.isNotEmpty);
      expect(op.eval('2023-10-01', null), isTrue);
      expect(op.eval(null, null), isFalse);
      expect(op.eval('', null), isFalse);
    });

    test('before — input date is before compare date', () {
      const op = DateFieldOperator(DateOperator.before);
      expect(op.eval('2023-09-01', '2023-10-01'), isTrue);
      expect(op.eval('2023-11-01', '2023-10-01'), isFalse);
      expect(op.eval(null, '2023-10-01'), isFalse);
    });

    test('after — input date is after compare date', () {
      const op = DateFieldOperator(DateOperator.after);
      expect(op.eval('2023-11-01', '2023-10-01'), isTrue);
      expect(op.eval('2023-09-01', '2023-10-01'), isFalse);
      expect(op.eval(null, '2023-10-01'), isFalse);
    });

    test('onOrBefore — on-same-day or before', () {
      const op = DateFieldOperator(DateOperator.onOrBefore);
      expect(op.eval('2023-09-30', '2023-10-01'), isTrue);
      expect(op.eval('2023-10-01', '2023-10-01'), isTrue);
      expect(op.eval('2023-10-02', '2023-10-01'), isFalse);
      expect(op.eval(null, '2023-10-01'), isFalse);
    });

    test('onOrAfter — on-same-day or after', () {
      const op = DateFieldOperator(DateOperator.onOrAfter);
      expect(op.eval('2023-10-02', '2023-10-01'), isTrue);
      expect(op.eval('2023-10-01', '2023-10-01'), isTrue);
      expect(op.eval('2023-09-30', '2023-10-01'), isFalse);
      expect(op.eval(null, '2023-10-01'), isFalse);
    });

    test('pastWeek — input is within the last 7 days', () {
      const op = DateFieldOperator(DateOperator.pastWeek);
      final now = DateTime.now();
      final threeDaysAgo = now.subtract(const Duration(days: 3));
      final tenDaysAgo = now.subtract(const Duration(days: 10));
      expect(op.eval(threeDaysAgo.toIso8601String(), null), isTrue);
      expect(op.eval(tenDaysAgo.toIso8601String(), null), isFalse);
      expect(op.eval(null, null), isFalse);
    });

    test('pastMonth — input is in last calendar month', () {
      const op = DateFieldOperator(DateOperator.pastMonth);
      final now = DateTime.now();
      final pastMonth = now.month == 1 ? 12 : now.month - 1;
      final pastMonthYear = (now.month == 1) ? now.year - 1 : now.year;
      final inPastMonth = DateTime(pastMonthYear, pastMonth, 15);
      expect(op.eval(inPastMonth.toIso8601String(), null), isTrue);
      expect(op.eval(now.toIso8601String(), null), isFalse);
      expect(op.eval(null, null), isFalse);
    });

    test('pastYear — input is in the previous calendar year', () {
      const op = DateFieldOperator(DateOperator.pastYear);
      final now = DateTime.now();
      final inPastYear = DateTime(now.year - 1, 6, 15);
      expect(op.eval(inPastYear.toIso8601String(), null), isTrue);
      expect(op.eval(now.toIso8601String(), null), isFalse);
      expect(op.eval(null, null), isFalse);
    });

    test('nextWeek — input is within the next 7 days', () {
      const op = DateFieldOperator(DateOperator.nextWeek);
      final now = DateTime.now();
      final threeDaysLater = now.add(const Duration(days: 3));
      final tenDaysLater = now.add(const Duration(days: 10));
      expect(op.eval(threeDaysLater.toIso8601String(), null), isTrue);
      expect(op.eval(tenDaysLater.toIso8601String(), null), isFalse);
      expect(op.eval(null, null), isFalse);
    });

    test('nextMonth — input is in next calendar month', () {
      const op = DateFieldOperator(DateOperator.nextMonth);
      final now = DateTime.now();
      final nextMonth = now.month == 12 ? 1 : now.month + 1;
      final nextMonthYear = (now.month == 12) ? now.year + 1 : now.year;
      final inNextMonth = DateTime(nextMonthYear, nextMonth, 15);
      expect(op.eval(inNextMonth.toIso8601String(), null), isTrue);
      expect(op.eval(now.toIso8601String(), null), isFalse);
      expect(op.eval(null, null), isFalse);
    });

    test('nextYear — input is in the next calendar year', () {
      const op = DateFieldOperator(DateOperator.nextYear);
      final now = DateTime.now();
      final inNextYear = DateTime(now.year + 1, 6, 15);
      expect(op.eval(inNextYear.toIso8601String(), null), isTrue);
      expect(op.eval(now.toIso8601String(), null), isFalse);
      expect(op.eval(null, null), isFalse);
    });
  });

  // ──────────────────────────────────────────────────────────────────────────
  // 3. CHECKBOX FIELD OPERATOR
  // ──────────────────────────────────────────────────────────────────────────
  group('CheckboxFieldOperator', () {
    test('equals — true when booleans match', () {
      const op = CheckboxFieldOperator(CheckBoxOperator.equals);
      expect(op.eval(true, true), isTrue);
      expect(op.eval(false, false), isTrue);
      expect(op.eval(true, false), isFalse);
      expect(op.eval(false, true), isFalse);
    });

    test('doesNotEqual — true when booleans differ', () {
      const op = CheckboxFieldOperator(CheckBoxOperator.doesNotEqual);
      expect(op.eval(true, false), isTrue);
      expect(op.eval(false, true), isTrue);
      expect(op.eval(true, true), isFalse);
      expect(op.eval(false, false), isFalse);
    });
  });

  // ──────────────────────────────────────────────────────────────────────────
  // 4. SELECT FIELD OPERATOR
  // ──────────────────────────────────────────────────────────────────────────
  group('SelectFieldOperator', () {
    test('equals', () {
      const op = SelectFieldOperator(SelectOperator.equals);
      expect(op.eval('option_a', 'option_a'), isTrue);
      expect(op.eval('option_a', 'option_b'), isFalse);
    });

    test('doesNotEqual', () {
      const op = SelectFieldOperator(SelectOperator.doesNotEqual);
      expect(op.eval('option_a', 'option_b'), isTrue);
      expect(op.eval('option_a', 'option_a'), isFalse);
    });

    test('isEmpty', () {
      const op = SelectFieldOperator(SelectOperator.isEmpty);
      expect(op.eval(null, null), isTrue);
      expect(op.eval('', null), isTrue);
      expect(op.eval('option_a', null), isFalse);
    });

    test('isNotEmpty', () {
      const op = SelectFieldOperator(SelectOperator.isNotEmpty);
      expect(op.eval('option_a', null), isTrue);
      expect(op.eval('', null), isFalse);
      expect(op.eval(null, null), isFalse);
    });
  });

  // ──────────────────────────────────────────────────────────────────────────
  // 5. MULTI-SELECT FIELD OPERATOR
  // ──────────────────────────────────────────────────────────────────────────
  group('MultiSelectFieldOperator', () {
    test('contains — input list contains the value', () {
      const op = MultiSelectFieldOperator(MultiSelectOperator.contains);
      expect(op.eval(['a', 'b', 'c'], 'b'), isTrue);
      expect(op.eval(['a', 'b', 'c'], 'z'), isFalse);
      expect(op.eval(null, 'a'), isFalse);
    });

    test('doesNotContains — input list does NOT contain value', () {
      const op = MultiSelectFieldOperator(MultiSelectOperator.doesNotContains);
      expect(op.eval(['a', 'b'], 'z'), isTrue);
      expect(op.eval(['a', 'b'], 'a'), isFalse);
      expect(op.eval(null, 'a'), isFalse); // null → contains returns true via ?? true → negated
    });
  });

  // ──────────────────────────────────────────────────────────────────────────
  // 6. NUMBER FIELD OPERATOR
  // ──────────────────────────────────────────────────────────────────────────
  group('NumberFieldOperator', () {
    test('equals', () {
      const op = NumberFieldOperator(NumberOperator.equals);
      expect(op.eval(10, 10), isTrue);
      expect(op.eval(10, 20), isFalse);
      expect(op.eval('10', 10), isTrue); // string parsed to num
      expect(op.eval(null, null), isTrue);
    });

    test('doesNotEqual', () {
      const op = NumberFieldOperator(NumberOperator.doesNotEqual);
      expect(op.eval(10, 20), isTrue);
      expect(op.eval(10, 10), isFalse);
    });

    test('greaterThan', () {
      const op = NumberFieldOperator(NumberOperator.greaterThan);
      expect(op.eval(10, 5), isTrue);
      expect(op.eval(5, 10), isFalse);
      expect(op.eval(10, 10), isFalse);
      expect(op.eval(null, 5), isFalse);
    });

    test('greaterThanOrEqualTo', () {
      const op = NumberFieldOperator(NumberOperator.greaterThanOrEqualTo);
      expect(op.eval(10, 5), isTrue);
      expect(op.eval(10, 10), isTrue);
      expect(op.eval(5, 10), isFalse);
    });

    test('lessThan', () {
      const op = NumberFieldOperator(NumberOperator.lessThan);
      expect(op.eval(5, 10), isTrue);
      expect(op.eval(10, 5), isFalse);
      expect(op.eval(10, 10), isFalse);
    });

    test('lessThanOrEqualTo', () {
      const op = NumberFieldOperator(NumberOperator.lessThanOrEqualTo);
      expect(op.eval(5, 10), isTrue);
      expect(op.eval(10, 10), isTrue);
      expect(op.eval(10, 5), isFalse);
    });

    test('isEmpty', () {
      const op = NumberFieldOperator(NumberOperator.isEmpty);
      expect(op.eval(null, null), isTrue);
      expect(op.eval('', null), isTrue); // unparseable → null
      expect(op.eval(10, null), isFalse);
    });

    test('isNotEmpty', () {
      const op = NumberFieldOperator(NumberOperator.isNotEmpty);
      expect(op.eval(10, null), isTrue);
      expect(op.eval('42', null), isTrue);
      expect(op.eval(null, null), isFalse);
    });

    test('contentLengthEquals', () {
      const op = NumberFieldOperator(NumberOperator.contentLengthEquals);
      expect(op.eval(100, 3), isTrue);   // "100".length == 3
      expect(op.eval(1000, 3), isFalse); // "1000".length == 4
      expect(op.eval('123.45', 6), isTrue); // "123.45".length == 6
    });

    test('contentLengthDoesNotEqual', () {
      const op = NumberFieldOperator(NumberOperator.contentLengthDoesNotEqual);
      expect(op.eval(100, 5), isTrue);
      expect(op.eval(100, 3), isFalse);
    });

    test('contentLengthGreaterThan', () {
      const op = NumberFieldOperator(NumberOperator.contentLengthGreaterThan);
      expect(op.eval(1000, 3), isTrue);  // "1000".length=4 > 3
      expect(op.eval(10, 3), isFalse);   // "10".length=2 < 3
    });

    test('contentLengthGreaterThanOrEqualTo', () {
      const op = NumberFieldOperator(NumberOperator.contentLengthGreaterThanOrEqualTo);
      expect(op.eval(100, 3), isTrue);   // 3 >= 3
      expect(op.eval(1000, 3), isTrue);  // 4 >= 3
      expect(op.eval(10, 3), isFalse);   // 2 < 3
    });

    test('contentLengthLessThan', () {
      const op = NumberFieldOperator(NumberOperator.contentLengthLessThan);
      expect(op.eval(10, 3), isTrue);    // "10".length=2 < 3
      expect(op.eval(100, 3), isFalse);  // 3 == 3
    });

    test('contentLengthLessThanOrEqualTo', () {
      const op = NumberFieldOperator(NumberOperator.contentLengthLessThanOrEqualTo);
      expect(op.eval(10, 3), isTrue);    // 2 <= 3
      expect(op.eval(100, 3), isTrue);   // 3 <= 3
      expect(op.eval(1000, 3), isFalse); // 4 > 3
    });
  });

  // ──────────────────────────────────────────────────────────────────────────
  // 7. FILES FIELD OPERATOR
  // ──────────────────────────────────────────────────────────────────────────
  group('FilesFieldOperator', () {
    test('isEmpty — true when no files', () {
      const op = FilesFieldOperator(FilesOperator.isEmpty);
      expect(op.eval(null, null), isTrue);
      expect(op.eval([], null), isTrue);
      expect(op.eval(['file1.jpg'], null), isFalse);
    });

    test('isNotEmpty — true when files exist', () {
      const op = FilesFieldOperator(FilesOperator.isNotEmpty);
      expect(op.eval(['file1.jpg'], null), isTrue);
      expect(op.eval(['a', 'b'], null), isTrue);
      expect(op.eval(null, null), isFalse);
      expect(op.eval([], null), isFalse);
    });
  });

  // ──────────────────────────────────────────────────────────────────────────
  // 8. FieldOperator.from FACTORY — ensures correct mapping for every type
  // ──────────────────────────────────────────────────────────────────────────
  group('FieldOperator.from factory', () {
    test('text type maps to StringFieldOperator', () {
      final op = FieldOperator.from(FieldType.text, 'equals');
      expect(op, isA<StringFieldOperator>());
      expect(op.eval('abc', 'abc'), isTrue);
    });

    test('url type maps to StringFieldOperator', () {
      final op = FieldOperator.from(FieldType.url, 'contains');
      expect(op, isA<StringFieldOperator>());
      expect(op.eval('https://example.com', 'example'), isTrue);
    });

    test('email type maps to StringFieldOperator', () {
      final op = FieldOperator.from(FieldType.email, 'ends');
      expect(op, isA<StringFieldOperator>());
      expect(op.eval('user@gmail.com', 'gmail.com'), isTrue);
    });

    test('phone type maps to StringFieldOperator', () {
      final op = FieldOperator.from(FieldType.phone, 'starts_with');
      expect(op, isA<StringFieldOperator>());
      expect(op.eval('+91123', '+91'), isTrue);
    });

    test('date type maps to DateFieldOperator', () {
      final op = FieldOperator.from(FieldType.date, 'before');
      expect(op, isA<DateFieldOperator>());
    });

    test('checkbox type maps to CheckboxFieldOperator', () {
      final op = FieldOperator.from(FieldType.checkbox, 'equals');
      expect(op, isA<CheckboxFieldOperator>());
    });

    test('select type maps to SelectFieldOperator', () {
      final op = FieldOperator.from(FieldType.select, 'is_empty');
      expect(op, isA<SelectFieldOperator>());
    });

    test('multiSelect type maps to MultiSelectFieldOperator', () {
      final op = FieldOperator.from(FieldType.multiSelect, 'contains');
      expect(op, isA<MultiSelectFieldOperator>());
    });

    test('number type maps to NumberFieldOperator', () {
      final op = FieldOperator.from(FieldType.number, 'greater_than');
      expect(op, isA<NumberFieldOperator>());
    });

    test('files type maps to FilesFieldOperator', () {
      final op = FieldOperator.from(FieldType.files, 'is_empty');
      expect(op, isA<FilesFieldOperator>());
    });
  });

  // ──────────────────────────────────────────────────────────────────────────
  // 9. FieldType.fromJson PARSING
  // ──────────────────────────────────────────────────────────────────────────
  group('FieldType.fromJson', () {
    test('standard values', () {
      expect(FieldType.fromJson('text'), FieldType.text);
      expect(FieldType.fromJson('date'), FieldType.date);
      expect(FieldType.fromJson('url'), FieldType.url);
      expect(FieldType.fromJson('email'), FieldType.email);
      expect(FieldType.fromJson('checkbox'), FieldType.checkbox);
      expect(FieldType.fromJson('select'), FieldType.select);
      expect(FieldType.fromJson('number'), FieldType.number);
      expect(FieldType.fromJson('files'), FieldType.files);
    });

    test('special JSON keys remap correctly', () {
      expect(FieldType.fromJson('phone_number'), FieldType.phone);
      expect(FieldType.fromJson('multi_select'), FieldType.multiSelect);
    });
  });

  // ──────────────────────────────────────────────────────────────────────────
  // 10. ConditionActions.fromJson
  // ──────────────────────────────────────────────────────────────────────────
  group('ConditionActions.fromJson', () {
    test('maps all known action strings', () {
      expect(ConditionActions.fromJson('hide-block'), ConditionActions.hide);
      expect(ConditionActions.fromJson('require-answer'), ConditionActions.required);
      expect(ConditionActions.fromJson('disable-block'), ConditionActions.disabled);
    });

    test('unknown value falls back to disabled', () {
      expect(ConditionActions.fromJson('unknown-action'), ConditionActions.disabled);
    });
  });

  // ──────────────────────────────────────────────────────────────────────────
  // 11. LogicOperator.fromJson
  // ──────────────────────────────────────────────────────────────────────────
  group('LogicOperator.fromJson', () {
    test('maps known operators', () {
      expect(LogicOperator.fromJson('and'), LogicOperator.and);
      expect(LogicOperator.fromJson('or'), LogicOperator.or);
    });
  });

  // ──────────────────────────────────────────────────────────────────────────
  // 12. CONDITION TREE — buildTree + evaluateNode
  // ──────────────────────────────────────────────────────────────────────────
  group('ConditionNode.buildTree', () {
    test('single leaf condition builds correctly', () {
      final condition = Condition(
        id: 'leaf1',
        identifier: 'field_name',
        value: ConditionValue(
          operator: 'equals',
          value: 'hello',
          propertyMeta: PropertyMeta(id: 'pm1', type: 'text', name: 'Name'),
        ),
      );

      final node = ConditionNode.buildTree(condition);
      expect(node, isA<ConditionLeaf>());
      final leaf = node as ConditionLeaf;
      expect(leaf.fieldId, 'field_name');
      expect(leaf.fieldType, FieldType.text);
      expect(leaf.dependencies, {'field_name'});
    });

    test('AND group evaluates — all children must be true', () {
      final condition = Condition(
        id: 'group1',
        operatorIdentifier: 'and',
        children: [
          Condition(
            id: 'leaf1',
            identifier: 'field_a',
            value: ConditionValue(
              operator: 'equals',
              value: 'yes',
              propertyMeta: PropertyMeta(type: 'text'),
            ),
          ),
          Condition(
            id: 'leaf2',
            identifier: 'field_b',
            value: ConditionValue(
              operator: 'equals',
              value: 10,
              propertyMeta: PropertyMeta(type: 'number'),
            ),
          ),
        ],
      );

      final tree = ConditionNode.buildTree(condition);
      expect(tree, isA<ConditionGroup>());
      expect(tree.dependencies, {'field_a', 'field_b'});

      // Both match → true
      expect(tree.evaluateNode({'field_a': 'yes', 'field_b': 10}), isTrue);
      // One doesn't match → false
      expect(tree.evaluateNode({'field_a': 'yes', 'field_b': 20}), isFalse);
      // Neither matches → false
      expect(tree.evaluateNode({'field_a': 'no', 'field_b': 20}), isFalse);
    });

    test('OR group evaluates — any child true is enough', () {
      final condition = Condition(
        id: 'group1',
        operatorIdentifier: 'or',
        children: [
          Condition(
            id: 'leaf1',
            identifier: 'field_a',
            value: ConditionValue(
              operator: 'equals',
              value: 'yes',
              propertyMeta: PropertyMeta(type: 'text'),
            ),
          ),
          Condition(
            id: 'leaf2',
            identifier: 'field_b',
            value: ConditionValue(
              operator: 'equals',
              value: 10,
              propertyMeta: PropertyMeta(type: 'number'),
            ),
          ),
        ],
      );

      final tree = ConditionNode.buildTree(condition);

      // Both match → true
      expect(tree.evaluateNode({'field_a': 'yes', 'field_b': 10}), isTrue);
      // Only first matches → true
      expect(tree.evaluateNode({'field_a': 'yes', 'field_b': 20}), isTrue);
      // Only second matches → true
      expect(tree.evaluateNode({'field_a': 'no', 'field_b': 10}), isTrue);
      // Neither matches → false
      expect(tree.evaluateNode({'field_a': 'no', 'field_b': 20}), isFalse);
    });

    test('nested groups — AND inside OR', () {
      final condition = Condition(
        id: 'root',
        operatorIdentifier: 'or',
        children: [
          // child 1: AND group
          Condition(
            id: 'andGroup',
            operatorIdentifier: 'and',
            children: [
              Condition(
                id: 'l1',
                identifier: 'f1',
                value: ConditionValue(
                  operator: 'equals',
                  value: 'a',
                  propertyMeta: PropertyMeta(type: 'text'),
                ),
              ),
              Condition(
                id: 'l2',
                identifier: 'f2',
                value: ConditionValue(
                  operator: 'equals',
                  value: 'b',
                  propertyMeta: PropertyMeta(type: 'text'),
                ),
              ),
            ],
          ),
          // child 2: single leaf
          Condition(
            id: 'l3',
            identifier: 'f3',
            value: ConditionValue(
              operator: 'equals',
              value: true,
              propertyMeta: PropertyMeta(type: 'checkbox'),
            ),
          ),
        ],
      );

      final tree = ConditionNode.buildTree(condition);
      expect(tree.dependencies, {'f1', 'f2', 'f3'});

      // AND group true (f1=a AND f2=b) → OR true
      expect(tree.evaluateNode({'f1': 'a', 'f2': 'b', 'f3': false}), isTrue);

      // f3=true → OR true (even if AND group fails)
      expect(tree.evaluateNode({'f1': 'x', 'f2': 'x', 'f3': true}), isTrue);

      // Neither AND group nor f3 → false
      expect(tree.evaluateNode({'f1': 'x', 'f2': 'x', 'f3': false}), isFalse);
    });
  });

  // ──────────────────────────────────────────────────────────────────────────
  // 13. CONDITION TREE with different field types in leaves
  // ──────────────────────────────────────────────────────────────────────────
  group('ConditionTree with mixed field types', () {
    test('tree with date + select + number fields', () {
      final condition = Condition(
        id: 'root',
        operatorIdentifier: 'and',
        children: [
          Condition(
            id: 'dateLeaf',
            identifier: 'date_field',
            value: ConditionValue(
              operator: 'is_not_empty',
              value: null,
              propertyMeta: PropertyMeta(type: 'date'),
            ),
          ),
          Condition(
            id: 'selectLeaf',
            identifier: 'status',
            value: ConditionValue(
              operator: 'equals',
              value: 'active',
              propertyMeta: PropertyMeta(type: 'select'),
            ),
          ),
          Condition(
            id: 'numLeaf',
            identifier: 'quantity',
            value: ConditionValue(
              operator: 'greater_than',
              value: 0,
              propertyMeta: PropertyMeta(type: 'number'),
            ),
          ),
        ],
      );

      final tree = ConditionNode.buildTree(condition);

      // All pass
      expect(
        tree.evaluateNode({
          'date_field': '2023-10-01',
          'status': 'active',
          'quantity': 5,
        }),
        isTrue,
      );

      // Date empty → fails
      expect(
        tree.evaluateNode({
          'date_field': null,
          'status': 'active',
          'quantity': 5,
        }),
        isFalse,
      );

      // Wrong status → fails
      expect(
        tree.evaluateNode({
          'date_field': '2023-10-01',
          'status': 'inactive',
          'quantity': 5,
        }),
        isFalse,
      );

      // Quantity 0 → greaterThan fails
      expect(
        tree.evaluateNode({
          'date_field': '2023-10-01',
          'status': 'active',
          'quantity': 0,
        }),
        isFalse,
      );
    });

    test('tree with files + multiSelect + checkbox', () {
      final condition = Condition(
        id: 'root',
        operatorIdentifier: 'or',
        children: [
          Condition(
            id: 'filesLeaf',
            identifier: 'attachments',
            value: ConditionValue(
              operator: 'is_not_empty',
              value: null,
              propertyMeta: PropertyMeta(type: 'files'),
            ),
          ),
          Condition(
            id: 'msLeaf',
            identifier: 'tags',
            value: ConditionValue(
              operator: 'contains',
              value: 'urgent',
              propertyMeta: PropertyMeta(type: 'multi_select'),
            ),
          ),
          Condition(
            id: 'cbLeaf',
            identifier: 'agree',
            value: ConditionValue(
              operator: 'equals',
              value: true,
              propertyMeta: PropertyMeta(type: 'checkbox'),
            ),
          ),
        ],
      );

      final tree = ConditionNode.buildTree(condition);

      // Only files present → true
      expect(
        tree.evaluateNode({
          'attachments': ['file1.pdf'],
          'tags': [],
          'agree': false,
        }),
        isTrue,
      );

      // Only tags contain urgent → true
      expect(
        tree.evaluateNode({
          'attachments': [],
          'tags': ['urgent', 'low'],
          'agree': false,
        }),
        isTrue,
      );

      // Only checkbox true → true
      expect(
        tree.evaluateNode({
          'attachments': [],
          'tags': [],
          'agree': true,
        }),
        isTrue,
      );

      // Nothing matches → false
      expect(
        tree.evaluateNode({
          'attachments': [],
          'tags': ['low'],
          'agree': false,
        }),
        isFalse,
      );
    });

    test('tree with url/email/phone string operators', () {
      final condition = Condition(
        id: 'root',
        operatorIdentifier: 'and',
        children: [
          Condition(
            id: 'urlLeaf',
            identifier: 'website',
            value: ConditionValue(
              operator: 'starts_with',
              value: 'https://',
              propertyMeta: PropertyMeta(type: 'url'),
            ),
          ),
          Condition(
            id: 'emailLeaf',
            identifier: 'email',
            value: ConditionValue(
              operator: 'ends',
              value: '@company.com',
              propertyMeta: PropertyMeta(type: 'email'),
            ),
          ),
          Condition(
            id: 'phoneLeaf',
            identifier: 'phone',
            value: ConditionValue(
              operator: 'is_not_empty',
              value: null,
              propertyMeta: PropertyMeta(type: 'phone_number'),
            ),
          ),
        ],
      );

      final tree = ConditionNode.buildTree(condition);

      // All pass
      expect(
        tree.evaluateNode({
          'website': 'https://example.com',
          'email': 'user@company.com',
          'phone': '+911234567890',
        }),
        isTrue,
      );

      // URL doesn't start with https → fails
      expect(
        tree.evaluateNode({
          'website': 'http://example.com',
          'email': 'user@company.com',
          'phone': '+911234567890',
        }),
        isFalse,
      );

      // Email doesn't end with @company.com → fails
      expect(
        tree.evaluateNode({
          'website': 'https://example.com',
          'email': 'user@gmail.com',
          'phone': '+911234567890',
        }),
        isFalse,
      );

      // Phone empty → fails
      expect(
        tree.evaluateNode({
          'website': 'https://example.com',
          'email': 'user@company.com',
          'phone': '',
        }),
        isFalse,
      );
    });
  });

  // ──────────────────────────────────────────────────────────────────────────
  // 14. ConditionTree end-to-end via FormFieldDto
  // ──────────────────────────────────────────────────────────────────────────
  group('ConditionTree via FormFieldDto', () {
    test('FormFieldDto constructs conditionTree from logic JSON', () {
      final field = FormFieldDto(
        id: 'target_field',
        hidden: false,
        required: false,
        disabled: false,
        type: 'text',
        name: 'Target',
        logic: Logic(
          actions: ['hide-block'],
          conditions: Condition(
            id: 'root',
            operatorIdentifier: 'and',
            children: [
              Condition(
                id: 'c1',
                identifier: 'source_field',
                value: ConditionValue(
                  operator: 'equals',
                  value: 'trigger',
                  propertyMeta: PropertyMeta(type: 'text'),
                ),
              ),
            ],
          ),
        ),
      );

      expect(field.conditionTree, isNotNull);
      expect(field.conditionTree!.action, ConditionActions.hide);
      expect(
        field.conditionTree!.node.evaluateNode({'source_field': 'trigger'}),
        isTrue,
      );
      expect(
        field.conditionTree!.node.evaluateNode({'source_field': 'other'}),
        isFalse,
      );
    });

    test('FormFieldDto without logic has null conditionTree', () {
      final field = FormFieldDto(
        id: 'plain',
        hidden: false,
        required: false,
        disabled: false,
      );
      expect(field.conditionTree, isNull);
    });

    test('FormFieldDto with require-answer action', () {
      final field = FormFieldDto(
        id: 'req_field',
        hidden: false,
        required: false,
        disabled: false,
        logic: Logic(
          actions: ['require-answer'],
          conditions: Condition(
            id: 'c1',
            identifier: 'checkbox_field',
            value: ConditionValue(
              operator: 'equals',
              value: true,
              propertyMeta: PropertyMeta(type: 'checkbox'),
            ),
          ),
        ),
      );

      expect(field.conditionTree!.action, ConditionActions.required);
      expect(
        field.conditionTree!.node.evaluateNode({'checkbox_field': true}),
        isTrue,
      );
    });

    test('FormFieldDto with disable-block action', () {
      final field = FormFieldDto(
        id: 'dis_field',
        hidden: false,
        required: false,
        disabled: false,
        logic: Logic(
          actions: ['disable-block'],
          conditions: Condition(
            id: 'c1',
            identifier: 'num_field',
            value: ConditionValue(
              operator: 'less_than',
              value: 5,
              propertyMeta: PropertyMeta(type: 'number'),
            ),
          ),
        ),
      );

      expect(field.conditionTree!.action, ConditionActions.disabled);
      expect(
        field.conditionTree!.node.evaluateNode({'num_field': 3}),
        isTrue,
      );
      expect(
        field.conditionTree!.node.evaluateNode({'num_field': 10}),
        isFalse,
      );
    });
  });

  // ──────────────────────────────────────────────────────────────────────────
  // 15. EDGE CASES & NULL HANDLING
  // ──────────────────────────────────────────────────────────────────────────
  group('Edge cases', () {
    test('ConditionLeaf.evaluate with missing formData key returns false for equals', () {
      final leaf = ConditionLeaf(
        id: 'l1',
        fieldId: 'missing_key',
        fieldType: FieldType.text,
        operator: const StringFieldOperator(StringOperator.equals),
        value: 'something',
      );
      // formData doesn't have 'missing_key' → input is null
      expect(leaf.evaluate(null), isFalse);
    });

    test('evaluateNode with formData missing the key', () {
      final condition = Condition(
        id: 'c1',
        identifier: 'field_x',
        value: ConditionValue(
          operator: 'is_empty',
          value: null,
          propertyMeta: PropertyMeta(type: 'text'),
        ),
      );
      final node = ConditionNode.buildTree(condition);
      // field_x not in formData → null → isEmpty should be true
      expect(node.evaluateNode({}), isTrue);
    });

    test('number operator with string input', () {
      const op = NumberFieldOperator(NumberOperator.equals);
      expect(op.eval('42', '42'), isTrue);
      expect(op.eval('42', 42), isTrue);
    });

    test('number operator with non-numeric string returns isEmpty true', () {
      const op = NumberFieldOperator(NumberOperator.isEmpty);
      expect(op.eval('abc', null), isTrue);
    });

    test('deeply nested 3-level tree', () {
      final condition = Condition(
        id: 'root',
        operatorIdentifier: 'and',
        children: [
          Condition(
            id: 'or1',
            operatorIdentifier: 'or',
            children: [
              Condition(
                id: 'l1',
                identifier: 'a',
                value: ConditionValue(
                  operator: 'equals',
                  value: '1',
                  propertyMeta: PropertyMeta(type: 'text'),
                ),
              ),
              Condition(
                id: 'l2',
                identifier: 'b',
                value: ConditionValue(
                  operator: 'equals',
                  value: '2',
                  propertyMeta: PropertyMeta(type: 'text'),
                ),
              ),
            ],
          ),
          Condition(
            id: 'or2',
            operatorIdentifier: 'or',
            children: [
              Condition(
                id: 'l3',
                identifier: 'c',
                value: ConditionValue(
                  operator: 'equals',
                  value: '3',
                  propertyMeta: PropertyMeta(type: 'text'),
                ),
              ),
              Condition(
                id: 'l4',
                identifier: 'd',
                value: ConditionValue(
                  operator: 'equals',
                  value: '4',
                  propertyMeta: PropertyMeta(type: 'text'),
                ),
              ),
            ],
          ),
        ],
      );

      final tree = ConditionNode.buildTree(condition);
      expect(tree.dependencies, {'a', 'b', 'c', 'd'});

      // OR1 = true (a=1), OR2 = true (d=4) → AND = true
      expect(tree.evaluateNode({'a': '1', 'b': 'x', 'c': 'x', 'd': '4'}), isTrue);

      // OR1 = false, OR2 = true → AND = false
      expect(tree.evaluateNode({'a': 'x', 'b': 'x', 'c': '3', 'd': 'x'}), isFalse);

      // OR1 = true, OR2 = false → AND = false
      expect(tree.evaluateNode({'a': '1', 'b': 'x', 'c': 'x', 'd': 'x'}), isFalse);

      // Both OR groups true → AND true
      expect(tree.evaluateNode({'a': '1', 'b': '2', 'c': '3', 'd': '4'}), isTrue);
    });
  });
}
