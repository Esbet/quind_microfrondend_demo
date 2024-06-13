import 'package:flutter/material.dart';
import 'package:quind_demo_project/core/theme/fonts.dart';

import '../theme/colors.dart';

class SimpleAppbar extends StatelessWidget {
  const SimpleAppbar({super.key, required this.message, this.back});

final String message;
final String? back;

  @override
  Widget build(BuildContext context) {
    return AppBar(
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        if (back == null) {
          if (Navigator.canPop(context)) {
            FocusScope.of(context).unfocus();
            Navigator.pop(context);
          } else {
            Navigator.of(context, rootNavigator: true).pop(context);
          }
        }
      },
      color: secondColor,
    ),
    title: Text(
      message,
      style: textBlackStyleSubTitle,
    ),
  );
  }
}