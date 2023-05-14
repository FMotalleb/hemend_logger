// ignore_for_file: constant_identifier_names

enum AnsiColors {
  //Color end string, color reset
  RESET('\x1B[0;0m'),

  // Regular Colors. Normal color, no bold, background color etc.
  BLACK('\x1B[0;30m'), // BLACK
  RED('\x1B[0;31m'), // RED
  GREEN('\x1B[0;32m'), // GREEN
  YELLOW('\x1B[0;33m'), // YELLOW
  BLUE('\x1B[0;34m'), // BLUE
  MAGENTA('\x1B[0;35m'), // MAGENTA
  CYAN('\x1B[0;36m'), // CYAN
  WHITE('\x1B[0;37m'), // WHITE

  // Bold
  BLACK_BOLD('\x1B[1;30m'), // BLACK
  RED_BOLD('\x1B[1;31m'), // RED
  GREEN_BOLD('\x1B[1;32m'), // GREEN
  YELLOW_BOLD('\x1B[1;33m'), // YELLOW
  BLUE_BOLD('\x1B[1;34m'), // BLUE
  MAGENTA_BOLD('\x1B[1;35m'), // MAGENTA
  CYAN_BOLD('\x1B[1;36m'), // CYAN
  WHITE_BOLD('\x1B[1;37m'), // WHITE

  // Underline
  BLACK_UNDERLINED('\x1B[4;30m'), // BLACK
  RED_UNDERLINED('\x1B[4;31m'), // RED
  GREEN_UNDERLINED('\x1B[4;32m'), // GREEN
  YELLOW_UNDERLINED('\x1B[4;33m'), // YELLOW
  BLUE_UNDERLINED('\x1B[4;34m'), // BLUE
  MAGENTA_UNDERLINED('\x1B[4;35m'), // MAGENTA
  CYAN_UNDERLINED('\x1B[4;36m'), // CYAN
  WHITE_UNDERLINED('\x1B[4;37m'), // WHITE

  // Background
  BLACK_BACKGROUND('\x1B[40m'), // BLACK
  RED_BACKGROUND('\x1B[41m'), // RED
  GREEN_BACKGROUND('\x1B[42m'), // GREEN
  YELLOW_BACKGROUND('\x1B[43m'), // YELLOW
  BLUE_BACKGROUND('\x1B[44m'), // BLUE
  MAGENTA_BACKGROUND('\x1B[45m'), // MAGENTA
  CYAN_BACKGROUND('\x1B[46m'), // CYAN
  WHITE_BACKGROUND('\x1B[47m'), // WHITE

  // High Intensity
  BLACK_BRIGHT('\x1B[90m'), // BLACK
  RED_BRIGHT('\x1B[91m'), // RED
  GREEN_BRIGHT('\x1B[92m'), // GREEN
  YELLOW_BRIGHT('\x1B[93m'), // YELLOW
  BLUE_BRIGHT('\x1B[94m'), // BLUE
  MAGENTA_BRIGHT('\x1B[95m'), // MAGENTA
  CYAN_BRIGHT('\x1B[96m'), // CYAN
  WHITE_BRIGHT('\x1B[97m'), // WHITE

  // Bold High Intensity
  BLACK_BOLD_BRIGHT('\x1B[1;90m'), // BLACK
  RED_BOLD_BRIGHT('\x1B[1;91m'), // RED
  GREEN_BOLD_BRIGHT('\x1B[1;92m'), // GREEN
  YELLOW_BOLD_BRIGHT('\x1B[1;93m'), // YELLOW
  BLUE_BOLD_BRIGHT('\x1B[1;94m'), // BLUE
  MAGENTA_BOLD_BRIGHT('\x1B[1;95m'), // MAGENTA
  CYAN_BOLD_BRIGHT('\x1B[1;96m'), // CYAN
  WHITE_BOLD_BRIGHT('\x1B[1;97m'), // WHITE

  // High Intensity backgrounds
  BLACK_BACKGROUND_BRIGHT('\x1B[100m'), // BLACK
  RED_BACKGROUND_BRIGHT('\x1B[101m'), // RED
  GREEN_BACKGROUND_BRIGHT('\x1B[102m'), // GREEN
  YELLOW_BACKGROUND_BRIGHT('\x1B[103m'), // YELLOW
  BLUE_BACKGROUND_BRIGHT('\x1B[104m'), // BLUE
  MAGENTA_BACKGROUND_BRIGHT('\x1B[105m'), // MAGENTA
  CYAN_BACKGROUND_BRIGHT('\x1B[106m'), // CYAN
  WHITE_BACKGROUND_BRIGHT('\x1B[107m'); // WHITE

  const AnsiColors(
    this.code,
  );
  final String code;
  String wrap(String text) {
    return '$code$text${AnsiColors.RESET}';
  }

  String call(String text) => wrap(text);

  @override
  String toString() => code;
}
