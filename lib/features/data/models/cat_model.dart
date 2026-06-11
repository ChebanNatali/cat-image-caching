import 'package:catimage/features/domain/entities/cat_entity.dart';

class CatModel extends CatEntity {
  const CatModel({
    required super.id,
    required super.tags,
    required super.createdAt,
    required super.url,
    required super.mimetype,
    super.localPath,
  });

  factory CatModel.fromJson(Map<String, dynamic> json) {
    return CatModel(
      id: json['id'] as String,
      tags: List<String>.from(json['tags'] as List),
      createdAt: json['created_at'] as String,
      url: json['url'] as String,
      mimetype: json['mimetype'] as String,
    );
  }

  CatModel copyWith({String? localPath}) {
    return CatModel(
      id: id,
      tags: tags,
      createdAt: createdAt,
      url: url,
      mimetype: mimetype,
      localPath: localPath ?? this.localPath,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'tags': tags,
        'created_at': createdAt,
        'url': url,
        'mimetype': mimetype,
        'local_path': localPath,
      };

  factory CatModel.fromCacheJson(Map<String, dynamic> json) {
    return CatModel(
      id: json['id'] as String,
      tags: List<String>.from(json['tags'] as List),
      createdAt: json['created_at'] as String,
      url: json['url'] as String,
      mimetype: json['mimetype'] as String,
      localPath: json['local_path'] as String?,
    );
  }
}
