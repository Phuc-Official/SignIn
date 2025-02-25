import 'package:flutter/material.dart';

import '../style/app_style.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {super.key,
      required this.title,
      required this.onPressed,
      this.colorText,
      this.colorButton,
      this.borderCircular});
  final String title;
  final Function onPressed;
  final Color? colorText;
  final Color? colorButton;
  final double? borderCircular;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorButton ?? Color(0xff007DC0),
        borderRadius: BorderRadius.circular(borderCircular ?? 8),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent),
        onPressed: () {
          onPressed();
        },
        child: Text(
          title,
          style: styleS16W5(colorText ?? Colors.white),
        ),
      ),
    );
  }
}
