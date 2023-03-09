import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/transactions_provider.dart' as tr;
import '../utils/styling.dart';

class HomeTransactionItem extends StatefulWidget {
  final tr.TransactionItem transaction;

  HomeTransactionItem(this.transaction);

  @override
  State<HomeTransactionItem> createState() => _HomeTransactionItemState();
}

class _HomeTransactionItemState extends State<HomeTransactionItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      minLeadingWidth: 10,
      minVerticalPadding: 20,
      contentPadding: const EdgeInsets.all(0),
      leading: Container(
          width: 40,
          height: 40,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Styles.primaryWithOpacityColor,
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
          )),
      title: Text(
        widget.transaction.description,
        style: TextStyle(
          color: Styles.whiteColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        DateFormat("HH:mm, dd MMM yyyy").format(widget.transaction.completedAt),
        style: TextStyle(
          color: Styles.whiteColor.withOpacity(0.7),
        ),
      ),
      trailing: Text(
        "-${widget.transaction.value.toStringAsFixed(2)}",
        style: const TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
      ),
    );
  }
}
