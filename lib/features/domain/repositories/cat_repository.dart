import 'package:catimage/features/domain/entities/cat_entity.dart';

abstract class CatRepository {
  Future<CatEntity?> fetchAndCacheCatImage();
  Future<CatEntity?> getCachedCatImage();
  Future<List<CatEntity>> getHistory();
}
