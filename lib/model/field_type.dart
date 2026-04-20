import 'package:opn_form/model/tree_node.dart';

sealed class FieldOperator {
  const FieldOperator();

  bool eval(dynamic input, dynamic value);

  factory FieldOperator.from(FieldType type, String raw) {
    switch (type) {
      case FieldType.text:
      case FieldType.url:
      case FieldType.email:
      case FieldType.phone:
        return StringFieldOperator(_mapStringOperator(raw));

      case FieldType.date:
        return DateFieldOperator(_mapDateOperator(raw));

      case FieldType.checkbox:
        return CheckboxFieldOperator(_mapCheckboxOperator(raw));

      case FieldType.select:
        return SelectFieldOperator(_mapSelectOperator(raw));

      case FieldType.multiSelect:
        return MultiSelectFieldOperator(_mapMultiSelectOperator(raw));

      case FieldType.number:
        return NumberFieldOperator(_mapNumberOperator(raw));

      case FieldType.files:
        return FilesFieldOperator(_mapFilesOperator(raw));
    }
  }
}

final class StringFieldOperator extends FieldOperator {
  final StringOperator operator;
  const StringFieldOperator(this.operator);

  @override
  bool eval(dynamic input, dynamic value) {
    switch (operator) {
      case StringOperator.equals:
        return input == value;
      case StringOperator.doesNotEqual:
        return input != value;
      case StringOperator.isEmpty:
        return input == null || input.isEmpty;
      case StringOperator.isNotEmpty:
        return input != null && input.isNotEmpty;
      case StringOperator.contains:
        return input?.contains(value) ?? false;
      case StringOperator.doesNotContains:
        return !(input?.contains(value) ?? true);
      case StringOperator.startsWith:
        return input?.startsWith(value) ?? false;
      case StringOperator.endsWith:
        return input?.endsWith(value) ?? false;
      case StringOperator.contentLengthEquals:
        return input?.length == value;
      case StringOperator.contentLengthDoesNotEqual:
        return input?.length != value;
      case StringOperator.contentLengthLessThan:
        return input?.length == null || (input ?? "").length < value;
      case StringOperator.contentLengthLessThanOrEqualTo:
        return input?.length == null || (input ?? "").length <= value;
      case StringOperator.contentLengthGreaterThan:
        return input?.length == null || (input ?? "").length > value;
      case StringOperator.contentLengthGreaterThanOrEqualTo:
        return input?.length == null || (input ?? "").length >= value;
    }
  }
}

final class DateFieldOperator extends FieldOperator {
  final DateOperator operator;
  const DateFieldOperator(this.operator);

  @override
  bool eval(dynamic input, dynamic value) {
    final inputDate = DateTime.tryParse(input ?? '');
    final compareDate = DateTime.tryParse(value);
    switch (operator) {
      case DateOperator.equals:
        return inputDate == compareDate;
      case DateOperator.doesNotEqual:
        return inputDate != compareDate;
      case DateOperator.isEmpty:
        return inputDate == null || inputDate.toString().isEmpty;
      case DateOperator.isNotEmpty:
        return inputDate != null && inputDate.toString().isNotEmpty;
      case DateOperator.before:
        return input != null &&
            compareDate != null &&
            inputDate!.isBefore(compareDate);
      case DateOperator.after:
        return input != null &&
            compareDate != null &&
            inputDate!.isAfter(compareDate);
      case DateOperator.onOrBefore:
        return inputDate != null &&
            compareDate != null &&
            (inputDate.isBefore(compareDate) || inputDate == compareDate);
      case DateOperator.nextMonth:
        if (inputDate == null) return false;
        final now = DateTime.now();

        final nextMonth = now.month == 12 ? 1 : now.month + 1;
        final nextMonthYear = (now.month == 12) ? now.year + 1 : now.year;

        return inputDate.month == nextMonth && inputDate.year == nextMonthYear;
      case DateOperator.nextWeek:
        if (inputDate == null) return false;
        final now = DateTime.now();
        final nextWeek = now.add(const Duration(days: 7));
        return inputDate.isAfter(now) && inputDate.isBefore(nextWeek);
      case DateOperator.nextYear:
        if (inputDate == null) return false;
        final now = DateTime.now();
        final nextYear = now.year + 1;
        return inputDate.year == nextYear;
      case DateOperator.pastWeek:
        if (inputDate == null) return false;
        final now = DateTime.now();
        final pastWeek = now.subtract(const Duration(days: 7));
        return inputDate.isBefore(now) && inputDate.isAfter(pastWeek);
      case DateOperator.pastMonth:
        if (inputDate == null) return false;
        final now = DateTime.now();
        final pastMonth = now.month == 1 ? 12 : now.month - 1;
        final pastMonthYear = (now.month == 1) ? now.year - 1 : now.year;
        return inputDate.month == pastMonth && inputDate.year == pastMonthYear;
      case DateOperator.pastYear:
        if (inputDate == null) return false;
        final now = DateTime.now();
        final pastYear = now.year - 1;
        return inputDate.year == pastYear;
      case DateOperator.onOrAfter:
        return inputDate != null &&
            compareDate != null &&
            (inputDate.isAfter(compareDate) || inputDate == compareDate);
    }
  }
}

