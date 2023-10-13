import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LoginMethodsDivider extends StatelessWidget {
  const LoginMethodsDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 0.5,
            color: Colors.grey[400],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            'orContinueWith'.tr(),
            style: TextStyle(color: Colors.grey[700]),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 0.5,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }
}
