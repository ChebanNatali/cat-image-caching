import 'dart:convert';
import 'dart:io';
import 'package:catimage/features/data/models/cat_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const _cachedCatKey = 'cached_cat_data';
  static const _historyKey = 'cat_history';

  Future<void> saveCatData(CatModel model) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cachedCatKey, jsonEncode(model.toJson()));
  }

  Future<String?> getCatData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_cachedCatKey);
  }

  Future<void> saveHistory(List<CatModel> models) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(models.map((m) => m.toJson()).toList());
    await prefs.setString(_historyKey, encoded);
  }

  Future<List<CatModel>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_historyKey);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list
        .map((e) => CatModel.fromCacheJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<String> saveImageFile(String fileName, List<int> bytes) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(bytes);
    return file.path;
  }
}
