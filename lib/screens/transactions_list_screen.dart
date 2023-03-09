import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/transactions_provider.dart';
import '../utils/styling.dart';
import '../widgets/home_transaction_item.dart';

class TransactionsListScreen extends StatefulWidget {
  const TransactionsListScreen({Key? key}) : super(key: key);

  static const routeName = "/transactions";

  @override
  State<TransactionsListScreen> createState() => _TransactionsListScreenState();
}

class _TransactionsListScreenState extends State<TransactionsListScreen> {
  Future? _transactionsFuture;

  Future _obtainTransactionsFuture() {
    return Provider.of<Transactions>(context, listen: false)
        .getAllTransactionsFilteredByDate("", "");
  }

  @override
  void initState() {
    super.initState();
    _transactionsFuture = _obtainTransactionsFuture();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your transactions",
          style: TextStyle(color: Styles.whiteColor, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Styles.accentColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('This is a snackbar')));
            },
          ),
        ],
      ),
      backgroundColor: Styles.primaryColor,
      body: FutureBuilder(
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
                itemCount: transactionData.transactions.length,
                itemBuilder: (ctx, index) =>
                    HomeTransactionItem(transactionData.transactions[index]),
              ),
            );
          }
        },
      ),
    );
  }
}
