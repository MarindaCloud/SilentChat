import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:silentchat/enum/emoji_item.dart';
import 'package:silentchat/util/log.dart';
/**
 * @author Marinda
 * @date 2023/6/19 13:53
 * @description  emoji处理
 */
class EmojiCommon{
  final parseEmoji = EmojiParser();
  //单例模式
  static final EmojiCommon _instance = EmojiCommon.instance();

  /*
   * @author Marinda
   * @date 2023/6/19 14:18
   * @description 构建Emoji控件
   */
  Widget buildEmoji(int total,{Function? cbFunction}){
    List<Widget> emojiWidgetList = [];
    List<EmojiItem> emojiList = EmojiItem.values;
    for(var emoji in emojiList){
      String emote = emoji.emote;
      Widget emoteWidget = InkWell(
          child: Text(emote,style: TextStyle(fontSize: 25),),
          onTap: (){
            if(cbFunction != null){
              cbFunction(emote);
              return;
            }
            Log.i("当前表情：${emote}");
          },
      );
      emojiWidgetList.add(emoteWidget);
    }
    return GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: total,
            crossAxisSpacing: 20,
        ),
      children: emojiWidgetList,
    );
  }


  EmojiCommon.instance();

  factory EmojiCommon(){
   return _instance;
  }


}