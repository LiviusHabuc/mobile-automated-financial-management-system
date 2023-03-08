import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:mobile_automated_financial_management_system/screens/account_management_screen.dart';
import 'package:mobile_automated_financial_management_system/screens/investment_recommendations_screen.dart';
import 'package:mobile_automated_financial_management_system/screens/statistics_screen.dart';

import '../utils/styling.dart';
import 'home_screen.dart';
import 'transactions_list_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  static final List<Widget> _pages = [
    const HomeScreen(),
    const TransactionsListScreen(),
    const InvestmentRecommendationsScreen(),
    const StatisticsScreen(),
    const AccountManagementScreen(),
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedPageIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Styles.primaryWithOpacityColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedLabelStyle: TextStyle(
          fontSize: 20,
          color: Styles.primaryColor,
        ),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Styles.blueColor,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(IconlyBold.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sync_alt),
            label: "Transactions",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.query_stats),
            label: "InvestmentRecommendations",
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyBold.chart),
            label: "Statistics",
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyBold.profile),
            label: "AccountManagement",
          ),
        ],
      ),
    );
  }
}
