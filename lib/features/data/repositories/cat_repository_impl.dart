import 'dart:convert';
import 'dart:io';
import 'package:catimage/core/utils/local_store.dart';
import 'package:catimage/features/data/datasources/cat_remote_datasource.dart';
import 'package:catimage/features/data/models/cat_model.dart';
import 'package:catimage/features/domain/entities/cat_entity.dart';
import 'package:catimage/features/domain/repositories/cat_repository.dart';
import 'package:flutter/foundation.dart';

class CatRepositoryImpl implements CatRepository {
  final CatRemoteDatasource remoteDatasource;
  final LocalStorage localStorage;

  CatRepositoryImpl({
    required this.remoteDatasource,
    required this.localStorage,
  });

  @override
  Future<CatEntity?> fetchAndCacheCatImage() async {
    debugPrint('[CatRepositoryImpl] fetchAndCacheCatImage: шаг 1 — запрос модели');
    final catModel = await remoteDatasource.fetchCatImage();
    if (catModel == null) {
      debugPrint('[CatRepositoryImpl] fetchAndCacheCatImage ✗ модель не получена, выход');
      return null;
    }
    debugPrint('[CatRepositoryImpl] fetchAndCacheCatImage: шаг 2 — скачивание изображения id=${catModel.id}');
    final imageBytes = await remoteDatasource.downloadImageById(catModel.id);
    if (imageBytes == null) {
      debugPrint('[CatRepositoryImpl] fetchAndCacheCatImage ✗ байты не получены, выход');
      return null;
    }

    debugPrint('[CatRepositoryImpl] fetchAndCacheCatImage: шаг 3 — сохранение файла (${imageBytes.length} bytes)');
    final localPath = await localStorage.saveImageFile('${catModel.id}.jpeg', imageBytes);
    debugPrint('[CatRepositoryImpl] fetchAndCacheCatImage ✓ файл сохранён: $localPath');

    final cached = catModel.copyWith(localPath: localPath);

    debugPrint('[CatRepositoryImpl] fetchAndCacheCatImage: шаг 4 — сохранение текущего кота в кэш');
    await localStorage.saveCatData(cached);
    debugPrint('[CatRepositoryImpl] fetchAndCacheCatImage ✓ saveCatData выполнен');

    debugPrint('[CatRepositoryImpl] fetchAndCacheCatImage: шаг 5 — обновление истории');
    final history = await localStorage.getHistory();
    debugPrint('[CatRepositoryImpl] fetchAndCacheCatImage: история до добавления — ${history.length} записей');
    history.add(cached);
    await localStorage.saveHistory(history);
    debugPrint('[CatRepositoryImpl] fetchAndCacheCatImage ✓ история сохранена — ${history.length} записей');

    return cached;
  }

  @override
  Future<List<CatEntity>> getHistory() async {
    debugPrint('[CatRepositoryImpl] getHistory: чтение истории');
    final items = await localStorage.getHistory();
    debugPrint('[CatRepositoryImpl] getHistory ✓ найдено записей: ${items.length}');
    return items;
  }

  @override
  Future<CatEntity?> getCachedCatImage() async {
    debugPrint('[CatRepositoryImpl] getCachedCatImage: чтение кэша');
    final jsonData = await localStorage.getCatData();
    if (jsonData == null) {
      debugPrint('[CatRepositoryImpl] getCachedCatImage: кэш пуст');
      return null;
    }

    final json = jsonDecode(jsonData) as Map<String, dynamic>;
    final model = CatModel.fromCacheJson(json);

    if (model.localPath == null || !File(model.localPath!).existsSync()) {
      debugPrint('[CatRepositoryImpl] getCachedCatImage ✗ файл не найден: ${model.localPath}');
      return null;
    }
    debugPrint('[CatRepositoryImpl] getCachedCatImage ✓ id=${model.id}, path=${model.localPath}');
    return model;
  }
}
