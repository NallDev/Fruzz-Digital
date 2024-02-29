import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

Future<XFile?> imageCompressing(File file) async {
  final directory = await getTemporaryDirectory();
  String targetPath = p.join(directory.path, "${DateTime.now().microsecond}.jpg");

  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path, targetPath,
    quality: 88,
  );

  return result;
}