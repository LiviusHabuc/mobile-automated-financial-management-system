import 'package:flutter/material.dart';
import 'package:mobile_automated_financial_management_system/widgets/home_transactions.dart';

import '../utils/styling.dart';
import '../widgets/credit_card.dart';
import '../widgets/home_greeting.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Styles.primaryColor,
      elevation: 0,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.44,
            color: Styles.primaryColor,
          ),
          ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            children: [
              const SizedBox(
                height: 50,
              ),
              const HomeGreeting(),
              const SizedBox(
                height: 25,
              ),
              const CreditCard(),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Last transactions",
                    style: TextStyle(
                      color: Styles.whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              HomeTransactions(),
            ],
          ),
        ],
      ),
    );
  }
}
