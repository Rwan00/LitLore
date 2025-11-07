import 'package:logger/logger.dart';

const kTransitionDuration = Duration(seconds: 3);

var logger = Logger(printer: PrettyPrinter());

class AppConsts {
  static String accessToken = '';
  static String refreshToken = '';
}
