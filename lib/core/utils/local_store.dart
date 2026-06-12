import 'dart:convert';
import 'package:catimage/features/data/models/cat_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const _cachedCatKey = 'catimage_cached_cat_data';
  static const _historyKey = 'catimage_cat_history';

  final _prefs = SharedPreferencesAsync();

  Future<void> saveCatData(CatModel model) async {
    await _prefs.setString(_cachedCatKey, jsonEncode(model.toJson()));
  }

  Future<String?> getCatData() async {
    return _prefs.getString(_cachedCatKey);
  }

  Future<void> saveHistory(List<CatModel> models) async {
    final encoded = jsonEncode(models.map((m) => m.toJson()).toList());
    await _prefs.setString(_historyKey, encoded);
  }

  Future<List<CatModel>> getHistory() async {
    final raw = await _prefs.getString(_historyKey);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list
        .map((e) => CatModel.fromCacheJson(e as Map<String, dynamic>))
        .toList();
  }
}
