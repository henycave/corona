import 'package:flutter/material.dart';
import 'package:corona/components/round_icon_button.dart';
import 'package:corona/constants.dart';

class ReusableSingleDataCard extends StatelessWidget {
  final IconData icon;
  final String number;
  final String title;
  final Color color;
  final Color iconColor;

  ReusableSingleDataCard(
      {this.icon, this.number, this.title, this.color, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: color,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RoundIconButton(
              icon: icon,
              color: iconColor,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              number,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: KSelectedButtonTextColor),
            ),
            SizedBox(
              height: 3,
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}
