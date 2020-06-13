import 'package:flutter/material.dart';

class ReusableRawMaterialButton extends StatelessWidget {
  final text;
  final fillColor;
  final textColor;
  final radius;
  final horizontalPadding;
  final Function onPressed;

  ReusableRawMaterialButton(
      {this.fillColor,
      this.radius,
      this.text,
      this.textColor,
      this.onPressed,
      this.horizontalPadding});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: text,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      fillColor: fillColor,
      textStyle: TextStyle(color: textColor),
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      onPressed: onPressed,
    );
  }
}
