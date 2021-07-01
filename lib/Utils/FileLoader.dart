import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

class FileLoader {
  static ui.Image img;
  static void initilaize() {
    loadUiImage("assets/images/PlayingField/playing_field_minimaized.jpg").then((value) => img = value);
    // loadImage(File("assets/images/PlayingField/playing_field_minimaized.jpg")).then((value) => img = value);
  }

  static Future<ui.Image> loadUiImage(String assetPath) async {
    final data = await rootBundle.load(assetPath);
    final list = Uint8List.view(data.buffer);
    final completer = Completer<ui.Image>();
    ui.decodeImageFromList(list, completer.complete);
    return completer.future;
  }
}
