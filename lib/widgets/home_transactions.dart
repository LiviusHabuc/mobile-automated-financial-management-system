import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/transactions_provider.dart' show Transactions;
import '../utils/styling.dart';
import '../widgets/home_transaction_item.dart';

class HomeTransactions extends StatefulWidget {
  const HomeTransactions({Key? key}) : super(key: key);

  @override
  State<HomeTransactions> createState() => _HomeTransactionsState();
}

class _HomeTransactionsState extends State<HomeTransactions> {
  Future? _transactionsFuture;

  Future _obtainTransactionsFuture() {
    return Provider.of<Transactions>(context, listen: false).getAllTransactions();
  }

  @override
  void initState() {
    super.initState();
    _transactionsFuture = _obtainTransactionsFuture();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: FutureBuilder(
        future: _transactionsFuture,
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (dataSnapshot.error != null) {
            // Error handling
            return Center(
              child: Text(
                "Could not fetch your transactions :(",
                style: TextStyle(
                  color: Styles.whiteColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else {
            return Consumer<Transactions>(
              builder: (ctx, transactionData, child) => ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) =>
                    TransactionItem(transactionData.transactions[index]),
              ),
            );
          }
        },
      ),
    );
  }
}
