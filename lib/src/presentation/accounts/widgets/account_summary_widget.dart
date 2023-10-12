import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../core/common.dart';
import '../../../core/theme/custom_color.dart';
import '../../../domain/expense/entities/expense.dart';
import '../../widgets/sika_purse_expense_stats_widget.dart';

class AccountSummaryWidget extends StatelessWidget {
  const AccountSummaryWidget({
    super.key,
    required this.expenses,
    this.useAccountsList = false,
  });

  final List<Expense> expenses;
  final bool useAccountsList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 0,
            ),
            visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
            title: Text(
              context.loc.thisMonth,
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w600,
                textStyle: context.titleMedium,
                color: context.onBackground,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: SikaPurseExpenseStatsWidget(
                  title: context.loc.income,
                  total: expenses.thisMonthIncome.toFormateCurrency(),
                  data: expenses.incomeDoubleList,
                  graphLineColor: Theme.of(context).extension<CustomColors>()!.green ?? context.secondary,
                  iconData: MdiIcons.arrowBottomLeft,
                ),
              ),
              Expanded(
                child: SikaPurseExpenseStatsWidget(
                  title: context.loc.expense,
                  total: expenses.thisMonthExpense.toFormateCurrency(),
                  data: expenses.expenseDoubleList,
                  graphLineColor: Theme.of(context).extension<CustomColors>()!.red ?? context.secondary,
                  iconData: MdiIcons.arrowTopRight,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
