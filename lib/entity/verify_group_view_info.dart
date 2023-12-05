import 'package:silentchat/entity/group.dart';
import 'package:silentchat/entity/user.dart';
import 'verify.dart';
/*
 * @author Marinda
 * @date 2023/12/2 15:12
 * @description 验证群组消息信息
 */
class VerifyGroupViewInfo {

  Group? group;
  Verify? verify;
  VerifyGroupViewInfo({this.group,this.verify});

  get getGroup => group;
  get getVerify => verify;

  set setGroup(Group? group) => this.group = group;
  set setVerify(Verify? verify) => this.verify = verify;
}