import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Utils {

  bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  bool isWithinLastHalfHour(DateTime date) {
    return DateTime
        .now()
        .difference(date)
        .inMinutes < 30;
  }

  String formatDateTimeToDay(DateTime dt) {
    final d = dt.day.toString().padLeft(2, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final h = dt.hour.toString().padLeft(2, '0');
    final min = dt.minute.toString().padLeft(2, '0');
    return 'Загружено сегодня: $d.$m.${dt.year} в $h:$min';
  }

  String formatDateTimeWithTime(DateTime dt) {
    final d = dt.day.toString().padLeft(2, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final h = dt.hour.toString().padLeft(2, '0');
    final min = dt.minute.toString().padLeft(2, '0');
    return 'Загружено: $d.$m.${dt.year} в $h:$min';
  }

  Future<String> saveImageFile(String fileName, List<int> bytes) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(bytes);
    return fileName; // сохраняем только имя файла, не полный путь
  }

  Future<String> resolveImagePath(String fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/$fileName';
  }
}