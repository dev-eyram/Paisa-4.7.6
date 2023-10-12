import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sika_purse/src/core/common.dart';

import '../../../../main.dart';
import '../../../data/accounts/model/account_model.dart';
import '../../../domain/account/entities/account.dart';

class PillsAccountWidget extends StatefulWidget {
  const PillsAccountWidget({
    super.key,
    required this.accountSelected,
  });

  final Function(Account) accountSelected;

  @override
  State<PillsAccountWidget> createState() => _PillsAccountWidgetState();
}

class _PillsAccountWidgetState extends State<PillsAccountWidget> {
  late int selectedAccount = -1;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<AccountModel>>(
      valueListenable: getIt.get<Box<AccountModel>>().listenable(),
      builder: (context, value, child) {
        final accounts = value.values.toEntities();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Wrap(
            spacing: 4.0,
            runSpacing: 8.0,
            children: List.generate(
              accounts.length,
              (index) {
                final Account account = accounts[index];
                return SikaPurseFilterChip(
                  title: account.bankName,
                  onPressed: () {
                    setState(() {
                      if (selectedAccount == account.superId) {
                        selectedAccount = -1;
                      } else {
                        selectedAccount = account.superId ?? -1;
                      }
                      widget.accountSelected(account);
                    });
                  },
                  isSelected: account.superId == selectedAccount,
                  icon: account.cardType!.icon.codePoint,
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class SikaPurseFilterChip extends StatelessWidget {
  const SikaPurseFilterChip({
    super.key,
    required this.title,
    required this.onPressed,
    required this.isSelected,
    required this.icon,
  });

  final int icon;
  final bool isSelected;
  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        selected: isSelected,
        onSelected: (value) {
          onPressed.call();
        },
        avatar: Icon(
          color: isSelected ? context.primary : context.onSurfaceVariant,
          IconData(
            icon,
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
        label: Text(title),
        labelStyle: context.titleMedium?.copyWith(color: isSelected ? context.primary : context.onSurfaceVariant),
        padding: const EdgeInsets.all(12),
      ),
    );
  }
}
