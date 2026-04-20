import 'package:json_annotation/json_annotation.dart';

part 'form_field.g.dart';

@JsonSerializable(explicitToJson: true)
class FormFieldDto {
  final String? id;
  final String? type;
  final String? name;
  final bool? hidden;
  final Logic? logic;

  FormFieldDto({this.id, this.type, this.name, this.hidden, this.logic});

  factory FormFieldDto.fromJson(Map<String, dynamic> json) => _$FormFieldDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FormFieldDtoToJson(this);
}


@JsonSerializable(explicitToJson: true)
class Logic {
  final Condition? conditions;
  final List<String>? actions;

  Logic({this.conditions, this.actions});

  factory Logic.fromJson(Map<String, dynamic> json) => _$LogicFromJson(json);
  Map<String, dynamic> toJson() => _$LogicToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Condition {
  final String? id;
  final String? operatorIdentifier;
  final List<Condition>? children;
  final String? identifier;
  final ConditionValue? value;

  Condition({this.id, this.operatorIdentifier, this.children, this.identifier, this.value});

  factory Condition.fromJson(Map<String, dynamic> json) => _$ConditionFromJson(json);
  Map<String, dynamic> toJson() => _$ConditionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ConditionValue {
  final String? operator;
  final dynamic value;
  @JsonKey(name: 'property_meta')
  final PropertyMeta? propertyMeta;

  ConditionValue({this.operator, this.value, this.propertyMeta});

  factory ConditionValue.fromJson(Map<String, dynamic> json) => _$ConditionValueFromJson(json);
  Map<String, dynamic> toJson() => _$ConditionValueToJson(this);
}

@JsonSerializable()
class PropertyMeta {
  final String? id;
  final String? type;
  final String? name;

  PropertyMeta({this.id, this.type, this.name});

  factory PropertyMeta.fromJson(Map<String, dynamic> json) => _$PropertyMetaFromJson(json);
  Map<String, dynamic> toJson() => _$PropertyMetaToJson(this);
}

@JsonSerializable()
class SelectConfig {
  final List<Option>? options;

  SelectConfig({this.options});

  factory SelectConfig.fromJson(Map<String, dynamic> json) => _$SelectConfigFromJson(json);
  Map<String, dynamic> toJson() => _$SelectConfigToJson(this);
}

@JsonSerializable()
class Option {
  final String? name;
  final String? id;
  @JsonKey(name: 'is_correct_answer')
  final bool? isCorrectAnswer;

  Option({this.name, this.id, this.isCorrectAnswer});

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);
  Map<String, dynamic> toJson() => _$OptionToJson(this);
}