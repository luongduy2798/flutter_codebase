import 'package:intl/intl.dart';

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String formatTime(DateTime? date) {
  try {
    if (date != null) return DateFormat('yyyy.MM.dd').format(date);
    return '';
  } catch (e) {
    return '';
  }
}

String formatTime2(DateTime? date) {
  try {
    if (date != null) return DateFormat('yyyy-MM-dd').format(date);
    return '';
  } catch (e) {
    return '';
  }
}