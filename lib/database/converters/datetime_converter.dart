import 'package:floor/floor.dart';

/// Converts [DateTime] ↔ [int] (milliseconds since epoch).
class DateTimeConverter extends TypeConverter<DateTime, int> {
  @override
  DateTime decode(int databaseValue) =>
      DateTime.fromMillisecondsSinceEpoch(databaseValue);

  @override
  int encode(DateTime value) => value.millisecondsSinceEpoch;
}

/// Converts [DateTime?] ↔ [int?] (nullable variant).
class NullableDateTimeConverter extends TypeConverter<DateTime?, int?> {
  @override
  DateTime? decode(int? databaseValue) => databaseValue == null
      ? null
      : DateTime.fromMillisecondsSinceEpoch(databaseValue);

  @override
  int? encode(DateTime? value) => value?.millisecondsSinceEpoch;
}
