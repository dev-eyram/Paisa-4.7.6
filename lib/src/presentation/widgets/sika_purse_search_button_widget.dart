import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sika_purse/src/core/common.dart';

import '../../app/routes.dart';

class SikaPurseSearchButtonWidget extends StatelessWidget {
  const SikaPurseSearchButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.search,
        color: context.onBackground,
      ),
      onPressed: () {
        GoRouter.of(context).pushNamed(searchName);
      },
    );
  }
}
