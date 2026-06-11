import 'dart:convert';
import 'package:catimage/core/core.dart';
import 'package:catimage/features/data/models/cat_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CatRemoteDatasource {
  final http.Client client;

  CatRemoteDatasource({required this.client});

  Future<CatModel?> fetchCatImage() async {
    final uri = Uri.parse(
      '${Core.constants.baseUrl}/cat?type=medium&position=center&html=true&json=true',
    );
    try {
      final response = await client.get(uri);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final model = CatModel.fromJson(json);
        return model;
      } else {
        debugPrint(
          '[CatRemoteDatasource] fetchCatImage ✗ неожиданный статус: ${response.statusCode}',
        );
        return null;
      }
    } catch (e) {
      debugPrint('[CatRemoteDatasource] fetchCatImage ✗ исключение: $e');
      return null;
    }
  }

  Future<List<int>?> downloadImageById(String id) async {
    final uri = Uri.parse('${Core.constants.baseUrl}/cat/$id');
    try {
      final response = await client.get(uri, headers: {'accept': 'image/*'});
      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        debugPrint(
          '[CatRemoteDatasource] downloadImageById ✗ статус: ${response.statusCode}',
        );
        return null;
      }
    } catch (e) {
      debugPrint('[CatRemoteDatasource] downloadImageById ✗ исключение: $e');
      return null;
    }
  }
}
