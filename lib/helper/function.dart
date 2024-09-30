import 'dart:async';
import 'dart:ui';

class Func {
  static Timer? _debouncer;
  static _debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (_debouncer != null) {
      _debouncer!.cancel();
    }
    _debouncer = Timer(duration, callback);
  }

  static searchListener(String value, Future Function(String) onSearch) async {
    await _debounce(() async => onSearch(value));
  }
}
