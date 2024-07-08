import 'package:flutter/material.dart';
import 'package:quind_demo_project/core/theme/fonts.dart';
import 'package:quind_demo_project/microfronts/home/pages/home_page.dart';

import '../theme/colors.dart';

AppBar simpleAppBar(BuildContext context, String message, String? back) {
  return AppBar(
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
     
            Navigator.pushReplacementNamed(context, HomePage.routeName);
       
      },
      color: secondColor,
    ),
    title: Text(
      message,
      style: textBlackStyleSubTitle,
    ),
  );
}
