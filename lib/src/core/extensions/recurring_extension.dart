import 'package:hive_flutter/adapters.dart';
import 'package:sika_purse/src/data/expense/model/expense_model.dart';
import 'package:sika_purse/src/data/recurring/model/recurring.dart';

extension RecurringModelBoxHelper on Box<RecurringModel> {}

extension RecurringModelHelper on RecurringModel {
  ExpenseModel toExpenseModel(DateTime time) {
    return ExpenseModel(
      name: name,
      currency: amount,
      time: time,
      type: transactionType,
      accountId: accountId,
      categoryId: categoryId,
    );
  }
}
