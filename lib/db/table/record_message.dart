import 'package:drift/drift.dart';

/**
 * @author Marinda
 * @date 2023/6/13 13:54
 * @description 最近聊天记录Table
 */
class RecordMessage extends Table{
    IntColumn get id => integer().autoIncrement()();
    IntColumn get receiverId => integer()();
    TextColumn get message => text()();
}