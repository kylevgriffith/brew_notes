import 'dart:async';
import 'dart:convert';
// import 'dart:developer';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../models/models.dart';

// service to load recipe data from disk and save it

// class FileStorage with ChangeNotifier {
class FileStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/recipes.json');
  }

  Future<List<Recipe>> loadData() async {
    try {
      final file = await _localFile;
      // Read the file
      String contents = await file.readAsString();
      print(contents);
      if (contents != null) {
        // parse json file if file was saved before
        return recipeFromJson(contents);
        // notifyListeners(); // this is not right for how I have this now
      }
    } on FileSystemException catch (_) {
      // the file did not exist before
    } catch (e) {
      // log(e);
      print(e);
    }
    return <Recipe>[];
  }

  Future<File> writeData(List<Recipe> data) async {
    final file = await _localFile;
    // write the file
    return file.writeAsString(recipeToJson(data));
  }
}
