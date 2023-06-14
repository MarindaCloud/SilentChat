import 'package:flutter/cupertino.dart';

import 'package:drift/drift.dart';
import 'package:silentchat/db/db_manager.dart';
import 'package:silentchat/db/table/record_message.dart';

part 'record_message_dao.g.dart';

/**
 * @author Marinda
 * @date 2023/6/13 14:24
 * @description 最近聊天记录Dao
 */
@DriftAccessor(tables: [RecordMessage])
class RecordMessageDao extends DatabaseAccessor<DBManager> with _$RecordMessageDaoMixin{
  RecordMessageDao(DBManager db) : super(db);

  /*
   * @author Marinda
   * @date 2023/6/13 14:14
   * @description 插入最近聊天数据
   */
  Future insertRecordMessage(RecordMessageCompanion data ) =>
      into(recordMessage).insertReturning(data);

  /*
   * @author Marinda
   * @date 2023/6/13 14:14
   * @description 获取所有最近聊天数据
   */
  Future queryList() => select(recordMessage).get();

  /*
   * @author Marinda
   * @date 2023/6/13 14:17
   * @description 根据id删除记录消息
   */
  Future deleteRecordMessageById(int id) => (delete(recordMessage)..where((tbl) => tbl.id.equals(id))).go();

  /*
   * @author Marinda
   * @date 2023/6/13 14:24
   * @description 修改记录消息
   */
  Future updateRecordMessage(RecordMessageData data) =>
      (update(recordMessage)..where((tbl) => tbl.id.equals(data.id)))
          .write(
          RecordMessageCompanion(
        id: Value(data.id),
        receiverId: Value(data.receiverId),
        message: Value(data.message)));
}