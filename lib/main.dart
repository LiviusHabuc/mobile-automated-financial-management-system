import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/transactions_list_screen.dart';
import './screens/tabs_screen.dart';
import '../providers/transactions_provider.dart';
import '../screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Transactions([], "livius@test.com"),
        ),
      ],
      child: Consumer(
        builder: (ctx, auth, _) => MaterialApp(
          title: "Automated Financial Management System",
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: TabsScreen(),
          routes: {
            HomeScreen.routeName: (ctx) => HomeScreen(),
            TransactionsListScreen.routeName: (ctx) => TransactionsListScreen(),
          },
        ),
      ),
    );
  }
}
