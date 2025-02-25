import 'package:flutter/material.dart';

import '../style/app_color.dart';

class AppBarBlur extends StatelessWidget {
  const AppBarBlur({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.blueTop.withOpacity(0.07),
            spreadRadius: 20,
            blurRadius: 10,
          ),
        ],
      ),
    );
  }
}
