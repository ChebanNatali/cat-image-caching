import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Utils {
  // String dateTimeShortMonthWithTime(DateTime? date) {
  //   if (date == null) return "";
  //   return DateFormat('d MMM y в HH:mm', 'ru').format(date);
  // }
  String formatDateTimeWithTime(DateTime dt) {
    final d = dt.day.toString().padLeft(2, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final h = dt.hour.toString().padLeft(2, '0');
    final min = dt.minute.toString().padLeft(2, '0');
    return 'Загружено сегодня: $d.$m.${dt.year} в $h:$min';
  }

  Future<String> saveImageFile(String fileName, List<int> bytes) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(bytes);
    return file.path;
  }
}