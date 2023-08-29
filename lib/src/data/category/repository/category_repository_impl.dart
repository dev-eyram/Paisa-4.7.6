import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/category/repository/category_repository.dart';
import '../data_sources/category_local_data_source.dart';
import '../model/category_model.dart';

@Singleton(as: CategoryRepository)
class CategoryRepositoryImpl extends CategoryRepository {
  CategoryRepositoryImpl({
    required this.dataSources,
    @Named('settings') required this.settings,
  });

  final LocalCategoryDataManager dataSources;
  final Box<dynamic> settings;

  @override
  Future<void> addCategory({
    required String name,
    required int icon,
    required int color,
    String? desc,
    bool isBudget = false,
    double? budget = -1,
  }) =>
      dataSources.addCategory(CategoryModel(
        description: desc ?? '',
        name: name,
        icon: icon,
        budget: budget,
        isBudget: isBudget,
        color: color,
      ));

  @override
  Future<void> clearAll() => dataSources.clearAll();

  @override
  Future<void> deleteCategory(int key) => dataSources.deleteCategory(key);

  @override
  CategoryModel? fetchCategoryFromId(int categoryId) =>
      dataSources.fetchCategoryFromId(categoryId);

  @override
  Future<void> updateCategory({
    required int key,
    required String name,
    required int icon,
    required int color,
    String? desc,
    double? budget = -1,
    bool isBudget = false,
  }) {
    return dataSources.updateCategory(CategoryModel(
      description: desc ?? '',
      name: name,
      icon: icon,
      budget: budget,
      isBudget: isBudget,
      color: color,
      superId: key,
    ));
  }
}
