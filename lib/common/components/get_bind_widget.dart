import 'package:flutter/material.dart';
import 'package:get/get.dart';

/*
 * @author Marinda
 * @date 2023/9/6 16:57
 * @description 自动回收
 */
class GetBindWidget extends StatefulWidget {
  const GetBindWidget({
    Key? key,
    this.bind,
    this.tag,
    this.binds,
    this.tags,
    required this.child,
  })  : assert(
          binds == null || tags == null || binds.length == tags.length,
          'The binds and tags arrays length should be equal\n'
          'and the elements in the two arrays correspond one-to-one',
        ),
        super(key: key);

  final GetxController? bind;
  final String? tag;

  final List<GetxController>? binds;
  final List<String>? tags;

  final Widget child;

  @override
  State createState() => _GetBindWidgetState();
}

class _GetBindWidgetState extends State<GetBindWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    _closeGetXController();
    _closeGetXControllers();

    super.dispose();
  }

  ///Close GetxController bound to the current page
  void _closeGetXController() {
    if (widget.bind == null) {
      return;
    }

    var key = widget.bind.runtimeType.toString() + (widget.tag ?? '');
    GetInstance().delete(key: key, force: true);
    // GetInstance().
  }

  ///Batch close GetxController bound to the current page
  void _closeGetXControllers() {
    if (widget.binds == null) {
      return;
    }

    for (var i = 0; i < widget.binds!.length; i++) {
      var type = widget.binds![i].runtimeType.toString();

      if (widget.tags == null) {
        GetInstance().delete(key: type, force: true );
      } else {
        var key = type + (widget.tags?[i] ?? '');
        GetInstance().delete(key: key, force: true );
      }
    }
  }
}
