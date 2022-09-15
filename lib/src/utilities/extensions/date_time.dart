import 'package:intl/intl.dart';

extension DateTimeFormatter on DateTime{
  String get time => DateFormat('hh:mm').format(this);
}