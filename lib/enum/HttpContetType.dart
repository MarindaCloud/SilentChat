/**
 * @author Marinda
 * @date 2023/6/9 16:16
 * @description HttpContentType
 */
enum HttpContentType{
  JSON("application/json"),FORMDATA("application/x-www-form-urlencoded");
  const HttpContentType(this.type);
  final String type;
}