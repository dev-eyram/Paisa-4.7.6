import 'package:flutter/material.dart';
import 'package:sika_purse/src/domain/category/entities/category.dart';

class BudgetCategories extends ChangeNotifier {
  List<Category> nonBudgetCategories = [];
  List<Category> budgetCategories = [];

  setNonBudgetCategories(List<Category> categories) {
    nonBudgetCategories = categories;
    // print("nonBudgetCategories Set");
    // print(nonBudgetCategories);
  }

  List<Category> getNonBudgetCategories() {
    return nonBudgetCategories;
  }

  setBudgetCategories(List<Category> categories) {
    budgetCategories = categories;
    // print("budgetCategories Set");
    // print(budgetCategories);
  }

  List<Category> getBudgetCategories() {
    return budgetCategories;
  }
}
