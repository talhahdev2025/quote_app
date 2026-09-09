import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final clipboardNotifierProvider = NotifierProvider<ClipboardNotifier, bool>(
  ClipboardNotifier.new,
);

class ClipboardNotifier extends Notifier<bool> {
  Timer? _timer;
  @override
  bool build() {
  ref.onDispose(() {
      _timer?.cancel();
    });
    return false;
  }
  

  Future<void> copy(String text) async {
    if (text.isEmpty) return;
_timer?.cancel();
    await Clipboard.setData(ClipboardData(text: text));
    state = true;
_timer = Timer(const Duration(seconds: 1), () {
      if (ref.mounted) {
        state = false;
      }
    });
  }
}
