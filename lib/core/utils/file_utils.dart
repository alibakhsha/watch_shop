import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

class FileUtils {
  static Future<String> saveImagePermanently(File image) async {
    final directory = await getApplicationDocumentsDirectory();
    final imageName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final imagePath = '${directory.path}/$imageName';

    final savedImage = await image.copy(imagePath);
    debugPrint('Image saved permanently at: $imagePath');
    return savedImage.path;
  }
}
