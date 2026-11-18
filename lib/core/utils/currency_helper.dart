import 'package:intl/intl.dart';

class CurrencyHelper {
  CurrencyHelper._();

  static String formatAmount({
    required double amount,
    required String currencyCode,
  }) {
    final formatter = NumberFormat.currency(
      symbol: '$currencyCode ',
      decimalDigits: 2,
    );

    return formatter.format(amount);
  }
}