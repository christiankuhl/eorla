import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:image/image.dart' as img;

Image? decodeAndResizeImageBytes(String b64Content) {
  final image = img.decodeImage(base64Decode(b64Content));
  if (image == null) return null;

  final resized = img.copyResize(
    image,
    height: 256,
  ); // 65k pixels ought to be enough for everyone ;o)
  return Image.memory(img.encodePng(resized));
}

class Avatar {
  final Image? avatar;
  final String mimeType;

  Avatar(this.avatar, this.mimeType);

  factory Avatar.fromJson(String? json) {
    if (json == null) {
      return Avatar(null, "");
    }
    var parts = json.split(",");
    var mimeType = parts.first;
    var content = parts.last;
    var img = decodeAndResizeImageBytes(content);
    return Avatar(img, mimeType);
  }

  factory Avatar.empty() {
    return Avatar(null, "");
  }

  String? toJson() {
    return avatar != null
        ? "$mimeType,${base64Encode((avatar?.image as MemoryImage).bytes)}"
        : null;
  }

  ImageProvider? get image {
    return avatar?.image;
  }
}
