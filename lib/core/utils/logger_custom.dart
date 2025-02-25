import 'package:logger/logger.dart';

var logg = Logger(
  filter: null,
  output: null,
  printer: GreenPrinter(),
);

class GreenPrinter extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    const green = '\x1B[32m';
    const reset = '\x1B[0m';
    return ["$green${event.message}$reset"];
  }
}