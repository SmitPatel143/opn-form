// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormFieldDto _$FormFieldDtoFromJson(Map<String, dynamic> json) => FormFieldDto(
  id: json['id'] as String?,
  type: json['type'] as String?,
  name: json['name'] as String?,
  hidden: json['hidden'] as bool?,
  logic: json['logic'] == null
      ? null
      : Logic.fromJson(json['logic'] as Map<String, dynamic>),
);

Map<String, dynamic> _$FormFieldDtoToJson(FormFieldDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'hidden': instance.hidden,
      'logic': instance.logic?.toJson(),
    };

Logic _$LogicFromJson(Map<String, dynamic> json) => Logic(
  conditions: json['conditions'] == null
      ? null
      : Condition.fromJson(json['conditions'] as Map<String, dynamic>),
  actions: (json['actions'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$LogicToJson(Logic instance) => <String, dynamic>{
  'conditions': instance.conditions?.toJson(),
  'actions': instance.actions,
};

Condition _$ConditionFromJson(Map<String, dynamic> json) => Condition(
  id: json['id'] as String?,
  operatorIdentifier: json['operatorIdentifier'] as String?,
  children: (json['children'] as List<dynamic>?)
      ?.map((e) => Condition.fromJson(e as Map<String, dynamic>))
      .toList(),
  identifier: json['identifier'] as String?,
  value: json['value'] == null
      ? null
      : ConditionValue.fromJson(json['value'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ConditionToJson(Condition instance) => <String, dynamic>{
  'id': instance.id,
  'operatorIdentifier': instance.operatorIdentifier,
  'children': instance.children?.map((e) => e.toJson()).toList(),
  'identifier': instance.identifier,
  'value': instance.value?.toJson(),
};

ConditionValue _$ConditionValueFromJson(Map<String, dynamic> json) =>
    ConditionValue(
      operator: json['operator'] as String?,
      value: json['value'],
      propertyMeta: json['property_meta'] == null
          ? null
          : PropertyMeta.fromJson(
              json['property_meta'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ConditionValueToJson(ConditionValue instance) =>
    <String, dynamic>{
      'operator': instance.operator,
      'value': instance.value,
      'property_meta': instance.propertyMeta?.toJson(),
    };

PropertyMeta _$PropertyMetaFromJson(Map<String, dynamic> json) => PropertyMeta(
  id: json['id'] as String?,
  type: json['type'] as String?,
  name: json['name'] as String?,
);

Map<String, dynamic> _$PropertyMetaToJson(PropertyMeta instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
    };

SelectConfig _$SelectConfigFromJson(Map<String, dynamic> json) => SelectConfig(
  options: (json['options'] as List<dynamic>?)
      ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SelectConfigToJson(SelectConfig instance) =>
    <String, dynamic>{'options': instance.options};

Option _$OptionFromJson(Map<String, dynamic> json) => Option(
  name: json['name'] as String?,
  id: json['id'] as String?,
  isCorrectAnswer: json['is_correct_answer'] as bool?,
);

Map<String, dynamic> _$OptionToJson(Option instance) => <String, dynamic>{
  'name': instance.name,
  'id': instance.id,
  'is_correct_answer': instance.isCorrectAnswer,
};
