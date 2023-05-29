// ignore_for_file: constant_identifier_names, public_member_api_docs

// TODO(fmotalleb): change ansi color system.
// two separated parts colors/styles.

/// Colors that ansi format supports
enum AnsiColor {
  RESET('\x1B[0;0m'),
  BLACK('\x1B[0;30m'),
  RED('\x1B[0;31m'),
  GREEN('\x1B[0;32m'),
  YELLOW('\x1B[0;33m'),
  BLUE('\x1B[0;34m'),
  MAGENTA('\x1B[0;35m'),
  CYAN('\x1B[0;36m'),
  WHITE('\x1B[0;37m'),
  BLACK_BOLD('\x1B[1;30m'),
  RED_BOLD('\x1B[1;31m'),
  GREEN_BOLD('\x1B[1;32m'),
  YELLOW_BOLD('\x1B[1;33m'),
  BLUE_BOLD('\x1B[1;34m'),
  MAGENTA_BOLD('\x1B[1;35m'),
  CYAN_BOLD('\x1B[1;36m'),
  WHITE_BOLD('\x1B[1;37m'),
  BLACK_UNDERLINED('\x1B[4;30m'),
  RED_UNDERLINED('\x1B[4;31m'),
  GREEN_UNDERLINED('\x1B[4;32m'),
  YELLOW_UNDERLINED('\x1B[4;33m'),
  BLUE_UNDERLINED('\x1B[4;34m'),
  MAGENTA_UNDERLINED('\x1B[4;35m'),
  CYAN_UNDERLINED('\x1B[4;36m'),
  WHITE_UNDERLINED('\x1B[4;37m'),
  BLACK_BACKGROUND('\x1B[40m'),
  RED_BACKGROUND('\x1B[41m'),
  GREEN_BACKGROUND('\x1B[42m'),
  YELLOW_BACKGROUND('\x1B[43m'),
  BLUE_BACKGROUND('\x1B[44m'),
  MAGENTA_BACKGROUND('\x1B[45m'),
  CYAN_BACKGROUND('\x1B[46m'),
  WHITE_BACKGROUND('\x1B[47m'),
  BLACK_BRIGHT('\x1B[90m'),
  RED_BRIGHT('\x1B[91m'),
  GREEN_BRIGHT('\x1B[92m'),
  YELLOW_BRIGHT('\x1B[93m'),
  BLUE_BRIGHT('\x1B[94m'),
  MAGENTA_BRIGHT('\x1B[95m'),
  CYAN_BRIGHT('\x1B[96m'),
  WHITE_BRIGHT('\x1B[97m'),
  BLACK_BOLD_BRIGHT('\x1B[1;90m'),
  RED_BOLD_BRIGHT('\x1B[1;91m'),
  GREEN_BOLD_BRIGHT('\x1B[1;92m'),
  YELLOW_BOLD_BRIGHT('\x1B[1;93m'),
  BLUE_BOLD_BRIGHT('\x1B[1;94m'),
  MAGENTA_BOLD_BRIGHT('\x1B[1;95m'),
  CYAN_BOLD_BRIGHT('\x1B[1;96m'),
  WHITE_BOLD_BRIGHT('\x1B[1;97m'),
  BLACK_BACKGROUND_BRIGHT('\x1B[100m'),
  RED_BACKGROUND_BRIGHT('\x1B[101m'),
  GREEN_BACKGROUND_BRIGHT('\x1B[102m'),
  YELLOW_BACKGROUND_BRIGHT('\x1B[103m'),
  BLUE_BACKGROUND_BRIGHT('\x1B[104m'),
  MAGENTA_BACKGROUND_BRIGHT('\x1B[105m'),
  CYAN_BACKGROUND_BRIGHT('\x1B[106m'),
  WHITE_BACKGROUND_BRIGHT('\x1B[107m');

  const AnsiColor(
    this._code,
  );
  final String _code;

  /// {@template color_wrapper}
  /// wraps text into the code of selected color and
  /// adds a reset code after text
  /// {@endtemplate}
  String wrap(String text) {
    return '$_code$text${AnsiColor.RESET._code}';
  }

  /// {@macro color_wrapper}
  String call(String text) => wrap(text);
}
