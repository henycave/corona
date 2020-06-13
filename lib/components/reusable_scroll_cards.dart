import 'package:flutter/material.dart';
import 'package:corona/constants.dart';

class ReusableScrollCards extends StatelessWidget {
  final color;
  final flag;
  final countryName;
  final overallCount;
  final todayCount;
  final Function onTap;

  ReusableScrollCards({
    this.color,
    this.countryName,
    this.flag,
    this.overallCount,
    this.todayCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 12).copyWith(bottom: 5, left: 5),
        padding: EdgeInsets.all(15),
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network(
                  flag,
                  width: 30,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  countryName,
                  style: KMediumTextStyle.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text(
              'Overall',
              style: KMediumTextStyle,
            ),
            Text(
              overallCount,
              style: KCardTextStyle.copyWith(
                fontWeight: FontWeight.bold,
                color: Color(0xFFAB4D32),
              ),
            ),
            Text(
              'Today',
              style: KMediumTextStyle,
            ),
            Text(
              todayCount,
              style: KCardTextStyle.copyWith(
                fontWeight: FontWeight.bold,
                color: Color(0xFFAB4D32),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
