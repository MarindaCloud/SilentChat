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

  int? get code => _code;
  set code(int? code) => _code = code;
  dynamic get data => _data;
  set data(dynamic data) => _data = data;
  String? get msg => _msg;
  set msg(String? msg) => _msg = msg;

  APIResult.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _data = json['data'];
    _msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    data['data'] = this._data;
    data['msg'] = this._msg;
    return data;
  }
}