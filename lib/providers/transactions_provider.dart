import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/env.dart';

class TransactionItem {
  final String id;

  final String type;

  final String state;

  final DateTime createdAt;

  final DateTime completedAt;

  final String description;

  final String customerEmail;

  final double value;

  final String currency;

  TransactionItem({
    required this.id,
    required this.type,
    required this.state,
    required this.createdAt,
    required this.completedAt,
    required this.description,
    required this.customerEmail,
    required this.value,
    required this.currency,
  });
}

class Transactions with ChangeNotifier {
  List<TransactionItem> _transactions = [];

  final String? userEmail;

  Transactions(this._transactions, this.userEmail);

  List<TransactionItem> get transactions {
    return [..._transactions];
  }

  Future<void> getHomeTransactions() async {
    final response = await http.get(
      Uri.parse("${Env.revoSandboxURL}/orders?email=$userEmail&limit=4"),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${Env.revoSandboxAPIKey}",
      },
    );

    if (json.decode(response.body) == null) {
      return;
    }

    final extractedData = json.decode(response.body) as List<dynamic>;
    final List<TransactionItem> loadedTransactions = [];

    for (var transaction in extractedData) {
        if (transaction["type"] == "PAYMENT" && transaction["state"] == "COMPLETED") {
          loadedTransactions.add(TransactionItem(
              id: transaction["id"],
              type: transaction["type"],
              state: transaction["state"],
              createdAt: DateTime.parse(transaction["created_at"]),
              completedAt: DateTime.parse(transaction["completed_at"]),
              description: transaction["description"],
              customerEmail: transaction["email"],
              value: transaction["order_amount"]["value"] / 100,
              currency: transaction["order_amount"]["currency"]));
        }
    }

    _transactions = loadedTransactions.toList();
    notifyListeners();
  }

  Future<void> getAllTransactionsFilteredByDate(String from, String to) async {
    String url = "${Env.revoSandboxURL}/orders?email=$userEmail";

    if (from != "") {
      url = "$url&from_created_date=$from";
    }
    if (to != "") {
      url = "$url&to_created_date=$to";
    }

    final response = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${Env.revoSandboxAPIKey}",
      },
    );

    if (json.decode(response.body) == null) {
      return;
    }

    final extractedData = json.decode(response.body) as List<dynamic>;
    final List<TransactionItem> loadedFilteredTransactions = [];

    for (var transaction in extractedData) {
      if (transaction["type"] == "PAYMENT" && transaction["state"] == "COMPLETED") {
        loadedFilteredTransactions.add(TransactionItem(
            id: transaction["id"],
            type: transaction["type"],
            state: transaction["state"],
            createdAt: DateTime.parse(transaction["created_at"]),
            completedAt: DateTime.parse(transaction["completed_at"]),
            description: transaction["description"],
            customerEmail: transaction["email"],
            value: transaction["order_amount"]["value"] / 100,
            currency: transaction["order_amount"]["currency"]));
      }
    }

    _transactions = loadedFilteredTransactions.toList();
    notifyListeners();
  }
}
