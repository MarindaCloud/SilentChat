import 'package:flutter/cupertino.dart';

import 'package:drift/drift.dart';
import 'package:silentchat/db/db_manager.dart';
import 'package:silentchat/db/table/global_image_cache.dart';
import 'package:silentchat/db/table/record_message.dart';

part 'global_image_cache_dao.g.dart';

/**
 * @author Marinda
 * @date 2023/6/13 14:24
 * @description 最近聊天记录Dao
 */
@DriftAccessor(tables: [GlobalImageCache])
class GlobalImageCacheDao extends DatabaseAccessor<DBManager> with _$GlobalImageCacheDaoMixin{
  GlobalImageCacheDao(DBManager db) : super(db);

  /*
   * @author Marinda
   * @date 2023/9/8 13:47
   * @description 获取所有者所有图像缓存信息
   */
  Future selectImageCacheOwner(int ownerId) =>
      (select(globalImageCache)..where((tbl) => tbl.owner.equals(ownerId))).get();

  /*
   * @author Marinda
   * @date 2023/9/8 13:51
   * @description 插入图像缓存数据
   */
  Future insertImageCache(GlobalImageCacheCompanion globalImageCacheCompanion) =>
      into(globalImageCache).insertReturning(globalImageCacheCompanion);

  /*
   * @author Marinda
   * @date 2023/9/8 13:52
   * @description 获取所有数据
   */
  Future queryList() => select(globalImageCache).get();

  /*
   * @author Marinda
   * @date 2023/9/8 13:53
   * @description 删除图像缓存
   */
  Future deleteImageCache(int id) =>
      (delete(globalImageCache)..where((tbl) => tbl.id.equals(id))).go();

  /*
   * @author Marinda
   * @date 2023/9/8 14:04
   * @description 修改图像Cache
   */
  Future updateImageCache(GlobalImageCacheData data) =>
      (update(globalImageCache)..where((tbl) =>
      tbl.owner.equals(data.owner))).write(
          GlobalImageCacheCompanion(
              type: Value(data.type),
              key: Value(data.key),
              value: Value(data.value),
              blobValue: Value(data.blobValue),
              owner: Value(data.owner)
          )
      );
}