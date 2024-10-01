import 'package:intl/intl.dart';

String percentFormatter(double data) {
  String formattedNumber = data.toStringAsFixed(2);
  formattedNumber = formattedNumber.replaceAll(RegExp(r"0*$"), "");
  final lastChar = formattedNumber[formattedNumber.length - 1];
  if (lastChar == '.') {
    formattedNumber = formattedNumber.substring(0, formattedNumber.length - 1);
  }
  return formattedNumber;
}

String doubleFormatter(double data) {
  RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
  String s = data.toString().replaceAll(regex, '');
  return s;
}

String doubleToExact(double value) {
  var sign = "";
  if (value < 0) {
    value = -value;
    sign = "-";
  }
  var string = value.toString();
  var e = string.lastIndexOf('e');
  if (e < 0) return "$sign$string";
  assert(string.indexOf('.') == 1);
  var offset =
      int.parse(string.substring(e + (string.startsWith('-', e + 1) ? 1 : 2)));
  var digits = string.substring(0, 1) + string.substring(2, e);
  if (offset < 0) {
    return "${sign}0.${"0" * ~offset}$digits";
  }
  if (offset > 0) {
    if (offset >= digits.length) return sign + digits.padRight(offset + 1, "0");
    return "$sign${digits.substring(0, offset + 1)}"
        ".${digits.substring(offset + 1)}";
  }
  return digits;
}

String dateFormatUI(DateTime date, {String? format}) {
  return DateFormat(format ?? "dd MMMM yyyy", 'id').format(date);
}

String dateFormatAPI(DateTime date) {
  return DateFormat("dd-MM-yyyy", 'id').format(date);
}

String monthFormatter(int month, {String pattren = 'MMM'}) {
  return DateFormat(pattren, 'id').format(DateTime(0, month));
}

String moneyFormatter(double money) {
  return NumberFormat.currency(
    locale: 'id',
    symbol: "Rp",
    decimalDigits: 0,
  ).format(money);
}

String numberFormatter(double money) {
  return NumberFormat.currency(
    locale: 'id',
    symbol: "",
    decimalDigits: 0,
  ).format(money);
}
