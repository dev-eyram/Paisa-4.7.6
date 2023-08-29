import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../domain/category/entities/category.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../main.dart';
import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../../../data/category/model/category_model.dart';
import '../bloc/expense_bloc.dart';

class SelectCategoryIcon extends StatelessWidget {
  const SelectCategoryIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<CategoryModel>>(
      valueListenable: getIt.get<Box<CategoryModel>>().listenable(),
      builder: (context, value, child) {
        final List<Category> categories = value.values.toEntities();

        if (categories.isEmpty) {
          return ListTile(
            onTap: () => context.pushNamed(addCategoryPath),
            title: Text(context.loc.addCategoryEmptyTitle),
            subtitle: Text(context.loc.addCategoryEmptySubTitle),
            trailing: const Icon(Icons.keyboard_arrow_right),
          );
        }

        return ScreenTypeLayout(
          tablet: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  context.loc.selectCategory,
                  style: context.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SelectedItem(
                categories: categories,
              )
            ],
          ),
          mobile: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  context.loc.selectCategory,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              SelectedItem(
                categories: categories,
              )
            ],
          ),
        );
      },
    );
  }
}

class SelectedItem extends StatelessWidget {
  const SelectedItem({
    super.key,
    required this.categories,
  });

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    late final expenseBloc = BlocProvider.of<ExpenseBloc>(context);
    return BlocBuilder(
      bloc: expenseBloc,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 12.0,
            runSpacing: 12.0,
            children: List.generate(
              categories.length + 1,
              (index) {
                if (index == 0) {
                  return FilterChip(
                    onSelected: (value) => context.pushNamed(addCategoryPath),
                    avatar: Icon(
                      color: context.primary,
                      IconData(
                        MdiIcons.plus.codePoint,
                        fontFamily: fontFamilyName,
                        fontPackage: fontFamilyPackageName,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                      side: BorderSide(
                        width: 1,
                        color: context.primary,
                      ),
                    ),
                    showCheckmark: false,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    label: Text(
                      context.loc.addNew,
                      style: TextStyle(
                        color: context.primary,
                      ),
                    ),
                    labelStyle: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: context.onSurfaceVariant),
                    padding: const EdgeInsets.all(12),
                  );
                } else {
                  final Category category = categories[index - 1];
                  return FilterChip(
                    selected:
                        category.superId == expenseBloc.selectedCategoryId,
                    onSelected: (value) =>
                        expenseBloc.add(ChangeCategoryEvent(category)),
                    avatar: Icon(
                      color: category.superId == expenseBloc.selectedCategoryId
                          ? context.primary
                          : context.onSurfaceVariant,
                      IconData(
                        category.icon,
                        fontFamily: fontFamilyName,
                        fontPackage: fontFamilyPackageName,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                      side: BorderSide(
                        width: 1,
                        color: context.primary,
                      ),
                    ),
                    showCheckmark: false,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    label: Text(category.name),
                    labelStyle: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                            color: category.superId ==
                                    expenseBloc.selectedCategoryId
                                ? context.primary
                                : Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant),
                    padding: const EdgeInsets.all(12),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
