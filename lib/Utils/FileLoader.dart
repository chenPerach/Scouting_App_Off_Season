import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:image/image.dart' as image;
import 'package:flutter/services.dart';

class FileLoader {
  static ui.Image img;
  static void initilaize() {
    loadUiImage("assets/images/PlayingField/playing_field_minimaized.jpg")
        .then((value) => img = value);
  }

  static Future<ui.Image> loadUiImage(String assetPath) async {
    final data = await rootBundle.load(assetPath);
    final list = Uint8List.view(data.buffer);
    final completer = Completer<ui.Image>();
    ui.decodeImageFromList(list, completer.complete);
    return completer.future;
  }
}

class UImage {
  static Future<ui.Image> resize(ui.Image img, int height, int width) async {
    Uint8List data = Uint8List.view((await img.toByteData()).buffer);
    image.Image baseSizeImage =
        image.decodeImage(data);
    image.Image resizeImage =
        image.copyResize(baseSizeImage, height: height, width: width);
    ui.Codec codec =
        await ui.instantiateImageCodec(image.encodePng(resizeImage));
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }
}
