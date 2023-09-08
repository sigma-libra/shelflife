import 'package:flutter/material.dart';
import 'package:shelflife/product/product.dart';

class Utils {
  static int randomId() {
    return UniqueKey().hashCode;
  }

  static String formatPrettyDate(DateTime dateTime) {
    return "${_addLeadingZero(dateTime.day)}/${_addLeadingZero(dateTime.month)}/${_addLeadingZero(dateTime.year)}";
  }

  static String _addLeadingZero(int number) {
    if (number < 10) {
      return "0$number";
    } else {
      return "$number";
    }
  }

  static int monthsLeftOnProduct(Product product) {
    return (product.monthsToReplacement! - (DateTime.fromMillisecondsSinceEpoch(product.saveTime).difference(DateTime.now()).inDays / 30)).toInt();
  }
}
