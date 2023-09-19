import 'package:flutter/material.dart';
import 'package:paisa/src/core/theme/color_extension.dart';

import '../../widgets/paisa_annotate_region_widget.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PaisaAnnotatedRegionWidget(
      color: context.background,
      child: Scaffold(body: Container()
          // ValueListenableBuilder<Box<RecurringModel>>(
          //   valueListenable: getIt.get<Box<RecurringModel>>().listenable(),
          //   builder: (_, value, child) {
          //     final List<RecurringModel> recurringModels = value.values.toList();
          //     if (recurringModels.isEmpty) {
          //       return EmptyWidget(
          //         title: context.loc.recurringEmptyMessageTitle,
          //         description: context.loc.recurringEmptyMessageSubTitle,
          //         icon: MdiIcons.cashSync,
          //         actionTitle: context.loc.recurringAction,
          //         onActionPressed: () {
          //           GoRouter.of(context).pushNamed(recurringName);
          //         },
          //       );
          //     }
          //     return RecurringListWidget(recurringModels: recurringModels);
          //   },
          // ),
          ),
    );
  }
}
