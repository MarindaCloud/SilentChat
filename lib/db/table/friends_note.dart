import 'package:drift/drift.dart';
class FriendsNote extends Table{

  IntColumn get id => integer().autoIncrement()();

  IntColumn get uid => integer()();

  TextColumn get username => text()();

  TextColumn get nickname => text()();
}