import 'package:logger/logger.dart';

var greenLogger = Logger(
  filter: null,
  output: null,
  printer: GreenPrinter(),
);

class GreenPrinter extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    const green = '\x1B[32m';  // Mã ANSI cho màu xanh lá cây
    const reset = '\x1B[0m';   // Reset màu về mặc định
    return ["$green${event.level}: ${event.message}$reset"];
  }
}