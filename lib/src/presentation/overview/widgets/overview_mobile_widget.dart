import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../summary/controller/summary_controller.dart';
import '../../widgets/filter_widget/sika_purse_filter_transaction_widget.dart';
import '../../widgets/sika_purse_pill_chip.dart';
import '../cubit/budget_cubit.dart';
import '../pages/overview_page.dart';

class OverviewMobile extends StatelessWidget {
  const OverviewMobile({
    super.key,
    required this.summaryController,
    required this.budgetCubit,
  });

  final BudgetCubit budgetCubit;
  final SummaryController summaryController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TransactionTypeSegmentedWidget(summaryController: summaryController),
        BlocBuilder(
          bloc: budgetCubit,
          buildWhen: (previous, current) => current is InitialSelectedState,
          builder: (context, state) {
            if (state is InitialSelectedState) {
              return SizedBox(
                height: 70,
                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    const SikaPurseFilterTransactionWidget(),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        scrollDirection: Axis.horizontal,
                        itemCount: state.filerTimes.length,
                        itemBuilder: (context, index) {
                          final item = state.filerTimes[index];
                          return SikaPursePillChip(
                            title: item,
                            onPressed: () {
                              if (budgetCubit.selectedTime != item) {
                                budgetCubit.updateFilterTime(item);
                              }
                            },
                            isSelected: item == budgetCubit.selectedTime,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
