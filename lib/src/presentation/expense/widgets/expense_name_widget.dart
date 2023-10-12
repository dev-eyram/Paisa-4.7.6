import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sika_purse/src/core/common.dart';

import '../../widgets/sika_purse_text_field.dart';
import '../bloc/expense_bloc.dart';

class ExpenseNameWidget extends StatelessWidget {
  const ExpenseNameWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseBloc, ExpenseState>(
      buildWhen: (oldState, newState) => newState is ChangeTransactionTypeState,
      builder: (context, state) {
        if (state is ChangeTransactionTypeState) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SikaPurseTextFormField(
              maxLines: 1,
              controller: controller,
              hintText: state.transactionType.hintName(context),
              keyboardType: TextInputType.name,
              inputFormatters: [
                FilteringTextInputFormatter.singleLineFormatter,
              ],
              validator: (value) {
                if (value!.isNotEmpty) {
                  return null;
                } else {
                  return context.loc.validName;
                }
              },
              onChanged: (value) => BlocProvider.of<ExpenseBloc>(context).expenseName = value,
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
