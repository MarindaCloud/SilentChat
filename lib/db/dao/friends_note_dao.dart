import 'package:drift/drift.dart';
import 'package:silentchat/db/db_manager.dart';
import 'package:silentchat/db/table/cache_view_message.dart';
import 'package:silentchat/db/table/friends_note.dart';
import 'package:silentchat/db/table/global_image_cache.dart';

part 'friends_note_dao.g.dart';



/*
 * @author Marinda
 * @date 2023/9/15 10:23
 * @description 朋友备注dao
 */
@DriftAccessor(tables: [FriendsNote])
class FriendsNoteDao extends DatabaseAccessor<DBManager> with _$FriendsNoteDaoMixin {

  FriendsNoteDao(DBManager db) : super(db);

  Future queryList() =>
      (select(friendsNote)).get();


  Future selectByUid(int uid) =>
      (select(friendsNote)
        ..where((tbl) => tbl.uid.equals(uid))).getSingleOrNull();


  Future insertNote(FriendsNoteCompanion companion) =>
      into(friendsNote).insertReturning(companion);

  Future updateNote(FriendsNoteData data) =>
      (update(friendsNote)..where((tbl) =>tbl.id.equals(data.id))).write(
          FriendsNoteCompanion(
            nickname: Value(data.nickname),
            username: Value(data.username),
            uid: Value(data.uid)
          )
      );

  Future deleteNote(int id) =>
      (delete(friendsNote)..where((tbl) => tbl.id.equals(id))).go();
}