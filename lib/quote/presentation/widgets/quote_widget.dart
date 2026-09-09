import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_practice_project/quote/presentation/providers/clipboard_provider.dart';
import 'package:new_practice_project/quote/presentation/providers/image_capture_provider.dart';
import 'package:new_practice_project/quote/presentation/providers/provider.dart';

final GlobalKey _cardBoundaryKey = GlobalKey();

class QuoteWidget extends ConsumerWidget {
  const QuoteWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = MediaQuery.sizeOf(context);
    final quoteAsync = ref.watch(quoteProvider);
    final isCopied = ref.watch(clipboardNotifierProvider);
    final isCapturing = ref.watch(imageCaptureProvider);

    return Container(
      padding: const EdgeInsets.all(12),
      width: query.width * 0.8,
      height: query.height * 0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23),
        color: const Color.fromARGB(255, 223, 221, 221),
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => ref.invalidate(quoteProvider),
                icon: const Icon(Icons.refresh_outlined),
              ),
            ],
          ),
          const Spacer(),

          RepaintBoundary(
            key: _cardBoundaryKey,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 223, 221, 221),
                borderRadius: BorderRadius.circular(18),
              ),
              child: quoteAsync.when(
                data: (quote) => Text(
                  quote.quote,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                loading: () => const CircularProgressIndicator(),
                error: (err, stack) => Text(
                  'Error: $err',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
          ),

          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Share Image Button
              IconButton(
                onPressed: isCapturing
                    ? null
                    : () {
                        ref
                            .read(imageCaptureProvider.notifier)
                            .captureAndShare(_cardBoundaryKey);
                      },
                icon: isCapturing
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.share_outlined),
              ),

              // Copy Text Button
              IconButton(
                onPressed: isCopied
                    ? null
                    : () {
                        quoteAsync.whenData(
                          (quote) => ref
                              .read(clipboardNotifierProvider.notifier)
                              .copy(quote.quote),
                        );
                      },
                icon: Icon(
                  isCopied ? Icons.check_circle : Icons.copy_outlined,
                  color: isCopied ? Colors.green : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
