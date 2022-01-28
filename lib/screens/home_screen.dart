import 'package:divide_ai/enums/transaction_type_enum.dart';
import 'package:divide_ai/providers/authentication_provider.dart';
import 'package:divide_ai/screens/new_bill_screen.dart';
import 'package:divide_ai/widgets/status_card.dart';
import 'package:divide_ai/widgets/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Consumer<AuthenticationProvider>(
                builder: (context, authentication, child) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (authentication.currentUser!.firebaseUser.photoURL != null) ...[
                        CircleAvatar(
                          backgroundImage: NetworkImage(authentication.currentUser!.firebaseUser.photoURL!),
                          backgroundColor: Colors.grey[200],
                          maxRadius: 22,
                        ),
                      ],
                      const SizedBox(width: 4,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Boa tarde,', // TODO: change message dynamicly
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              authentication.currentUser!.firebaseUser.displayName!,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: authentication.signOut,
                        icon: const Icon(Icons.logout),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: const [
                  Expanded(
                    flex: 1,
                    child: StatusCard(
                      transactionType: TransactionType.income,
                      amount: 145.4,
                      label: 'A receber',
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    flex: 1,
                    child: StatusCard(
                      transactionType: TransactionType.spent,
                      amount: 78,
                      label: 'A pagar',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const NewBillScreen(),
                    ),
                  );
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey[200]!),
                  overlayColor:
                      MaterialStateProperty.all<Color>(Colors.grey[300]!),
                ),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                      Text(
                        'Dividir nova conta',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 26,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Últimas movimentações',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.chevron_right_rounded,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  TransactionTile(
                    transactionType: TransactionType.income,
                    transactionName: 'Rolê de domingo',
                    transactionDate: DateTime.now(),
                    transactionAmount: 59.9,
                  ),
                  TransactionTile(
                    transactionType: TransactionType.income,
                    transactionName: 'Fut de domingo',
                    transactionDate: DateTime.now(),
                    transactionAmount: 11.5,
                  ),
                  TransactionTile(
                    transactionType: TransactionType.spent,
                    transactionName: 'Churrasco do vini',
                    transactionDate: DateTime.now(),
                    transactionAmount: 25.7,
                  ),
                  TransactionTile(
                    transactionType: TransactionType.income,
                    transactionName: 'Férias na praia',
                    transactionDate: DateTime.now(),
                    transactionAmount: 78,
                  ),
                  TransactionTile(
                    transactionType: TransactionType.spent,
                    transactionName: 'Fut de domingo',
                    transactionDate: DateTime.now(),
                    transactionAmount: 10,
                  ),
                  TransactionTile(
                    transactionType: TransactionType.spent,
                    transactionName: 'Pizzaria',
                    transactionDate: DateTime.now(),
                    transactionAmount: 40.5,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
