import 'package:divide_ai/enums/transaction_type_enum.dart';
import 'package:divide_ai/helpers/transaction_type_helper.dart';
import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  final TransactionType transactionType;
  final String transactionName;
  final DateTime transactionDate;
  final double transactionAmount;

  const TransactionTile({
    Key? key,
    required this.transactionType,
    required this.transactionName,
    required this.transactionDate,
    required this.transactionAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 4,
      ),
      leading: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          TransactionTypeHelper.getIconByTransactionType(transactionType),
          size: 32,
          color: TransactionTypeHelper.getColorByTransactionType(
            context,
            transactionType,
          ),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            transactionName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            transactionDate.day.toString() +
                '/' +
                transactionDate.month.toString() +
                "/" +
                transactionDate.year.toString(),
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
      trailing: Text(
        'R\$${transactionAmount.toStringAsFixed(2)}',
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
