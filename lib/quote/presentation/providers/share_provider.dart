import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

final shareNotifierProvider = NotifierProvider<ShareNotifier, bool>(
  ShareNotifier.new,
);

class ShareNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  Future<void> shareQuote(String text) async {
    if (text.isEmpty) return;

    state = true;
    try {
      final params = ShareParams(text: text, subject: 'Quote of the Day');
      await SharePlus.instance.share(params);
    } finally {
      if (ref.mounted) {
        state = false;
      }
    }
  }
}
