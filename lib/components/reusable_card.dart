import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final iconData;
  final startingColor;
  final endingColor;
  final number;
  final title;

  ReusableCard(
      {this.iconData,
      this.number,
      this.startingColor,
      this.endingColor,
      this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              stops: [0.2, 1], colors: [startingColor, endingColor]),
          //Color(0xFFFEE3CE)
        ),
        child: ListTile(
          leading: iconData,
          title: Text(number),
          subtitle: Text(title),
        ),
      ),
    );
  }
}
