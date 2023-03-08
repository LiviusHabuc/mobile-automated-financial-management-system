import 'package:flutter/material.dart';
import 'package:mobile_automated_financial_management_system/widgets/home_transactions.dart';

class TransactionsListScreen extends StatefulWidget {

  const TransactionsListScreen({Key? key}) : super(key: key);

  static const routeName = "/transactions";

  @override
  State<TransactionsListScreen> createState() => _TransactionsListScreenState();
}

class _TransactionsListScreenState extends State<TransactionsListScreen> {
  @override
  Widget build(BuildContext context) {
    return HomeTransactions();
  }
}
