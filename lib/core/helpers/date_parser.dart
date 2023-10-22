import 'package:intl/intl.dart';

class DateParser {
  static String readAbleDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('dd MMM yyyy').format(dateTime);
  }
}
