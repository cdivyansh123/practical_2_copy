// imports the drift package
import 'package:drift/drift.dart';

// defines a new table called 'Users' having column names : 'id' (auto incement), 'name', 'number' and 'gender'
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().named("name")();

  TextColumn get number => text().named("number")();

  TextColumn get gender => text().named("gender")();
}
