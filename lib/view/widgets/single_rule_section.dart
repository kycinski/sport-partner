import 'package:flutter/material.dart';

class SingleRuleSection extends StatelessWidget {
  const SingleRuleSection({super.key, required this.ruleTitle, required this.ruleDescription});

  final String ruleTitle;
  final String ruleDescription;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ruleTitle,
            style: const TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            ruleDescription,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}
