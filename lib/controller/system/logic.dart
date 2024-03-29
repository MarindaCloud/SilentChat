import 'dart:io';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:silentchat/common/logic/cache_image_handle.dart';
import 'package:silentchat/controller/system/state.dart';
import 'package:silentchat/db/dao/global_image_cache_dao.dart';
import 'package:silentchat/db/db_manager.dart';
import 'package:silentchat/entity/group.dart';
import 'package:silentchat/entity/silent_chat_entity.dart';
import 'package:silentchat/entity/user.dart';
import 'package:drift/drift.dart' as drift;
import 'package:silentchat/enum/cache_image_type.dart';
import 'package:silentchat/util/log.dart';
/**
 * @author Marinda
 * @date 2023/6/9 17:32
 * @description 系统逻辑处理器
 */
class SystemLogic extends GetxController {
  final state = SystemState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  /*
   * @author Marinda
   * @date 2023/9/9 15:20
   * @description 初始化图像缓存
   */
  initImageCache() async{
    final db = DBManager();
    List<GlobalImageCacheData> list = await GlobalImageCacheDao(db).queryList();
    List<GlobalImageCacheData> removeList = [];
    for(var element in list){
      String key = element.key;
      String value = element.value;
      File file = File(value);
      if(file.existsSync()){
        await CacheImageHandle.putImageCache(key,File(value));
      }else{
      //  如果不存在的移除drift缓存
        removeList.add(element);
      }
    }
    for(var element in removeList){
      await GlobalImageCacheDao(db).deleteImageCache(element.id);
      Log.i("移除不存在的文件缓存：${element.id}");
    }
    Log.i("初始化已有图像文件缓存数据完毕，长度：${list.length}");
  }

  /*
   * @author Marinda
   * @date 2023/9/8 14:31
   * @description 加载全局缓存
   */
  loadGlobalImageCache(SilentChatEntity silentChatEntity,[String imgSrc = ""]) async{
    int ownerId = 0;
    String portrait = "";
    if(silentChatEntity is User){
      ownerId = silentChatEntity.id ?? -1;
      portrait = silentChatEntity.portrait ?? "";
    }
    if(silentChatEntity is Group){
      ownerId = silentChatEntity.id ?? -1;
      portrait = silentChatEntity.portrait ?? "";
    }
    var db = DBManager();
    List<GlobalImageCacheData> list = await GlobalImageCacheDao(db).selectImageCacheOwner(ownerId);
    //如果目标src不为空
    if(imgSrc != ""){
      _insertGlobalImageCache(ownerId, imgSrc);
    }
    //添加头像信息至缓存
    if(list.isEmpty){
      _insertGlobalImageCache(ownerId, portrait);
    }else{
      //  全局缓存中已有数据
      var element = list.firstWhereOrNull((element) => element.key == portrait);
      if(element != null) {
        var targetFile = File(element.value);
        if(!targetFile.existsSync()){
          await CacheImageHandle.addImageCache(portrait);
          var newFile = await CacheImageHandle.getImageValue(portrait);
          Map<String,dynamic> map = element.toJson();
          map["value"] = newFile.path;
          GlobalImageCacheData cloneData = GlobalImageCacheData.fromJson(map);
          await GlobalImageCacheDao(db).updateImageCache(cloneData);
          Log.i("更新图像缓存数据");
        }
        Log.i("已存在这条数据");
        return;
      }else{
        _insertGlobalImageCache(ownerId, portrait);
      }

    }
  }

  /*
   * @author Marinda
   * @date 2023/9/8 15:25
   * @description 构建全局图片缓存
   */
  _buildGlobalImageCacheCompanion(String portrait,String path,int ownerId){
    return GlobalImageCacheCompanion(
        type: drift.Value(CacheImageType.FILE.value),
        key: drift.Value(portrait),
        value: drift.Value(path),
        blobValue: drift.Value(Uint8List.fromList([])),
        owner: drift.Value(ownerId)
    );
  }

  /*
   * @author Marinda
   * @date 2023/9/9 16:49
   * @description 插入图片缓存
   */
  _insertGlobalImageCache(int ownerId,String src) async{
    await CacheImageHandle.addImageCache(src);
    var file = await CacheImageHandle.getImageValue(src);
    var companion = _buildGlobalImageCacheCompanion(src, file.path, ownerId);
    var result = await GlobalImageCacheDao(DBManager()).insertImageCache(companion);
    Log.i("插入图片缓存结果：${result}");
  }
}
