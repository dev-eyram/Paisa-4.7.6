import 'package:flutter/material.dart';

import '../../../core/common.dart';
import '../../../domain/category/entities/category.dart';
import '../../widgets/sika_purse_bottom_sheet.dart';
import '../bloc/category_bloc.dart';
import '../widgets/category_item_mobile_widget.dart';

class CategoryListMobileWidget extends StatelessWidget {
  const CategoryListMobileWidget({
    Key? key,
    required this.addCategoryBloc,
    required this.categories,
  }) : super(key: key);

  final CategoryBloc addCategoryBloc;
  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 124),
      itemCount: categories.length,
      shrinkWrap: true,
      itemBuilder: (_, index) {
        return CategoryItemMobileWidget(
          category: categories[index],
          onPressed: () => sikaPurseAlertDialog(
            context,
            title: Text(
              context.loc.dialogDeleteTitle,
            ),
            child: RichText(
              text: TextSpan(
                text: context.loc.deleteCategory,
                children: [
                  TextSpan(
                    text: categories[index].name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                style: context.bodyLarge,
              ),
            ),
            confirmationButton: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              onPressed: () {
                addCategoryBloc.add(CategoryDeleteEvent(categories[index]));
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ),
        );
      },
    );
  }
}
