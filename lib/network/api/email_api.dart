import 'package:silentchat/entity/api_result.dart';
import 'package:silentchat/enum/http_method.dart';
import 'package:silentchat/network/api/base_provider.dart';
import 'package:silentchat/network/request.dart';
import 'package:silentchat/util/log.dart';

/**
 * @author Marinda
 * @date 2023/9/5 14:08
 * @description 邮箱API
 */
class EmailAPI{

  /*
   * @author Marinda
   * @date 2023/9/5 14:11
   * @description 发送验证码
   */
  static sendVerifyCode(String prefix,String to) async{
    Log.i("发送验证码");
    var data = {
      "to": to,
      "prefix": prefix
    };
    var response = await BaseProvider.sendRequest("mail/sendVerify", HttpMethods.POST.value,data,header: Request.getHeader());
    APIResult apiResult = Request.toAPIResult(response);
    String verifyCode = apiResult.data;
    Log.i("验证码为：${verifyCode}");
    return verifyCode;
  }

}