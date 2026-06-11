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

    final imageBytes = await remoteDatasource.downloadImageById(catModel.id);
    if (imageBytes == null) return null;

    final localPath = await Core.utils.saveImageFile(
      '${catModel.id}.jpeg',
      imageBytes,
    );
    final newCatImage = catModel.copyWith(
      localPath: localPath,
      downloadedAt: DateTime.now(),
    );

    await localStorage.saveCatData(newCatImage);

    final history = await localStorage.getHistory();
    history.add(newCatImage);
    await localStorage.saveHistory(history);

    return newCatImage;
  }

  @override
  Future<List<CatEntity>> getHistory() => localStorage.getHistory();

  @override
  Future<CatEntity?> getCachedCatImage() async {
    final jsonData = await localStorage.getCatData();
    if (jsonData == null) return null;

    final json = jsonDecode(jsonData) as Map<String, dynamic>;
    final model = CatModel.fromCacheJson(json);

    if (model.localPath == null || !File(model.localPath!).existsSync()) {
      return null;
    }
    return model;
  }
}
