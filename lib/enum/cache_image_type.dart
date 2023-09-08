/**
 * @author Marinda
 * @date 2023/9/8 14:40
 * @description 缓存图片类型
 */
enum CacheImageType {
  FILE(1),BLOB(2);

  final int value;
  const CacheImageType(this.value);

}