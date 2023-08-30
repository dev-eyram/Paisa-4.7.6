import 'package:flutter/foundation.dart';

import '../../core/enum/transaction_type.dart';
import '../../domain/expense/entities/expense.dart';
import '../../presentation/widgets/budget.dart';
import '../category/model/category_model.dart';

List<Budget> generateNewBudgets(List<Expense> expenses, double totalIncome,
    List<CategoryModel> allCategories) {
  // Calculate total expenses from the provided list of expenses
  double totalExpenses = expenses
      .where((expense) => expense.type == TransactionType.expense)
      .fold<double>(0, (sum, expense) => sum + expense.currency);

  // Calculate remaining balance after deducting expenses from income
  double remainingBalance = totalIncome - totalExpenses;

  // Define categories and allocation percentages for the budgets
  List<Category> budgetCategories = allCategories
      .where((category) => category.isBudget)
      .map((category) => Category(category as List<String>, category.budget!))
      .toList();

  // Calculate the sum of allocation percentages
  double totalAllocationPercentage = budgetCategories.fold<double>(
      0, (sum, category) => sum + category.allocationPercentage);

  // Calculate allocated amounts for each budget category based on allocation percentages
  List<double> allocatedAmounts = budgetCategories
      .map((category) =>
          remainingBalance *
          (category.allocationPercentage / totalAllocationPercentage))
      .toList();

  // Create budgets with adjusted allocated amounts
  List<Budget> newBudgets = budgetCategories.asMap().entries.map((entry) {
    int index = entry.key;
    Category category = entry.value;
    CategoryModel category = budgetCategory.category;
    double allocatedAmount = allocatedAmounts[index];
    return Budget('Budget ${category.name}', allocatedAmount, [budgetCategory]);
  }).toList();

  return newBudgets;
}