final class CheckboxFieldOperator extends FieldOperator {
  final CheckBoxOperator operator;
  const CheckboxFieldOperator(this.operator);

  @override
  bool eval(dynamic input, dynamic value) {
    switch (operator) {
      case CheckBoxOperator.equals:
        return input == value;
      case CheckBoxOperator.doesNotEqual:
        return input != value;
    }
  }
}

final class SelectFieldOperator extends FieldOperator {
  final SelectOperator operator;
  const SelectFieldOperator(this.operator);

  @override
  bool eval(dynamic input, dynamic value) {
    switch (operator) {
      case SelectOperator.equals:
        return input == value;
      case SelectOperator.doesNotEqual:
        return input != value;
      case SelectOperator.isEmpty:
        return input == null || input.isEmpty;
      case SelectOperator.isNotEmpty:
        return input != null && input.isNotEmpty;
    }
  }
}

final class MultiSelectFieldOperator extends FieldOperator {
  final MultiSelectOperator operator;
  const MultiSelectFieldOperator(this.operator);

  @override
  bool eval(dynamic input, dynamic value) {
    switch (operator) {
      case MultiSelectOperator.equals:
        return input == value;
      case MultiSelectOperator.doesNotEqual:
        return input != value;
      case MultiSelectOperator.contains:
        return input?.contains(value) ?? false;
      case MultiSelectOperator.doesNotContains:
        return !(input?.contains(value) ?? true);
    }
  }
}

final class NumberFieldOperator extends FieldOperator {
  final NumberOperator operator;
  const NumberFieldOperator(this.operator);

  @override
  bool eval(dynamic input, dynamic value) {
    final num? numInput = input as num?;
    switch (operator) {
      case NumberOperator.equals:
        return numInput == value;
      case NumberOperator.doesNotEqual:
        return numInput != value;
      case NumberOperator.greaterThan:
        return numInput != null && numInput > value;
      case NumberOperator.greaterThanOrEqualTo:
        return numInput != null && numInput >= value;
      case NumberOperator.lessThan:
        return numInput != null && numInput < value;
      case NumberOperator.lessThanOrEqualTo:
        return numInput != null && numInput <= value;
      case NumberOperator.isEmpty:
        return numInput == null || numInput.toString().isEmpty;
      case NumberOperator.isNotEmpty:
        return numInput != null;
      default:
        return false;
    }
  }
}

final class FilesFieldOperator extends FieldOperator {
  final FilesOperator operator;
  const FilesFieldOperator(this.operator);

  @override
  bool eval(dynamic input, dynamic value) {
    final List? files = input as List?;

    switch (operator) {
      case FilesOperator.isEmpty:
        return files == null || files.isEmpty;
      case FilesOperator.isNotEmpty:
        return files != null && files.isNotEmpty;
    }
  }
}

StringOperator _mapStringOperator(String value) {
  return StringOperator.values.firstWhere((e) => e.value == value);
}

DateOperator _mapDateOperator(String value) {
  return DateOperator.values.firstWhere((e) => e.value == value);
}

CheckBoxOperator _mapCheckboxOperator(String value) {
  return CheckBoxOperator.values.firstWhere((e) => e.value == value);
}

SelectOperator _mapSelectOperator(String value) {
  return SelectOperator.values.firstWhere((e) => e.value == value);
}

MultiSelectOperator _mapMultiSelectOperator(String value) {
  return MultiSelectOperator.values.firstWhere((e) => e.value == value);
}

NumberOperator _mapNumberOperator(String value) {
  return NumberOperator.values.firstWhere((e) => e.value == value);
}

FilesOperator _mapFilesOperator(String value) {
  return FilesOperator.values.firstWhere((e) => e.value == value);
}
