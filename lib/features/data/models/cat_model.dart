import 'package:catimage/features/domain/entities/cat_entity.dart';

class CatModel extends CatEntity {
  const CatModel({
    required super.id,
    required super.tags,
    required super.createdAt,
    required super.url,
    required super.mimetype,
    super.localPath,
    super.downloadedAt,
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

  factory CatModel.fromCacheJson(Map<String, dynamic> json) {
    final downloadedAtRaw = json['downloaded_at'] as String?;
    return CatModel(
      id: json['id'] as String,
      tags: List<String>.from(json['tags'] as List),
      createdAt: json['created_at'] as String,
      url: json['url'] as String,
      mimetype: json['mimetype'] as String,
      localPath: json['local_path'] as String?,
      downloadedAt: downloadedAtRaw != null ? DateTime.parse(downloadedAtRaw) : null,
    );
  }

  CatModel copyWith({String? localPath, DateTime? downloadedAt}) {
    return CatModel(
      id: id,
      tags: tags,
      createdAt: createdAt,
      url: url,
      mimetype: mimetype,
      localPath: localPath ?? this.localPath,
      downloadedAt: downloadedAt ?? this.downloadedAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'tags': tags,
        'created_at': createdAt,
        'url': url,
        'mimetype': mimetype,
        'local_path': localPath,
        'downloaded_at': downloadedAt?.toIso8601String(),
      };
}
