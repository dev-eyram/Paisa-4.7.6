import 'package:flutter/material.dart';
import 'package:sika_purse/src/core/common.dart';
import 'package:sika_purse/src/core/enum/debt_type.dart';

extension DebtTypeHelper on DebtType {
  String stringValue(BuildContext context) {
    switch (this) {
      case DebtType.debt:
        return context.loc.debt;
      case DebtType.credit:
        return context.loc.credit;
    }
  }
}
