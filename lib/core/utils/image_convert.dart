import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}

Uint8List dataFromBase64String(String base64String) {
  Uint8List _bytes = base64.decode(base64String.split(',').last);
  return _bytes;
}

String base64String(Uint8List data) {
  return base64Encode(data);
}