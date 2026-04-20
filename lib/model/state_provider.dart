import 'package:riverpod/riverpod.dart';

final fieldValueProvider = StateProvider.family<Map<String, dynamic>, dynamic>((
  ref,
  fieldId,
) {
  return {};
});
