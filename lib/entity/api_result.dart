/**
 * @author Marinda
 * @date 2023/6/8 16:46
 * @description 接口请求结果
 */
class APIResult {
  int? _code;
  dynamic _data;
  String? _msg;

  APIResult({int? code, dynamic? data, String? msg}) {
    if (code != null) {
      this._code = code;
    }
    if (data != null) {
      this._data = data;
    }
    if (msg != null) {
      this._msg = msg;
    }
  }

  /*
   * @author Marinda
   * @date 2023/6/12 10:48
   * @description 构建失败结果
   */
  static APIResult fail(String msg){
    APIResult result = APIResult(code: 400,data: null,msg: msg);
    return result;
  }

  /*
   * @author Marinda
   * @date 2023/6/12 10:48
   * @description 构建成功结果
   */
  static APIResult success(dynamic data){
    APIResult result = APIResult(code: 200,data: data,msg: "");
    return result;
  }

  int? get code => _code;
  set code(int? code) => _code = code;
  dynamic get data => _data;
  set data(dynamic data) => _data = data;
  String? get msg => _msg;
  set msg(String? msg) => _msg = msg;

  APIResult.fromJson(Map<String, dynamic> json) {
    if(json["code"] != null){
      _code = json["code"];
    }
    if(json["data"] != null){
      _data = json["data"];
    }
    if(json["msg"] != null){
      _msg = json["msg"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    data['data'] = this._data;
    data['msg'] = this._msg;
    return data;
  }
}