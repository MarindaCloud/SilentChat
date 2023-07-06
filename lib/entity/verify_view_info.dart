import 'package:silentchat/entity/user.dart';
import 'verify.dart';
/**
 * @author Marinda
 * @date 2023/7/5 10:22
 * @description 验证视图的消息
 */
class VerifyViewInfo {

  User? user;
  Verify? verify;
  VerifyViewInfo({this.user,this.verify});

  get getUser => user;
  get getVerify => verify;

  set setUser(User? user) => this.user = user;
  set setVerify(Verify? verify) => this.verify = verify;
}