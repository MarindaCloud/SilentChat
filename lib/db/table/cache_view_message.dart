import 'package:drift/drift.dart';

/**
 * @author Marinda
 * @date 2023/9/11 14:23
 * @description 缓存可视消息
 */
class CacheViewMessage extends Table{
  // 自增id
  IntColumn get id => integer().autoIncrement()();

  // 日期列
  DateTimeColumn get time => dateTime()();

  // 消息id
  IntColumn get mid => integer()();

  //涉及目标id
  IntColumn get ownerId => integer().nullable()();

  // 目标
  TextColumn get element => text()();
}