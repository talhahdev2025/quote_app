import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

final imageCaptureProvider = NotifierProvider<ImageCaptureNotifier, bool>(
  ImageCaptureNotifier.new,
);

class ImageCaptureNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  Future<bool> captureAndShare(GlobalKey boundaryKey) async {
    state = true;

    try {
      // 1. Ensure context exists
      final BuildContext? context = boundaryKey.currentContext;
      if (context == null) {
        debugPrint('Capture Error: GlobalKey context is null.');
        return false;
      }

      // 2. Fetch RenderObject safely
      final RenderObject? renderObject = context.findRenderObject();
      if (renderObject is! RenderRepaintBoundary) {
        debugPrint('Capture Error: RenderObject is not a RenderRepaintBoundary.');
        return false;
      }

      final RenderRepaintBoundary boundary = renderObject;

      // 3. Handle paint state gracefully
      if (boundary.debugNeedsPaint) {
        debugPrint('Boundary needs paint, waiting for frame...');
        await WidgetsBinding.instance.endOfFrame;
      }

      // 4. Rasterize widget to image bytes
      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) {
        debugPrint('Capture Error: ByteData conversion failed.');
        return false;
      }

      final pngBytes = byteData.buffer.asUint8List();

      // 5. Write to temp directory
      final directory = await getTemporaryDirectory();
      final String filePath =
          '${directory.path}/quote_${DateTime.now().millisecondsSinceEpoch}.png';
      final file = File(filePath);
      await file.writeAsBytes(pngBytes, flush: true);

      // 6. Execute native share sheet
      final xFile = XFile(filePath);
      final params = ShareParams(
        text: 'Shared from Quote App',
        files: [xFile],
      );

      await SharePlus.instance.share(params);
      return true;
    } catch (e, stackTrace) {
      debugPrint('Capture Exception: $e');
      debugPrint('StackTrace: $stackTrace');
      return false;
    } finally {
      if (ref.mounted) {
        state = false;
      }
    }
  }
}