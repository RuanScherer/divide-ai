import 'package:divide_ai/enums/transaction_type_enum.dart';
import 'package:divide_ai/helpers/transaction_type_helper.dart';
import 'package:flutter/material.dart';

class StatusCard extends StatelessWidget {
  final TransactionType transactionType;
  final String label;
  final double amount;

  const StatusCard({
    Key? key,
    required this.transactionType,
    required this.label,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 30,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: TransactionTypeHelper.getColorByTransactionType(
            context,
            transactionType,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                TransactionTypeHelper.getIconByTransactionType(transactionType),
                size: 40,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                const Text(
                  'R\$',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Text(
                    amount.toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
