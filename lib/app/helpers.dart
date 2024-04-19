import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//* Clase de utilidades para utilizar en cualquier punto de la app
//* Si esto llegase a crecer excesivamente se crearían clases independientes o incluso extensiones
class Helpers {
  void hideKeyboard(BuildContext context){
    FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
  }

  String capitalize(String string) {
    if (string.isEmpty) return string;
    return string[0].toUpperCase() + string.substring(1);
  }

  String uncapitalize(String string) {
    if (string.isEmpty) return string;
    return string[0].toLowerCase() + string.substring(1);
  }

  String formatNumber(double number, [int decimals = 0]) {
    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: decimals,
      symbol: '',
      locale: 'es'
    ).format(number);
    return formattedNumber;
  }

}
