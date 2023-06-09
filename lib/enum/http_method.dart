/**
 * @author Marinda
 * @date 2023/6/9 15:59
 * @description Http请求方法
 */
enum HttpMethods {
  POST("post"),GET("get");

  const HttpMethods(this.value);

  final String value;
}