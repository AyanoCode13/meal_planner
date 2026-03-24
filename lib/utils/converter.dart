import 'package:floor/floor.dart';

class DateTimeConverter extends TypeConverter<DateTime, String> {
  @override
  DateTime decode(String databaseValue) => DateTime.parse(databaseValue);

  @override
  String encode(DateTime value) => value.toIso8601String();
}


class DurationConverter extends TypeConverter<Duration, int> {
  @override
  Duration decode(int databaseValue) => Duration(minutes: databaseValue);

  @override
  int encode(Duration value) => value.inMinutes;
}








