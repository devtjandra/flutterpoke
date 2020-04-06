import 'package:flutterpoke/models.dart';

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

String formatUnderscore(String s) {
  List<String> values = s.split('-');
  String result = "";

  for (String value in values) {
    result += " " + capitalize(value);
  }

  return result.trim();
}

String formatStat(StatPlaceholder stat) {
  return stat.baseStat.toString() +
      (stat.effort > 0 ? " + " + stat.effort.toString() : "");
}

String formatCaptureRate(int rate) {
  return ((rate * 100) ~/ 255).toString() + "%";
}

String formatGenderRate(int rate) {
  if (rate == -1)
    return "Genderless";
  else
    return ((rate * 100) ~/ 8).toString() + "% Female";
}
