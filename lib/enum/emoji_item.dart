/**
 * @author Marinda
 * @date 2023/6/19 14:11
 * @description  emojiItem
 */
enum EmojiItem{
  //大笑
  LAUGH("😄"),
  //嘿嘿
  HEY("😋"),
  //难过
  UPSET("😞"),
  //  笑哭了
  JOY("😂"),
  //  苦笑
  SWEATSMILE("😅"),
  // 羞涩
  BLUSH("😊"),
  //微笑天使
  INNOCENT("😇"),
  //爱慕
  HEART_EYES("😍"),
  //亲吻
  KISS("😘"),
  //好吃
  FODD("😋"),
  //吐舌
  TONGUE("😛"),
  //滑稽
  ZANY_FACE("🤪"),
  ZANY_FACE_2("😝"),
  //想一想
  THINKING("🤔"),
  //可怜
  PLEADING("🥺"),
  //沉默
  NO_MOUTH("😶"),
  //沉默
  SMIRK("😏"),
  //不高兴
  UNAMUSED("😒"),
  //白眼
  ROLL_EYES("🙄"),
  //咧嘴笑
  GRIMACING("😬"),
  //睡着啦
  DROOLING_FACE("🤤"),
  //睡了
  SLEEP("😴"),
  //墨镜
  SUNGLASSES("😎"),
  //感冒了
  MASK("😷");
  const EmojiItem(this.emote);
  //表情
  final String emote;
}