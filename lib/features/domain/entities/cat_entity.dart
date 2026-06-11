class CatEntity {
  final String id;
  final List<String> tags;
  final String createdAt;
  final String url;
  final String mimetype;
  final String? localPath;

  const CatEntity({
    required this.id,
    required this.tags,
    required this.createdAt,
    required this.url,
    required this.mimetype,
    this.localPath,
  });
}
