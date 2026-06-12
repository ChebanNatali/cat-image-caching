import 'dart:convert';
import 'dart:io';
import 'package:catimage/core/core.dart';
import 'package:catimage/core/utils/local_store.dart';
import 'package:catimage/features/data/datasources/cat_remote_datasource.dart';
import 'package:catimage/features/data/models/cat_model.dart';
import 'package:catimage/features/domain/entities/cat_entity.dart';
import 'package:catimage/features/domain/repositories/cat_repository.dart';

class CatRepositoryImpl implements CatRepository {
  final CatRemoteDatasource remoteDatasource;
  final LocalStorage localStorage;

  CatRepositoryImpl({
    required this.remoteDatasource,
    required this.localStorage,
  });

  @override
  Future<CatEntity?> fetchAndCacheCatImage() async {
    final catModel = await remoteDatasource.fetchCatImage();
    if (catModel == null) return null;

    final history = await localStorage.getHistory();
    final isDuplicate = history.any((e) => e.id == catModel.id);
    if (isDuplicate) return getCachedCatImage();

    final imageBytes = await remoteDatasource.downloadImageById(catModel.id);
    if (imageBytes == null) return null;

    final fileName = await Core.utils.saveImageFile(
      '${catModel.id}.jpeg',
      imageBytes,
    );
    final modelToStore = catModel.copyWith(
      localPath: fileName,
      downloadedAt: DateTime.now(),
    );

    await localStorage.saveCatData(modelToStore);

    try {
      history.add(modelToStore);
      await localStorage.saveHistory(history);
    } catch (_) {
      await localStorage.saveHistory([modelToStore]);
    }

    final fullPath = await Core.utils.resolveImagePath(fileName);
    return modelToStore.copyWith(localPath: fullPath);
  }

  @override
  Future<List<CatEntity>> getHistory() async {
    final items = await localStorage.getHistory();
    final result = <CatEntity>[];
    for (final item in items) {
      if (item.localPath == null) continue;
      final fullPath = await Core.utils.resolveImagePath(item.localPath!);
      if (await File(fullPath).exists()) {
        result.add(item.copyWith(localPath: fullPath));
      }
    }
    return result;
  }

  @override
  Future<CatEntity?> getCachedCatImage() async {
    final jsonData = await localStorage.getCatData();
    if (jsonData == null) return null;

    final json = jsonDecode(jsonData) as Map<String, dynamic>;
    final model = CatModel.fromCacheJson(json);

    if (model.localPath == null) return null;
    final fullPath = await Core.utils.resolveImagePath(model.localPath!);
    if (!await File(fullPath).exists()) return null;

    return model.copyWith(localPath: fullPath);
  }
}
