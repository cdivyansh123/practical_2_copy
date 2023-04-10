import 'package:drift/drift.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().named("name")();
  TextColumn get number => text().named("number")();
  TextColumn get gender => text().named("gender")();
}
