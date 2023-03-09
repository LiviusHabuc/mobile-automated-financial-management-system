import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_automated_financial_management_system/widgets/transactions_list_item_details.dart';

import '../providers/transactions_provider.dart' as tr;
import '../utils/styling.dart';

class TransactionsListItem extends StatefulWidget {
  final tr.TransactionItem transaction;

  TransactionsListItem(this.transaction);

  @override
  State<TransactionsListItem> createState() => _TransactionsListItemState();
}

class _TransactionsListItemState extends State<TransactionsListItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: _expanded ? 220 : 85,
      child: Card(
        margin: const EdgeInsets.all(10),
        color: Styles.accentColor,
        child: Column(
          children: [
            ListTile(
              leading: Container(
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Styles.accentColor,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 1),
                      color: Colors.white.withOpacity(0.1),
                      blurRadius: 2,
                      spreadRadius: 1,
                    ),
                  ],
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Color(0xFFFF736C),
                  size: 20,
                ),
              ),
              tileColor: Styles.primaryWithOpacityColor,
              textColor: Styles.whiteColor,
              title: Text(widget.transaction.description),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("-${widget.transaction.value.toStringAsFixed(2)}"),
                  Text(DateFormat("HH:mm, dd MMM yyyy").format(widget.transaction.createdAt)),
                ],
              ),
              trailing: IconButton(
                icon: Icon(
                  _expanded ? Icons.expand_less : Icons.expand_more,
                  color: Styles.whiteColor,
                ),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 4,
              ),
              height: _expanded ? 130 : 0,
              decoration: BoxDecoration(color: Styles.primaryWithOpacityColor),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  TransactionListItemDetails("Currency", widget.transaction.currency),
                  TransactionListItemDetails("Type", widget.transaction.type),
                  TransactionListItemDetails("State", widget.transaction.state),
                  TransactionListItemDetails(
                    "Created at",
                    DateFormat("HH:mm, dd MMM yyyy").format(widget.transaction.createdAt),
                  ),
                  TransactionListItemDetails(
                    "Completed at",
                    DateFormat("HH:mm, dd MMM yyyy").format(widget.transaction.completedAt),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
