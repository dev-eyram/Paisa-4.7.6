import 'package:flutter/foundation.dart';

import '../../core/enum/transaction_type.dart';
import '../../domain/expense/entities/expense.dart';

class Budget {
  final String name;
  final double totalAmount;
  final List<Category> categories;

  Budget(this.name, this.totalAmount, this.categories);
}

// class BudgetCategory {
//   final String name;
//   final double allocationPercentage;
//
//   BudgetCategory(this.name, this.allocationPercentage);
// }

List<Budget> generateNewBudgets(List<Expense> expenses, double totalIncome) {
  // Calculate total expenses from the provided list of expenses
  double totalExpenses = expenses
      .where((expense) => expense.type == TransactionType.expense)
      .fold<double>(0, (sum, expense) => sum + expense.currency);

  // Calculate remaining balance after deducting expenses from income
  double remainingBalance = totalIncome - totalExpenses;

  // Define categories and allocation percentages for the budgets
  List<Category> categories = [
    Category(),
  ];

  List<Category> categories = [
    BudgetCategory('Entertainment', 0.4),
    BudgetCategory('Shopping', 0.6),
  ];

  List<BudgetCategory> categoriesC = [
    BudgetCategory('Healthcare', 0.3),
    BudgetCategory('Education', 0.7),
  ];

  // Allocate remaining balance proportionally to the categories
  double allocatedAmountA =
      remainingBalance * categoriesA[0].allocationPercentage;
  double allocatedAmountB =
      remainingBalance * categoriesB[0].allocationPercentage;
  double allocatedAmountC =
      remainingBalance * categoriesC[0].allocationPercentage;

  // Create budgets with adjusted allocated amounts
  List<Budget> newBudgets = [
    Budget('Budget A', allocatedAmountA, categoriesA),
    Budget('Budget B', allocatedAmountB, categoriesB),
    Budget('Budget C', allocatedAmountC, categoriesC),
  ];

  return newBudgets;
}
