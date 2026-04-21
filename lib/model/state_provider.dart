import 'package:riverpod/riverpod.dart';

final formDataProvider =
    NotifierProvider.autoDispose<FormDataNotifier, Map<String, dynamic>>(() {
      return FormDataNotifier();
    });

final class FormDataNotifier extends AutoDisposeNotifier<Map<String, dynamic>> {
  @override
  Map<String, dynamic> build() {
    return {};
  }

  void updateValue(String fieldId, dynamic value) {
    final updatedMap = Map<String, dynamic>.from(state);
    updatedMap[fieldId] = value;
    state = updatedMap;
  }

  void removeValue(String fieldId) {
    final updatedMap = Map<String, dynamic>.from(state);
    updatedMap.remove(fieldId);
    state = updatedMap;
  }
}
