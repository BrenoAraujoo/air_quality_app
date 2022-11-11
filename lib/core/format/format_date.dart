import 'package:intl/intl.dart';

abstract class FormatDate {
  static String getDefaultDate(DateTime date) {
    return DateFormat("dd/MM/yyy").format(date);
  }
}
