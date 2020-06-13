import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;

  RoundIconButton({@required this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(icon),
      elevation: 6.0,
      shape: CircleBorder(),
      fillColor: color,
      constraints: BoxConstraints.tightFor(
        width: 46.0,
        height: 46.0,
      ),
    );
  }
}
