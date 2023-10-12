import 'package:flutter/material.dart';
import 'package:sika_purse/src/core/common.dart';
import 'package:sika_purse/src/core/enum/filter_expense.dart';

extension FilterExpenseHelper on FilterExpense {
  String stringValue(BuildContext context) {
    switch (this) {
      case FilterExpense.daily:
        return context.loc.daily;
      case FilterExpense.weekly:
        return context.loc.weekly;
      case FilterExpense.monthly:
        return context.loc.monthly;
      case FilterExpense.yearly:
        return context.loc.yearly;
      case FilterExpense.all:
        return context.loc.all;
    }
  }
}
