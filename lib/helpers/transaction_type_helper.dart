import 'package:divide_ai/enums/transaction_type_enum.dart';
import 'package:flutter/material.dart';

class TransactionTypeHelper {
  static IconData getIconByTransactionType(TransactionType transactionType) {
    switch (transactionType) {
      case TransactionType.spent:
        return Icons.arrow_circle_down_rounded;
      case TransactionType.income:
        return Icons.arrow_circle_up_rounded;
    }
  }

  static Color getColorByTransactionType(
    BuildContext context,
    TransactionType transactionType,
  ) {
    switch (transactionType) {
      case TransactionType.spent:
        return const Color(0xFFFF1865);
      case TransactionType.income:
        return Theme.of(context).primaryColor;
    }
  }
}
