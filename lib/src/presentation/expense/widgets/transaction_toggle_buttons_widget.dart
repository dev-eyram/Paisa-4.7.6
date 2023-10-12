import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/common.dart';
import '../../../core/enum/transaction_type.dart';
import '../../widgets/sika_purse_pill_chip.dart';
import '../bloc/expense_bloc.dart';

class TransactionToggleButtons extends StatelessWidget {
  const TransactionToggleButtons({Key? key}) : super(key: key);

  void _update(BuildContext context, TransactionType type) {
    BlocProvider.of<ExpenseBloc>(context).add(ChangeExpenseEvent(type));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseBloc, ExpenseState>(
      buildWhen: (previous, current) => current is ChangeTransactionTypeState,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SikaPursePillChip(
                  title: TransactionType.expense.stringName(context),
                  isSelected: BlocProvider.of<ExpenseBloc>(context).transactionType == TransactionType.expense,
                  onPressed: () => _update(context, TransactionType.expense),
                ),
                SikaPursePillChip(
                  title: TransactionType.income.stringName(context),
                  isSelected: BlocProvider.of<ExpenseBloc>(context).transactionType == TransactionType.income,
                  onPressed: () => _update(context, TransactionType.income),
                ),
                SikaPursePillChip(
                  title: TransactionType.transfer.stringName(context),
                  isSelected: BlocProvider.of<ExpenseBloc>(context).transactionType == TransactionType.transfer,
                  onPressed: () => _update(context, TransactionType.transfer),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
