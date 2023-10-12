import 'package:injectable/injectable.dart';
import 'package:sika_purse/src/core/enum/recurring_type.dart';
import 'package:sika_purse/src/core/enum/transaction_type.dart';
import 'package:sika_purse/src/domain/recurring/repository/recurring_repository.dart';

@singleton
class AddRecurringUseCase {
  AddRecurringUseCase(this.repository);

  final RecurringRepository repository;

  Future<void> call(
    String name,
    double amount,
    DateTime recurringTime,
    RecurringType recurringType,
    int selectedAccountId,
    int selectedCategoryId,
    TransactionType transactionType,
  ) {
    return repository.addRecurringEvent(
      name,
      amount,
      recurringTime,
      recurringType,
      selectedAccountId,
      selectedCategoryId,
      transactionType,
    );
  }
}
