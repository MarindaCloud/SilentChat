import 'dart:io';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;


class Log {
  static Logger? _logger;

  static initLogger() async {
    File file = File(await filePath());
    final multiOutput = MultiOutput([FileOutput(file: file), ConsoleOutput()]);
    _logger = Logger(
      filter: ProductionFilter(),
        printer: PrefixPrinter(PrettyPrinter(
          stackTraceBeginIndex: 5,
          methodCount: 1,
          printEmojis: false,
          printTime: true,
        )),
        output: multiOutput);
  }

  static filePath() async {
    DateTime now = DateTime.now();
    Directory documentsFolder = await getApplicationDocumentsDirectory();
    Directory fileFolder = Directory(p.join(documentsFolder.path, 'logger'));
    if (!await fileFolder.exists()) {
      await fileFolder.create(recursive: true);
    }
    return p.join(fileFolder.path, '${now.year}-${now.month}-${now.day}.log');
  }

  static void v(dynamic message) {
    _logger?.v(message);
  }

  static void d(dynamic message) {
    _logger?.d(message);
  }

  static void i(dynamic message) {
    _logger?.i(message);
  }

  static void w(dynamic message) {
    _logger?.w(message);
  }

  static void e(dynamic message) {
    _logger?.e(message);
  }
}
