import 'package:drift/drift.dart';
import 'package:silentchat/db/dao/cache_record_message_dao.dart';
import 'package:silentchat/db/dao/global_image_cache_dao.dart';
import 'package:silentchat/db/dao/record_message_dao.dart';
import 'package:silentchat/db/table/cache_view_message.dart';
import 'package:silentchat/db/table/global_image_cache.dart';
import 'package:silentchat/db/table/record_message.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'dart:io';

import 'package:silentchat/util/log.dart';

part 'db_manager.g.dart';

LazyDatabase _openConnection(){

  return LazyDatabase(() async{
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path,"scSilent.sqlite"));
    // file.delete();
    Log.d(p.join(dbFolder.path,"scSilent.sqlite"));
    return NativeDatabase(file);
  } );
}

@DriftDatabase(tables: [RecordMessage,GlobalImageCache,CacheViewMessage],daos: [RecordMessageDao,GlobalImageCacheDao,CacheViewMessageDao])
class DBManager extends _$DBManager{

  static DBManager? dbManager;
  DBManager._() : super(_openConnection());

  factory DBManager() {
    dbManager ??= DBManager._();
    return dbManager!;
  }

  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.
  @override
  int get schemaVersion => 1;
}