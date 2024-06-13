import 'package:flutter/material.dart';
import 'package:quind_demo_project/core/theme/fonts.dart';

import '../theme/colors.dart';

AppBar simpleAppBar(BuildContext context, String message, String? back) {
  return AppBar(
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
     
            Navigator.pop(context);
       
      },
      color: secondColor,
    ),
    title: Text(
      message,
      style: textBlackStyleSubTitle,
    ),
  );
}
