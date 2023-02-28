import 'package:flutter/material.dart';

import '../utils/styling.dart';

class HomeTransactions extends StatelessWidget {
  const HomeTransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: 1,
        itemBuilder: (context, index) {
          // final lastThreeTransactions = transactions[index];
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
                image: index == 0
                    ? null
                    : DecorationImage(
                        image: AssetImage(""),
                        fit: BoxFit.cover,
                      ),
                shape: BoxShape.circle,
              ),
              child: index == 0
                  ? Icon(
                      Icons.arrow_forward,
                      color: const Color(0xFFFF736C),
                      size: 20,
                    )
                  : const SizedBox(),
            ),
            title: Text(
              "Food & Drinks",
              style: TextStyle(color: Styles.whiteColor, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              "14:05 01/03/2023",
              style: TextStyle(
                color: Styles.whiteColor.withOpacity(0.7),
              ),
            ),
            trailing: Text(
              "-225",
              style: const TextStyle(fontSize: 17, color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
