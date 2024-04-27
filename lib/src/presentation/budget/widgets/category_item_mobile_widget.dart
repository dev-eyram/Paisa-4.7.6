import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../../../data/category/model/category_model.dart';
import '../../widgets/sika_purse_card.dart';

class CategoryItemMobileWidget extends StatelessWidget {
  const CategoryItemMobileWidget({
    Key? key,
    required this.category,
    required this.onPressed,
  }) : super(key: key);

  final CategoryModel category;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SikaPurseFilledCard(
      child: ListTile(
        onTap: () => context.pushNamed(
          editCategoryName,
          pathParameters: <String, String>{'cid': category.superId.toString()},
        ),
        leading: CircleAvatar(
          backgroundColor: Color(category.color ?? Colors.amber.shade100.value).withOpacity(0.3),
          child: Icon(
            IconData(
              category.icon,
              fontFamily: fontFamilyName,
              fontPackage: fontFamilyPackageName,
            ),
            size: 28,
            color: Color(category.color ?? Colors.amber.shade100.value),
          ),
        ),
        title: Text(
          category.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: context.titleMedium?.copyWith(
            color: context.onSurfaceVariant,
          ),
        ),
        subtitle: category.description == null
            ? null
            : Text(
                category.description!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.75),
                ),
              ),
        trailing: IconButton(
          onPressed: onPressed,
          icon: Icon(
            Icons.delete_rounded,
            color: context.error,
          ),
        ),
      ),
    );
  }
}
