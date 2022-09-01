import 'dart:async';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class PDFApi {
  static Future<File> loadNetwork(String jLink) async {
    final response = await http.get(Uri.parse(jLink));
    final bytes = response.bodyBytes;

    return _storeFile(jLink, bytes);
  }

  static Future<File> _storeFile(String jLink, List<int> bytes) async {
    final filename = basename(jLink);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }
}