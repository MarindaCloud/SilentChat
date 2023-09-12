import 'package:drift/drift.dart';
import 'package:silentchat/db/db_manager.dart';
import 'package:silentchat/db/table/cache_view_message.dart';
import 'package:silentchat/db/table/global_image_cache.dart';

part 'cache_record_message_dao.g.dart';


/**
 * @author Marinda
 * @date 2023/9/11 14:23
 * @description
 */
@DriftAccessor(tables: [CacheViewMessage])
class CacheViewMessageDao extends DatabaseAccessor<DBManager> with _$CacheViewMessageDaoMixin{

  CacheViewMessageDao(DBManager db) : super(db);
  
  Future selectById(int id) =>
      (select(cacheViewMessage)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future selectByMid(int mid) =>
      (select(cacheViewMessage)..where((tbl) => tbl.mid.equals(mid))).getSingle();

  Future selectByOwnerId(int ownerId) =>
      (select(cacheViewMessage)..where((tbl) => tbl.ownerId.equals(ownerId))).get();

  Future queryList() =>
      (select(cacheViewMessage)).get();

  Future insertReturning(CacheViewMessageCompanion cacheViewMessageCompanion) =>
      into(cacheViewMessage).insertReturning(cacheViewMessageCompanion);

  Future deleteById(int id) =>
      (delete(cacheViewMessage)..where((tbl) => tbl.id.equals(id))).go();

}