/**
 * @author Marinda
 * @date 2023/5/25 10:45
 * @description 全局Page
 */
enum GlobalPage {
  login("/login"),
  message("/message"),
  contact("/contact"),
  main("/index"),
  dynamic("/dynamic"),
  chat("/chat"),
  append("/append"),
  userInfo("/userInfo"),
  qr("/qr"),
  appendMessage("/appendMessage"),
  verify("/verify");

  final String router;
  const GlobalPage(this.router);
}