import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import '../models/RequestHeaderEntry.dart';
import 'package:path_provider/path_provider.dart';

class StorageInterface {
  static Future<List<RequestHeaderEntry>> getSavedEntries() async {
    try {
      final file = await _localFile;
      final contentsString = await file.readAsString();
      final contentsMap = jsonDecode(contentsString);
      final List<RequestHeaderEntry> requestItems = [];

      contentsMap.forEach((entry) =>
          requestItems.add(RequestHeaderEntry.fromJson(entry)));

      return Future.value(requestItems);
    } catch (e) {
      if (e.runtimeType == FileSystemException) {
        // If the file does not exist, the user hasn't saved any items yet.
        return [];
      }
      throw new Future.error("Failed to load file: $e");
    }
  }

  static void saveEntries(List<RequestHeaderEntry> entries) async {
    final file = await _localFile;
    final List<Map<String, dynamic>> filteredEntries = [];
    entries.forEach((entry) => {
      if (entry.description != 'Input new request here') {
        filteredEntries.add(entry.toJson())
      }
    });
    file.writeAsString(jsonEncode(filteredEntries).toString());
  }

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/prosuche_requests.json');
  }
}
