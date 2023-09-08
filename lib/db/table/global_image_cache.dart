import 'package:drift/drift.dart';

/**
 * @author Marinda
 * @date 2023/9/8 11:34
 * @description 全局图像缓存表
 */
class GlobalImageCache extends Table{
  //自增id
  IntColumn get id => integer().autoIncrement()();

  //类型 1->文件 2->内存
  IntColumn get type => integer()();

  //键
  TextColumn get key => text()();

  //值
  TextColumn get value => text()();

  //blob地址 Uint8List
  BlobColumn get blobValue => blob().nullable()();

  //所属目标id 群组id/用户id
  IntColumn get owner => integer()();

}