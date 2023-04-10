import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import '../entity/user_table.dart';

part 'app_db.g.dart';

LazyDatabase openConnection(){
  return LazyDatabase(() async {
    final dbfolder = await getApplicationDocumentsDirectory();
    final file=File(path.join(dbfolder.path,'user.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Users])
class Appdb extends _$Appdb{
  Appdb(): super(openConnection());

  @override
  int get schemaVersion => 1;
  Future<List<User>> getUsers()async
  {
    return await select(users).get();
  }

  Future<User> getUser(int id) async{
    return await (select(users)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<bool> updateUser(UsersCompanion entity) async{
    return await (update(users).replace(entity));
  }

  Future<int> insertUser(UsersCompanion entity) async{
    return await into(users).insert(entity);
  }

  Future<int> deleteUser(int id)async{
    return await (delete(users)..where((tbl) => tbl.id.equals(id))).go();
  }
}